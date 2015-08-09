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


public enum StreamingEvent {
    case Connected
    case Disconnected(NSError?)

    case AcceptTeamInvite(AcceptTeamInviteEvent)
    case AcceptTopicInvite(AcceptTopicInviteEvent)
    case AddTalkPost(AddTalkPostEvent)
    case CancelTopicInvite(CancelTopicInviteEvent)
    case CreateTalk(CreateTalkEvent)
    case CreateTopic(CreateTopicEvent)
    case DeclineTeamInvite(DeclineTeamInviteEvent)
    case DeclineTopicInvite(DeclineTopicInviteEvent)
    case DeleteTalk(DeleteTalkEvent)
    case DeleteTopic(DeleteTopicEvent)
    case DeleteMessage(DeleteMessageEvent)
    case FavoriteTopic(FavoriteTopicEvent)
    case JoinTopics(JoinTopicsEvent)
    case LeaveTopics(LeaveTopicsEvent)
    case LikeMessage(LikeMessageEvent)
    case NotifyMention(NotifyMentionEvent)
    case PostMessage(PostMessageEvent)
    case PostLinks(PostLinksEvent)
    case ReadMention(ReadMentionEvent)
    case RemoveTalkPost(RemoveTalkPostEvent)
    case RequestTeamInvite(RequestTeamInviteEvent)
    case RequestTopicInvite(RequestTopicInviteEvent)
    case SaveBookmark(SaveBookmarkEvent)
    case UpdateNotificationAccess(UpdateNotificationAccessEvent)
    case UnfavoriteTopic(UnfavoriteTopicEvent)
    case UnlikeMessage(UnlikeMessageEvent)
    case UpdateTalk(UpdateTalkEvent)
    case UpdateTopic(UpdateTopicEvent)

    case Unknown(String, [String:AnyObject])

    init(type: String, data:[String:AnyObject]) throws {
               if type == "acceptTeamInvite"         { self = .AcceptTeamInvite(try AcceptTeamInviteEvent.parseJSON(data))
        } else if type == "acceptTopicInvite"        { self = .AcceptTopicInvite(try AcceptTopicInviteEvent.parseJSON(data))
        } else if type == "addTalkPost"              { self = .AddTalkPost(try AddTalkPostEvent.parseJSON(data))
        } else if type == "cancelTopicInvite"        { self = .CancelTopicInvite(try CancelTopicInviteEvent.parseJSON(data))
        } else if type == "createTalk"               { self = .CreateTalk(try CreateTalkEvent.parseJSON(data))
        } else if type == "createTopic"              { self = .CreateTopic(try CreateTopicEvent.parseJSON(data))
        } else if type == "declineTeamInvite"        { self = .DeclineTeamInvite(try DeclineTeamInviteEvent.parseJSON(data))
        } else if type == "declineTopicInvite"       { self = .DeclineTopicInvite(try DeclineTopicInviteEvent.parseJSON(data))
        } else if type == "deleteTalk"               { self = .DeleteTalk(try DeleteTalkEvent.parseJSON(data))
        } else if type == "deleteTopic"              { self = .DeleteTopic(try DeleteTopicEvent.parseJSON(data))
        } else if type == "deleteMessage"            { self = .DeleteMessage(try DeleteMessageEvent.parseJSON(data))
        } else if type == "favoriteTopic"            { self = .FavoriteTopic(try FavoriteTopicEvent.parseJSON(data))
        } else if type == "joinTopics"               { self = .JoinTopics(try JoinTopicsEvent.parseJSON(data))
        } else if type == "leaveTopics"              { self = .LeaveTopics(try LeaveTopicsEvent.parseJSON(data))
        } else if type == "likeMessage"              { self = .LikeMessage(try LikeMessageEvent.parseJSON(data))
        } else if type == "notifyMention"            { self = .NotifyMention(try NotifyMentionEvent.parseJSON(data))
        } else if type == "postMessage"              { self = .PostMessage(try PostMessageEvent.parseJSON(data))
        } else if type == "postLinks"                { self = .PostLinks(try PostLinksEvent.parseJSON(data))
        } else if type == "readMention"              { self = .ReadMention(try ReadMentionEvent.parseJSON(data))
        } else if type == "removeTalkPost"           { self = .RemoveTalkPost(try RemoveTalkPostEvent.parseJSON(data))
        } else if type == "requestTeamInvite"        { self = .RequestTeamInvite(try RequestTeamInviteEvent.parseJSON(data))
        } else if type == "requestTopicInvite"       { self = .RequestTopicInvite(try RequestTopicInviteEvent.parseJSON(data))
        } else if type == "saveBookmark"             { self = .SaveBookmark(try SaveBookmarkEvent.parseJSON(data))
        } else if type == "updateNotificationAccess" { self = .UpdateNotificationAccess(try UpdateNotificationAccessEvent.parseJSON(data))
        } else if type == "unfavoriteTopic"          { self = .UnfavoriteTopic(try UnfavoriteTopicEvent.parseJSON(data))
        } else if type == "unlikeMessage"            { self = .UnlikeMessage(try UnlikeMessageEvent.parseJSON(data))
        } else if type == "updateTalk"               { self = .UpdateTalk(try UpdateTalkEvent.parseJSON(data))
        } else if type == "updateTopic"              { self = .UpdateTopic(try UpdateTopicEvent.parseJSON(data))
        } else                                       { self = .Unknown(type, data) }
    }
}

// MARK: Typetalk Streaming API

public class TypetalkStream : WebSocketDelegate {
    public typealias EventClosure = StreamingEvent -> ()

    private var socket: WebSocket!
    internal var streamingClosure: EventClosure?

    public init(accessToken: String, closure: EventClosure) {
        streamingClosure = closure
        socket = WebSocket(url: NSURL(string: TypetalkAPI.baseURLString + "streaming")!)
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
                let ev = try StreamingEvent(type: type!, data: data!)
                sendStreamEventIfPossible(ev)
            }
        } catch {
            print(error)
        }
    }

    public func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        fatalError("Never be called")
    }

}
