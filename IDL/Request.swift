//
//  Request.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/15.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

class GetProfile: ClassInit, APIKitHelper { // router:",profile"
}

class GetTopics:  ClassInit, APIKitHelper { // router:",topics"
}

class GetMessages: ClassInit, APIKitHelper { // router:",topics/\(topicId)"
    let topicId: TopicID
    let count: Int?
    let from: PostID?
    let direction: MessageDirection?
}

class PostMessage: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)"
    let topicId: TopicID
    let message: String
    let replyTo: Int?
    let fileKeys: [String]
    let talkIds: [TalkID]
    // TODO: attachments[0].fileUrl, attachments[0].fileName
}

class UploadAttachment: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/attachments"
    typealias Response = Attachment
    let topicId: TopicID
    public let name: String     // router:"-"
    public let contents: NSData // router:"-"
}

class GetTopicMembers: ClassInit, APIKitHelper { // router:",topics/\(topicId)/members/status"
    let topicId: TopicID
}

class GetMessage: ClassInit, APIKitHelper { // router:",topics/\(topicId)/posts/\(postId)"
    let topicId: TopicID
    let postId: PostID
}

class DeleteMessage: ClassInit, APIKitHelper { // router:"DELETE,topics/\(topicId)/posts/\(postId)"
    typealias Response = Post
    let topicId: TopicID
    let postId: PostID
}

class LikeMessage: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/posts/\(postId)/like"
    let topicId: TopicID
    let postId: PostID
}

class UnlikeMessage: ClassInit, APIKitHelper { // router:"DELETE,topics/\(topicId)/posts/\(postId)/like"
    typealias Response = LikeMessageResponse
    let topicId: TopicID
    let postId: PostID
}

class FavoriteTopic: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/favorite"
    typealias Response = TopicWithUserInfo
    let topicId: TopicID
}

class UnfavoriteTopic: ClassInit, APIKitHelper { // router:"DELETE,topics/\(topicId)/favorite"
    typealias Response = TopicWithUserInfo
    let topicId: TopicID
}

class GetNotifications: ClassInit, APIKitHelper { // router:",notifications"
    typealias Response = Notifications
}

class GetNotificationStatus: ClassInit, APIKitHelper { // router:",notifications/status"
    typealias Response = NotificationStatus
}

class OpenNotification: ClassInit, APIKitHelper { // router:"PUT,notifications"
    typealias Response = NotificationStatus
}

class SaveReadTopic: ClassInit, APIKitHelper { // router:"PUT,bookmarks"
    let topicId: TopicID
    let postId: PostID?
}

class GetMentions: ClassInit, APIKitHelper { // router:",mentions"
    let from: MentionID?
    let unread: Bool?
}

class SaveReadMention: ClassInit, APIKitHelper { // router:"PUT,mentions/\(mentionId)"
    let mentionId: MentionID
}

class AcceptTeamInvite: ClassInit, APIKitHelper { // router:"POST,teams/\(teamId)/members/invite/\(inviteId)/accept"
    let teamId: TeamID
    let inviteId: InviteID
}

class DeclineTeamInvite: ClassInit, APIKitHelper { // router:"POST,teams/\(teamId)/members/invite/\(inviteId)/decline"
    let teamId: TeamID
    let inviteId: InviteID
}

class AcceptTopicInvite: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/accept"
    let topicId: TopicID
    let inviteId: InviteID
}

class DeclineTopicInvite: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/decline"
    typealias Response = AcceptTopicInviteResponse
    let topicId: TopicID
    let inviteId: InviteID
}

class CreateTopic: ClassInit, APIKitHelper { // router:"POST,topics"
    typealias Response = TopicWithAccounts
    let name: String
    let teamId: TeamID?
    let inviteMembers: [String]
    let inviteMessage: String
}

class UpdateTopic: ClassInit, APIKitHelper { // router:"PUT,topics/\(topicId)"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
    let name: String?
    let teamId: TeamID?
}

class DeleteTopic: ClassInit, APIKitHelper { // router:"DELETE,topics/\(topicId)"
    typealias Response = Topic
    let topicId: TopicID
}

class GetTopicDetails: ClassInit, APIKitHelper { // router:",topics/\(topicId)/details"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
}

class InviteTopicMember: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/members/invite"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
    let inviteMembers: [String]
    let inviteMessage: String?
}

class RemoveTopicMember: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/members/remove"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
    let removeInviteIds: [InviteID]
    let removeMemberIds: [AccountID]
}

class GetTeams: ClassInit, APIKitHelper { // router:",teams"
}

class GetFriends: ClassInit, APIKitHelper { // router:",search/friends"
}

class SearchAccounts: ClassInit, APIKitHelper { // router:",search/accounts"
    typealias Response = Account
    let nameOrEmailAddress: String
}

class GetTalks: ClassInit, APIKitHelper { // router:",topics/\(topicId)/talks"
    let topicId: TopicID
}

class GetTalk: ClassInit, APIKitHelper { // router:",topics/\(topicId)/talks/\(talkId)/posts"
    typealias Response = TalkMessages
    let topicId: TopicID
    let talkId: TalkID
    let count: Int?
    let from: PostID?
    let direction: MessageDirection?
}

class CreateTalk: ClassInit, APIKitHelper { // router:"POST,topics/\(topicId)/talks"
    let topicId: TopicID
    let talkName: String
    let postIds: [Int]
}

class DownloadAttachment: ClassInit, APIKitHelper { // router:",topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
    typealias Response = NSData
    let topicId: TopicID
    let postId: PostID
    let attachmentId: AttachmentID
    let filename: String
    let type: AttachmentType?
}


