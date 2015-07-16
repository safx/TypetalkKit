//
//  Router+Test.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/08.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire
import TypetalkKit


extension TypetalkKit.Router {
    public var name : String {
        switch (self) {
        case .GetProfile            : return "get-profile"
        case .GetTopics             : return "get-topics"
        case .GetMessages           : return "get-messages"
        case .PostMessage           : return "post-message"
        case .UploadAttachment      : return "upload-attachment"
        case .GetTopicMembers       : return "get-topic-members"
        case .GetMessage            : return "get-message"
        case .DeleteMessage         : return "delete-message"
        case .LikeMessage           : return "like-message"
        case .UnlikeMessage         : return "unlike-message"
        case .FavoriteTopic         : return "favorite-topic"
        case .UnfavoriteTopic       : return "unfavorite-topic"
        case .GetNotifications      : return "get-notifications"
        case .GetNotificationStatus : return "get-notification-status"
        case .OpenNotification      : return "open-notification"
        case .SaveReadTopic         : return "save-read-topic"
        case .GetMentions           : return "get-mentions"
        case .SaveReadMention       : return "save-read-mention"
        case .AcceptTeamInvite      : return "accept-team-invite"
        case .DeclineTeamInvite     : return "decline-team-invite"
        case .AcceptTopicInvite     : return "accept-topic-invite"
        case .DeclineTopicInvite    : return "decline-topic-invite"
        case .CreateTopic           : return "create-topic"
        case .UpdateTopic           : return "update-topic"
        case .DeleteTopic           : return "delete-topic"
        case .GetTopicDetails       : return "get-topic-details"
        case .InviteTopicMember     : return "invite-topic-member"
        case .RemoveTopicMember     : return "remove-topic-member"
        case .GetTeams              : return "get-teams"
        case .GetFriends            : return "get-friends"
        case .SearchAccounts        : return "search-accounts"
        case .GetTalks              : return "get-talks"
        case .GetTalk               : return "get-talk"
        case .CreateTalk            : return "create-talk"

        case .DownloadAttachment       : return "get-talk" // whatever
        //case .DownloadAttachmentWithURL: return "get-talk" // whatever
        default                     : fatalError()
        }
    }

    public var URLRequestForTests: NSURLRequest {
        let bundle = NSBundle(forClass: ClientTests.self)
        let path = bundle.pathForResource("api_\(name)", ofType: "json")
        let request = NSMutableURLRequest(URL: NSURL(fileURLWithPath: path!))
        return request
    }
}

