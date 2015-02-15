//
//  Client+Streaming.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import TypetalkKit
import Starscream


public typealias AcceptTeamInviteEvent           = AcceptTeamInviteResponse
public typealias AddTalkPostEvent                = TalkPost
public typealias CreateTalkEvent                 = TalkPost
public typealias CreateTopicEvent                = TopicWithUserInfo
public typealias DeclineTeamInviteEvent          = AcceptTeamInviteResponse
public typealias DeleteMessageEvent              = PostMessageResponse
public typealias DeleteTalkEvent                 = TalkPost
public typealias DeleteTopicEvent                = Topic
public typealias FavoriteTopicEvent              = TopicWithUserInfo // FIXME: unread should be omitted.
public typealias JoinTopicsEvent                 = GetTopicsResponse
public typealias LeaveTopicsEvent                = AcceptTeamInviteResponse // FIXME: invite should be omitted.
public typealias LikeMessageEvent                = LikeMessageResponse
public typealias NotifyMentionEvent              = SaveReadMentionResponse
public typealias PostMessageEvent                = PostMessageResponse
public typealias ReadMentionEvent                = SaveReadMentionResponse
public typealias RemoveTalkPostEvent             = TalkPost
public typealias RequestTeamInviteEvent          = Invite
public typealias SaveBookmarkEvent               = SaveReadTopicResponse
public typealias UnfavoriteTopicEvent            = TopicWithUserInfo // FIXME: unread should be omitted.
public typealias UnlikeMessageEvent              = LikeMessageResponse
public typealias UpdateNotificationAccessEvent   = NotificationStatus
public typealias UpdateTalkEvent                 = TalkPost
public typealias UpdateTopicEvent                = Topic


public enum StreamingEvent {
    case Connect
    case Disconnect(NSError?)

    case AcceptTeamInvite(AcceptTeamInviteEvent)
    case AddTalkPost(AddTalkPostEvent)
    case CreateTalk(CreateTalkEvent)
    case CreateTopic(CreateTopicEvent)
    case DeclineTeamInvite(DeclineTeamInviteEvent)
    case DeleteTalk(DeleteTalkEvent)
    case DeleteTopic(DeleteTopicEvent)
    case DeleteMessage(DeleteMessageEvent)
    case FavoriteTopic(FavoriteTopicEvent)
    case JoinTopics(JoinTopicsEvent)
    case LeaveTopics(LeaveTopicsEvent)
    case LikeMessage(LikeMessageEvent)
    case NotifyMention(NotifyMentionEvent)
    case PostMessage(PostMessageEvent)
    case ReadMention(ReadMentionEvent)
    case RemoveTalkPost(RemoveTalkPostEvent)
    case RequestTeamInvite(RequestTeamInviteEvent)
    case SaveBookmark(SaveBookmarkEvent)
    case UpdateNotificationAccess(UpdateNotificationAccessEvent)
    case UnfavoriteTopic(UnfavoriteTopicEvent)
    case UnlikeMessage(UnlikeMessageEvent)
    case UpdateTalk(UpdateTalkEvent)
    case UpdateTopic(UpdateTopicEvent)

    case Unknown(String, [String:AnyObject])

    init(type: String, data:[String:AnyObject]) {
               if type == "acceptTeamInvite"         { self = .AcceptTeamInvite(AcceptTeamInviteEvent(data: data))
        } else if type == "addTalkPost"              { self = .AddTalkPost(AddTalkPostEvent(data: data))
        } else if type == "createTalk"               { self = .CreateTalk(CreateTalkEvent(data: data))
        } else if type == "createTopic"              { self = .CreateTopic(CreateTopicEvent(data: data))
        } else if type == "declineTeamInvite"        { self = .DeclineTeamInvite(DeclineTeamInviteEvent(data: data))
        } else if type == "deleteTalk"               { self = .DeleteTalk(DeleteTalkEvent(data: data))
        } else if type == "deleteTopic"              { self = .DeleteTopic(DeleteTopicEvent(data: data))
        } else if type == "deleteMessage"            { self = .DeleteMessage(DeleteMessageEvent(data: data))
        } else if type == "favoriteTopic"            { self = .FavoriteTopic(FavoriteTopicEvent(data: data))
        } else if type == "joinTopics"               { self = .JoinTopics(JoinTopicsEvent(data: data))
        } else if type == "leaveTopics"              { self = .LeaveTopics(LeaveTopicsEvent(data: data))
        } else if type == "likeMessage"              { self = .LikeMessage(LikeMessageEvent(data: data))
        } else if type == "notifyMention"            { self = .NotifyMention(NotifyMentionEvent(data: data))
        } else if type == "postMessage"              { self = .PostMessage(PostMessageEvent(data: data))
        } else if type == "readMention"              { self = .ReadMention(ReadMentionEvent(data: data))
        } else if type == "removeTalkPost"           { self = .RemoveTalkPost(RemoveTalkPostEvent(data: data))
        } else if type == "requestTeamInvite"        { self = .RequestTeamInvite(RequestTeamInviteEvent(data: data))
        } else if type == "saveBookmark"             { self = .SaveBookmark(SaveBookmarkEvent(data: data))
        } else if type == "updateNotificationAccess" { self = .UpdateNotificationAccess(UpdateNotificationAccessEvent(data: data))
        } else if type == "unfavoriteTopic"          { self = .UnfavoriteTopic(UnfavoriteTopicEvent(data: data))
        } else if type == "unlikeMessage"            { self = .UnlikeMessage(UnlikeMessageEvent(data: data))
        } else if type == "updateTalk"               { self = .UpdateTalk(UpdateTalkEvent(data: data))
        } else if type == "updateTopic"              { self = .UpdateTopic(UpdateTopicEvent(data: data))
        } else                                       { self = .Unknown(type, data) }
    }
}

// MARK: Typetalk Streaming API

public typealias StreamingEventBlock = (StreamingEvent -> Void)

private var g_streaming_received_block: StreamingEventBlock?

extension Client : WebSocketDelegate {

    private var socket : WebSocket {
        struct Static {
            static let instance = WebSocket(url: Router.Streaming.URLRequest.URL)
        }
        return Static.instance
    }

    private var streamingBlock : StreamingEventBlock? {
        get { return g_streaming_received_block }
        set { g_streaming_received_block = newValue }
    }

    public func streaming(block: StreamingEventBlock) -> Bool {
        switch oauth2.state {
        case .SignedIn(let (credential)):
            self.streamingBlock = block
            socket.headers["Authorization"] = "Bearer \(credential.accessToken)"
            socket.delegate = self
            socket.connect()
            return true
        default:
            return false
        }
    }

    // MARK: WebSocketDelegate funcs

    private func sendStreamEventIfPossible(event: StreamingEvent) {
        if let c = streamingBlock {
            c(event)
        }
    }

    public func websocketDidConnect(socket: WebSocket) {
        sendStreamEventIfPossible(.Connect)
    }

    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        sendStreamEventIfPossible(.Disconnect(error))
    }

    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        let jsondata = text.dataUsingEncoding(NSUnicodeStringEncoding)!
        let json = NSJSONSerialization.JSONObjectWithData(jsondata, options: nil, error: nil) as [String:AnyObject]
        let type = json["type"] as? String
        let data = json["data"] as? [String:AnyObject]
        if type != nil && data != nil {
            //println("text: \(text)")
            sendStreamEventIfPossible(StreamingEvent(type: type!, data: data!))
        }
    }

    public func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        fatalError("Never be called")
    }

}
