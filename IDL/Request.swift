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
    let showLinkMeta: Bool = true
    let fileKeys: [String] = []
    let talkIds: [TalkID] = []
    // TODO: attachments[0].fileUrl, attachments[0].fileName
}

class UploadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/attachments"
    typealias APIKitResponse = Attachment
    let topicId: TopicID
    public let name: String     // router:"-"
    public let contents: NSData // router:"-"
}

class DownloadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
    typealias APIKitResponse = NSData
    let topicId: TopicID
    let postId: PostID
    let attachmentId: AttachmentID
    let filename: String
    let type: AttachmentType? = nil
}

class GetTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/members/status"
    let topicId: TopicID
}

class GetMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/posts/\(postId)"
    let topicId: TopicID
    let postId: PostID
}

class UpdateMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)/posts/\(postId)"
    typealias APIKitResponse = PostMessageResponse
    let topicId: TopicID
    let postId: PostID
    let message: String
}

class DeleteMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/posts/\(postId)"
    typealias APIKitResponse = Post
    let topicId: TopicID
    let postId: PostID
}

class LikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/posts/\(postId)/like"
    let topicId: TopicID
    let postId: PostID
}

class UnlikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/posts/\(postId)/like"
    typealias APIKitResponse = LikeMessageResponse
    let topicId: TopicID
    let postId: PostID
}

class FavoriteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/favorite"
    typealias APIKitResponse = TopicWithUserInfo
    let topicId: TopicID
}

class UnfavoriteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/favorite"
    typealias APIKitResponse = TopicWithUserInfo
    let topicId: TopicID
}

class GetNotifications: ClassInit, APIKitHelper, TypetalkRequest { // router:",notifications"
    typealias APIKitResponse = Notifications
}

class GetNotificationStatus: ClassInit, APIKitHelper, TypetalkRequest { // router:",notifications/status"
    typealias APIKitResponse = NotificationStatus
}

class OpenNotification: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,notifications"
    typealias APIKitResponse = NotificationStatus
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
    typealias APIKitResponse = Invite
    let teamId: TeamID
    let inviteId: InviteID
}

class AcceptTopicInvite: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/accept"
    let topicId: TopicID
    let inviteId: InviteID
}

class DeclineTopicInvite: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/decline"
    typealias APIKitResponse = AcceptTopicInviteResponse
    let topicId: TopicID
    let inviteId: InviteID
}

class CreateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics"
    typealias APIKitResponse = TopicWithAccounts
    let name: String
    let teamId: TeamID? = nil
    let inviteMembers: [String] = []
    let inviteMessage: String = ""
}

class UpdateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
    let name: String? = nil
    let teamId: TeamID? = nil
}

class DeleteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)"
    typealias APIKitResponse = Topic
    let topicId: TopicID
}

class GetTopicDetails: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/details"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
}

class UpdateTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/update"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
    let addAccountIds: [String] = []
    let addGroupIds: [String] = []
    let removeAccountIds: [Int] = []
    let removeGroupIds: [Int] = []
}

class GetSpaces: ClassInit, APIKitHelper, TypetalkRequest { // router:",spaces"
    let excludesGuest: Bool = false
}

class GetSpaceMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",spaces/\(spaceKey)/members"
    let spaceKey: String
}

class InviteTopicMember: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/invite"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
    let inviteMembers: [String] = []
    let inviteMessage: String? = nil
}

class RemoveTopicMember: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/remove"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
    let removeInviteIds: [InviteID] = []
    let removeMemberIds: [AccountID] = []
}

class GetTeams: ClassInit, APIKitHelper, TypetalkRequest { // router:",teams"
}

class GetFriends: ClassInit, APIKitHelper, TypetalkRequest { // router:",search/friends"
}

class SearchAccounts: ClassInit, APIKitHelper, TypetalkRequest { // router:",search/accounts"
    typealias APIKitResponse = Account
    let nameOrEmailAddress: String
}

class GetTalks: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/talks"
    let topicId: TopicID
}

class GetTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/talks/\(talkId)/posts"
    //typealias APIKitResponse = TalkMessages
    let topicId: TopicID
    let talkId: TalkID
    let count: Int? = nil
    let from: PostID? = nil
    let direction: MessageDirection? = nil
}

class CreateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/talks"
    let topicId: TopicID
    let talkName: String
    let postIds: [PostID] = []
}

class UpdateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)/talks/\(talkId)"
    let topicId: TopicID
    let talkId: TalkID
    let talkName: String
}

class DeleteTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/talks/\(talkId)"
    typealias APIKitResponse = UpdateTalkResponse
    let topicId: TopicID
    let talkId: TalkID
}

class AddMessageToTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/talks/\(talkId)/posts"
    typealias APIKitResponse = CreateTalkResponse
    let topicId: TopicID
    let talkId: TalkID
    let postIds: [PostID] = []
}

class RemoveMessageFromTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/talks/\(talkId)/posts"
    typealias APIKitResponse = CreateTalkResponse
    let topicId: TopicID
    let talkId: TalkID
    let postIds: [PostID] = []
}
