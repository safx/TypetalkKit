//
//  Streaming.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/08/24.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation


public enum StreamingEvent: WSHelper {
    case Connected              // ws:"-"
    case Disconnected(NSError?) // ws:"-"

    case AcceptTeamInvite         // ws:"acceptTeamInvite"
    case AcceptTopicInvite        // ws:"acceptTopicInvite"
    case AddTalkPost              // ws:"addTalkPost"
    case CancelTopicInvite        // ws:"cancelTopicInvite"
    case CreateTalk               // ws:"createTalk"
    case CreateTopic              // ws:"createTopic"
    case DeclineTeamInvite        // ws:"declineTeamInvite"
    case DeclineTopicInvite       // ws:"declineTopicInvite"
    case DeleteTalk               // ws:"deleteTalk"
    case DeleteTopic              // ws:"deleteTopic"
    case DeleteMessage            // ws:"deleteMessage"
    case FavoriteTopic            // ws:"favoriteTopic"   // FIXME: unread should be omitted.
    case JoinTopics               // ws:"joinTopics"
    case LeaveTopics              // ws:"leaveTopics"     // FIXME: invite should be omitted.
    case LikeMessage              // ws:"likeMessage"
    case NotifyMention            // ws:"notifyMention"
    case PostMessage              // ws:"postMessage"
    case PostLinks                // ws:"postLinks"
    case ReadMention              // ws:"readMention"
    case RemoveTalkPost           // ws:"removeTalkPost"
    case RequestTeamInvite        // ws:"requestTeamInvite"  // TeamInvite
    case RequestTopicInvite       // ws:"requestTopicInvite" // TopicInvite
    case SaveBookmark             // ws:"saveBookmark"
    case UpdateNotificationAccess // ws:"updateNotificationAccess"
    case UnfavoriteTopic          // ws:"unfavoriteTopic"    // FIXME: unread should be omitted.
    case UnlikeMessage            // ws:"unlikeMessage"
    case UpdateTalk               // ws:"updateTalk"
    case UpdateTopic              // ws:"updateTopic"

    case Unknown(String, [String:AnyObject]) // ws:"-"
}
