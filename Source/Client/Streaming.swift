//
//  Client+Streaming.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import Starscream



public typealias AcceptTeamInviteEvent           = AcceptTeamInviteResponse
public typealias AcceptTopicInviteEvent          = AcceptTopicInviteResponse
public typealias AddTalkPostEvent                = TalkPost
public typealias CancelTopicInviteEvent          = AcceptTopicInviteResponse
public typealias CreateTalkEvent                 = TalkPost
public typealias CreateTopicEvent                = TopicWithUserInfo
public typealias DeclineTeamInviteEvent          = DeclineTeamInviteResponse
public typealias DeclineTopicInviteEvent         = AcceptTopicInviteResponse
public typealias DeleteMessageEvent              = PostMessageResponse
public typealias DeleteTalkEvent                 = TalkPost
public typealias DeleteTopicEvent                = Topic
public typealias FavoriteTopicEvent              = TopicWithUserInfo // FIXME: unread should be omitted.
public typealias JoinTopicsEvent                 = GetTopicsResponse
public typealias LeaveTopicsEvent                = AcceptTeamInviteResponse // FIXME: invite should be omitted.
public typealias LikeMessageEvent                = LikeMessageResponse
public typealias NotifyMentionEvent              = SaveReadMentionResponse
public typealias PostMessageEvent                = PostMessageResponse
//public typealias PostLinksEvent
public typealias ReadMentionEvent                = SaveReadMentionResponse
public typealias RemoveTalkPostEvent             = TalkPost
public typealias RequestTeamInviteEvent          = Invite // TeamInvite
public typealias RequestTopicInviteEvent         = Invite // TopicInvite
public typealias SaveBookmarkEvent               = SaveReadTopicResponse
public typealias UnfavoriteTopicEvent            = TopicWithUserInfo // FIXME: unread should be omitted.
public typealias UnlikeMessageEvent              = LikeMessageResponse
public typealias UpdateNotificationAccessEvent   = NotificationStatus
public typealias UpdateTalkEvent                 = TalkPost
public typealias UpdateTopicEvent                = Topic


extension TypetalkAPI {

    static private var sharedStream : TypetalkStream {
        struct Static {
            static let instance = TypetalkStream()
        }
        return Static.instance
    }

    public static func streaming(closure: StreamingEvent -> ()) -> Bool {
        guard let accessToken = accessToken else {
            return false
        }
        sharedStream.connect(accessToken, closure: closure)
        return true
    }

}

// MARK: Typetalk Streaming API

final private class TypetalkStream : WebSocketDelegate {
    private typealias EventClosure = StreamingEvent -> ()

    private let socket = WebSocket(url: NSURL(string: TypetalkAPI.apiURLString + "streaming")!)
    private var streamingClosure: EventClosure?

    private func connect(accessToken: String, closure: EventClosure) {
        streamingClosure = closure
        socket.headers["Authorization"] = "Bearer \(accessToken)"
        socket.delegate = self
        socket.connect()
    }

    private var isConnected : Bool {
        return socket.isConnected
    }

    // MARK: WebSocketDelegate funcs

    private func sendStreamEventIfPossible(event: StreamingEvent) {
        if let c = streamingClosure {
            c(event)
        }
    }

    private func websocketDidConnect(socket: WebSocket) {
        sendStreamEventIfPossible(.Connected)
    }

    private func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        sendStreamEventIfPossible(.Disconnected(error))
    }

    private func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        let jsondata = text.dataUsingEncoding(NSUnicodeStringEncoding)!
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsondata, options: []) as! [String:AnyObject]
            let type = json["type"] as? String
            let data = json["data"] as? [String:AnyObject]
            if type != nil && data != nil {
                if let ev = try StreamingEvent.parse(type!, data: data!) {
                    sendStreamEventIfPossible(ev)
                } else {

                }
            }
        } catch {
            print(error)
        }
    }

    private func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        fatalError("Never be called")
    }

}
