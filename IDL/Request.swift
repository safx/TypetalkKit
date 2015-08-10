//
//  Request.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/15.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

class GetProfile: ClassInit, APIKitHelper, TypetalkRequest { // router:",profile"
}

class GetTopics:  ClassInit, APIKitHelper, TypetalkRequest { // router:",topics"
}

class GetMessages: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)"
    let topicId: TopicID
    let count: Int? = nil
    let from: PostID? = nil
    let direction: MessageDirection? = nil
}

class PostMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)"
    let topicId: TopicID
    let message: String
    let replyTo: Int? = nil
    let fileKeys: [String] = []
    let talkIds: [TalkID] = []
    // TODO: attachments[0].fileUrl, attachments[0].fileName
}

class UploadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/attachments"
    typealias Response = Attachment
    let topicId: TopicID
    public let name: String     // router:"-"
    public let contents: NSData // router:"-"
}

class GetTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/members/status"
    let topicId: TopicID
}

class GetMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/posts/\(postId)"
    let topicId: TopicID
    let postId: PostID
}

class DeleteMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/posts/\(postId)"
    typealias Response = Post
    let topicId: TopicID
    let postId: PostID
}

class LikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/posts/\(postId)/like"
    let topicId: TopicID
    let postId: PostID
}

class UnlikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/posts/\(postId)/like"
    typealias Response = LikeMessageResponse
    let topicId: TopicID
    let postId: PostID
}

class FavoriteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/favorite"
    typealias Response = TopicWithUserInfo
    let topicId: TopicID
}

class UnfavoriteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/favorite"
    typealias Response = TopicWithUserInfo
    let topicId: TopicID
}

class GetNotifications: ClassInit, APIKitHelper, TypetalkRequest { // router:",notifications"
    typealias Response = Notifications
}

class GetNotificationStatus: ClassInit, APIKitHelper, TypetalkRequest { // router:",notifications/status"
    typealias Response = NotificationStatus
}

class OpenNotification: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,notifications"
    typealias Response = NotificationStatus
}

class SaveReadTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,bookmarks"
    let topicId: TopicID
    let postId: PostID? = nil
}

class GetMentions: ClassInit, APIKitHelper, TypetalkRequest { // router:",mentions"
    let from: MentionID? = nil
    let unread: Bool? = nil
}

class SaveReadMention: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,mentions/\(mentionId)"
    let mentionId: MentionID
}

class AcceptTeamInvite: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,teams/\(teamId)/members/invite/\(inviteId)/accept"
    let teamId: TeamID
    let inviteId: InviteID
}

class DeclineTeamInvite: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,teams/\(teamId)/members/invite/\(inviteId)/decline"
    let teamId: TeamID
    let inviteId: InviteID
}

class AcceptTopicInvite: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/accept"
    let topicId: TopicID
    let inviteId: InviteID
}

class DeclineTopicInvite: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/decline"
    typealias Response = AcceptTopicInviteResponse
    let topicId: TopicID
    let inviteId: InviteID
}

class CreateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics"
    typealias Response = TopicWithAccounts
    let name: String
    let teamId: TeamID? = nil
    let inviteMembers: [String] = []
    let inviteMessage: String = ""
}

class UpdateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
    let name: String? = nil
    let teamId: TeamID? = nil
}

class DeleteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)"
    typealias Response = Topic
    let topicId: TopicID
}

class GetTopicDetails: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/details"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
}

class InviteTopicMember: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/invite"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
    let inviteMembers: [String] = []
    let inviteMessage: String? = nil
}

class RemoveTopicMember: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/remove"
    typealias Response = TopicWithAccounts
    let topicId: TopicID
    let removeInviteIds: [InviteID] = []
    let removeMemberIds: [AccountID] = []
}

class GetTeams: ClassInit, APIKitHelper, TypetalkRequest { // router:",teams"
}

class GetFriends: ClassInit, APIKitHelper, TypetalkRequest { // router:",search/friends"
}

class SearchAccounts: ClassInit, APIKitHelper, TypetalkRequest { // router:",search/accounts"
    typealias Response = Account
    let nameOrEmailAddress: String
}

class GetTalks: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/talks"
    let topicId: TopicID
}

class GetTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/talks/\(talkId)/posts"
    typealias Response = TalkMessages
    let topicId: TopicID
    let talkId: TalkID
    let count: Int? = nil
    let from: PostID? = nil
    let direction: MessageDirection? = nil
}

class CreateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/talks"
    let topicId: TopicID
    let talkName: String
    let postIds: [Int] = []
}

class DownloadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
    typealias Response = NSData
    let topicId: TopicID
    let postId: PostID
    let attachmentId: AttachmentID
    let filename: String
    let type: AttachmentType? = nil
}
