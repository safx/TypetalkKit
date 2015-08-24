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


// MARK: Typetalk Streaming API

public class TypetalkStream : WebSocketDelegate {
    public typealias EventClosure = StreamingEvent -> ()

    private var socket: WebSocket!
    internal var streamingClosure: EventClosure?

    public init(accessToken: String, closure: EventClosure) {
        streamingClosure = closure
        socket = WebSocket(url: NSURL(string: TypetalkAPI.apiURLString + "streaming")!)
        socket.headers["Authorization"] = "Bearer \(accessToken)"
        socket.delegate = self
        socket.connect()
    }

    public var isConnected : Bool {
        return socket.isConnected
    }

    // MARK: WebSocketDelegate funcs

    private func sendStreamEventIfPossible(event: StreamingEvent) {
        if let c = streamingClosure {
            c(event)
        }
    }

    public func websocketDidConnect(socket: WebSocket) {
        sendStreamEventIfPossible(.Connected)
    }

    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        sendStreamEventIfPossible(.Disconnected(error))
    }

    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
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

    public func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        fatalError("Never be called")
    }

}
