//
//  Streaming.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/08/24.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation


public enum StreamingEvent: WSHelper {
    case connected              // ws:"-"
    case disconnected(NSError?) // ws:"-"

    case addTalkPost
    case createTalk
    case createTopic
    case deleteTalk
    case deleteTopic
    case deleteMessage
    case favoriteTopic            // FIXME: unread should be omitted.
    case joinTopics
    case likeMessage
    case notifyMention
    case postMessage
    case postLinks
    case readMention
    case removeTalkPost
    case requestTeamInvite
    case requestTopicInvite
    case saveBookmark
    case updateNotificationAccess
    case unfavoriteTopic          // FIXME: unread should be omitted.
    case unlikeMessage
    case updateTalk
    case updateTopic

    case unknown(String, [String:AnyObject]) // ws:"-"
}
