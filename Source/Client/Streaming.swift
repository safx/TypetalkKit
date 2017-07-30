

//
//  Client+Streaming.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import Starscream


public typealias AddTalkPostEvent                = TalkPost
public typealias CreateTalkEvent                 = TalkPost
public typealias CreateTopicEvent                = TopicWithUserInfo
public typealias DeleteMessageEvent              = PostMessageResponse
public typealias DeleteTalkEvent                 = TalkPost
public typealias DeleteTopicEvent                = Topic
public typealias FavoriteTopicEvent              = TopicWithUserInfo // FIXME: unread should be omitted.
public typealias JoinTopicsEvent                 = GetTopicsResponse
public typealias LikeMessageEvent                = LikeMessageResponse
public typealias NotifyMentionEvent              = SaveReadMentionResponse
public typealias PostMessageEvent                = PostMessageResponse
public typealias ReadMentionEvent                = SaveReadMentionResponse
public typealias RemoveTalkPostEvent             = TalkPost
public typealias RequestTeamInviteEvent          = TeamInvite
public typealias RequestTopicInviteEvent         = TopicInvite
public typealias SaveBookmarkEvent               = SaveReadTopicResponse
public typealias UnfavoriteTopicEvent            = TopicWithUserInfo // FIXME: unread should be omitted.
public typealias UnlikeMessageEvent              = LikeMessageResponse
public typealias UpdateNotificationAccessEvent   = NotificationStatus
public typealias UpdateTalkEvent                 = TalkPost
public typealias UpdateTopicEvent                = Topic


extension TypetalkAPI {

    static fileprivate var sharedStream : TypetalkStream {
        struct Static {
            static let instance = TypetalkStream()
        }
        return Static.instance
    }

    public static func streaming(_ closure: @escaping (StreamingEvent) -> ()) -> Bool {
        guard let accessToken = accessToken else {
            return false
        }
        sharedStream.connect(accessToken, closure: closure)
        return true
    }

}

// MARK: Typetalk Streaming API

final private class TypetalkStream : WebSocketDelegate {
    fileprivate typealias EventClosure = (StreamingEvent) -> ()

    fileprivate let socket = WebSocket(url: URL(string: TypetalkAPI.apiURLString + "streaming")!)
    fileprivate var streamingClosure: EventClosure?

    fileprivate func connect(_ accessToken: String, closure: @escaping EventClosure) {
        streamingClosure = closure
        socket.headers["Authorization"] = "Bearer \(accessToken)"
        socket.delegate = self
        socket.connect()
    }

    fileprivate var isConnected : Bool {
        return socket.isConnected
    }

    // MARK: WebSocketDelegate funcs

    fileprivate func sendStreamEventIfPossible(_ event: StreamingEvent) {
        if let c = streamingClosure {
            c(event)
        }
    }

    fileprivate func websocketDidConnect(socket: WebSocket) {
        sendStreamEventIfPossible(.connected)
    }

    fileprivate func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        sendStreamEventIfPossible(.disconnected(error))
    }

    fileprivate func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        let decoder = JSONDecoder()
        do {
            let jsonData = text.data(using: .utf8)!
            if let eventType = try? decoder.decode(StreamEventTypeChecker.self, from: jsonData) {
                if let ev = try StreamingEvent.parse(type: eventType.type, data: jsonData) {
                    sendStreamEventIfPossible(ev)
                }
            }
        } catch {
            print(error)
        }
    }

    fileprivate func websocketDidReceiveData(socket: WebSocket, data: Data) {
        fatalError("Never be called")
    }

}

fileprivate struct StreamEventTypeChecker: Decodable {
    let type: String
}

