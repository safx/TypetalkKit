// This file was auto-generated from Request.swift with swift-idl.

import Foundation
import APIKit

public class GetProfile: APIKitRequest {
    public typealias Response = GetProfileResponse

    public init() {
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "profile"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetTopics: APIKitRequest {
    public typealias Response = GetTopicsResponse

    public init() {
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetMessages: APIKitRequest {
    public typealias Response = GetMessagesResponse
    public let topicId: TopicID
    public let count: Int?
    public let from: PostID?
    public let direction: MessageDirection?

    public init(topicId: TopicID, count: Int? = nil, from: PostID? = nil, direction: MessageDirection? = nil) {
        self.topicId = topicId
        self.count = count
        self.from = from
        self.direction = direction
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = [:]
        count.map { p["count"] = $0.toJSON() }
        from.map { p["from"] = $0.toJSON() }
        direction.map { p["direction"] = $0.toJSON() }
        return p
    }
}

public class PostMessage: APIKitRequest {
    public typealias Response = PostMessageResponse
    public let topicId: TopicID
    public let message: String
    public let replyTo: Int?
    public let fileKeys: [String]
    public let talkIds: [TalkID]

    public init(topicId: TopicID, message: String, replyTo: Int? = nil, fileKeys: [String], talkIds: [TalkID]) {
        self.topicId = topicId
        self.message = message
        self.replyTo = replyTo
        self.fileKeys = fileKeys
        self.talkIds = talkIds
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = ["message": message.toJSON(), "fileKeys": fileKeys.map { $0.toJSON() }, "talkIds": talkIds.map { $0.toJSON() }]
        replyTo.map { p["replyTo"] = $0.toJSON() }
        return p
    }
}

public class UploadAttachment: APIKitRequest {
    public typealias Response = Attachment
    public let topicId: TopicID
    public let name: String     // router:"-"
    public let contents: NSData // router:"-"

    public init(topicId: TopicID, name: String, contents: NSData) {
        self.topicId = topicId
        self.name = name
        self.contents = contents
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/attachments"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetTopicMembers: APIKitRequest {
    public typealias Response = GetTopicMembersResponse
    public let topicId: TopicID

    public init(topicId: TopicID) {
        self.topicId = topicId
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)/members/status"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetMessage: APIKitRequest {
    public typealias Response = GetMessageResponse
    public let topicId: TopicID
    public let postId: PostID

    public init(topicId: TopicID, postId: PostID) {
        self.topicId = topicId
        self.postId = postId
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)/posts/\(postId)"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class DeleteMessage: APIKitRequest {
    public typealias Response = Post
    public let topicId: TopicID
    public let postId: PostID

    public init(topicId: TopicID, postId: PostID) {
        self.topicId = topicId
        self.postId = postId
    }

    public var method: HTTPMethod {
        return .DELETE
    }

    public var path: String {
        return "topics/\(topicId)/posts/\(postId)"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class LikeMessage: APIKitRequest {
    public typealias Response = LikeMessageResponse
    public let topicId: TopicID
    public let postId: PostID

    public init(topicId: TopicID, postId: PostID) {
        self.topicId = topicId
        self.postId = postId
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/posts/\(postId)/like"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class UnlikeMessage: APIKitRequest {
    public typealias Response = LikeMessageResponse
    public let topicId: TopicID
    public let postId: PostID

    public init(topicId: TopicID, postId: PostID) {
        self.topicId = topicId
        self.postId = postId
    }

    public var method: HTTPMethod {
        return .DELETE
    }

    public var path: String {
        return "topics/\(topicId)/posts/\(postId)/like"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class FavoriteTopic: APIKitRequest {
    public typealias Response = TopicWithUserInfo
    public let topicId: TopicID

    public init(topicId: TopicID) {
        self.topicId = topicId
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/favorite"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class UnfavoriteTopic: APIKitRequest {
    public typealias Response = TopicWithUserInfo
    public let topicId: TopicID

    public init(topicId: TopicID) {
        self.topicId = topicId
    }

    public var method: HTTPMethod {
        return .DELETE
    }

    public var path: String {
        return "topics/\(topicId)/favorite"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetNotifications: APIKitRequest {
    public typealias Response = Notifications

    public init() {
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "notifications"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetNotificationStatus: APIKitRequest {
    public typealias Response = NotificationStatus

    public init() {
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "notifications/status"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class OpenNotification: APIKitRequest {
    public typealias Response = NotificationStatus

    public init() {
    }

    public var method: HTTPMethod {
        return .PUT
    }

    public var path: String {
        return "notifications"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class SaveReadTopic: APIKitRequest {
    public typealias Response = SaveReadTopicResponse
    public let topicId: TopicID
    public let postId: PostID?

    public init(topicId: TopicID, postId: PostID? = nil) {
        self.topicId = topicId
        self.postId = postId
    }

    public var method: HTTPMethod {
        return .PUT
    }

    public var path: String {
        return "bookmarks"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = ["topicId": topicId.toJSON()]
        postId.map { p["postId"] = $0.toJSON() }
        return p
    }
}

public class GetMentions: APIKitRequest {
    public typealias Response = GetMentionsResponse
    public let from: MentionID?
    public let unread: Bool?

    public init(from: MentionID? = nil, unread: Bool? = nil) {
        self.from = from
        self.unread = unread
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "mentions"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = [:]
        from.map { p["from"] = $0.toJSON() }
        unread.map { p["unread"] = $0.toJSON() }
        return p
    }
}

public class SaveReadMention: APIKitRequest {
    public typealias Response = SaveReadMentionResponse
    public let mentionId: MentionID

    public init(mentionId: MentionID) {
        self.mentionId = mentionId
    }

    public var method: HTTPMethod {
        return .PUT
    }

    public var path: String {
        return "mentions/\(mentionId)"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class AcceptTeamInvite: APIKitRequest {
    public typealias Response = AcceptTeamInviteResponse
    public let teamId: TeamID
    public let inviteId: InviteID

    public init(teamId: TeamID, inviteId: InviteID) {
        self.teamId = teamId
        self.inviteId = inviteId
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "teams/\(teamId)/members/invite/\(inviteId)/accept"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class DeclineTeamInvite: APIKitRequest {
    public typealias Response = DeclineTeamInviteResponse
    public let teamId: TeamID
    public let inviteId: InviteID

    public init(teamId: TeamID, inviteId: InviteID) {
        self.teamId = teamId
        self.inviteId = inviteId
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "teams/\(teamId)/members/invite/\(inviteId)/decline"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class AcceptTopicInvite: APIKitRequest {
    public typealias Response = AcceptTopicInviteResponse
    public let topicId: TopicID
    public let inviteId: InviteID

    public init(topicId: TopicID, inviteId: InviteID) {
        self.topicId = topicId
        self.inviteId = inviteId
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/members/invite/\(inviteId)/accept"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class DeclineTopicInvite: APIKitRequest {
    public typealias Response = AcceptTopicInviteResponse
    public let topicId: TopicID
    public let inviteId: InviteID

    public init(topicId: TopicID, inviteId: InviteID) {
        self.topicId = topicId
        self.inviteId = inviteId
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/members/invite/\(inviteId)/decline"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class CreateTopic: APIKitRequest {
    public typealias Response = TopicWithAccounts
    public let name: String
    public let teamId: TeamID?
    public let inviteMembers: [String]
    public let inviteMessage: String

    public init(name: String, teamId: TeamID? = nil, inviteMembers: [String], inviteMessage: String) {
        self.name = name
        self.teamId = teamId
        self.inviteMembers = inviteMembers
        self.inviteMessage = inviteMessage
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = ["name": name.toJSON(), "inviteMembers": inviteMembers.map { $0.toJSON() }, "inviteMessage": inviteMessage.toJSON()]
        teamId.map { p["teamId"] = $0.toJSON() }
        return p
    }
}

public class UpdateTopic: APIKitRequest {
    public typealias Response = TopicWithAccounts
    public let topicId: TopicID
    public let name: String?
    public let teamId: TeamID?

    public init(topicId: TopicID, name: String? = nil, teamId: TeamID? = nil) {
        self.topicId = topicId
        self.name = name
        self.teamId = teamId
    }

    public var method: HTTPMethod {
        return .PUT
    }

    public var path: String {
        return "topics/\(topicId)"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = [:]
        name.map { p["name"] = $0.toJSON() }
        teamId.map { p["teamId"] = $0.toJSON() }
        return p
    }
}

public class DeleteTopic: APIKitRequest {
    public typealias Response = Topic
    public let topicId: TopicID

    public init(topicId: TopicID) {
        self.topicId = topicId
    }

    public var method: HTTPMethod {
        return .DELETE
    }

    public var path: String {
        return "topics/\(topicId)"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetTopicDetails: APIKitRequest {
    public typealias Response = TopicWithAccounts
    public let topicId: TopicID

    public init(topicId: TopicID) {
        self.topicId = topicId
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)/details"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class InviteTopicMember: APIKitRequest {
    public typealias Response = TopicWithAccounts
    public let topicId: TopicID
    public let inviteMembers: [String]
    public let inviteMessage: String?

    public init(topicId: TopicID, inviteMembers: [String], inviteMessage: String? = nil) {
        self.topicId = topicId
        self.inviteMembers = inviteMembers
        self.inviteMessage = inviteMessage
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/members/invite"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = ["inviteMembers": inviteMembers.map { $0.toJSON() }]
        inviteMessage.map { p["inviteMessage"] = $0.toJSON() }
        return p
    }
}

public class RemoveTopicMember: APIKitRequest {
    public typealias Response = TopicWithAccounts
    public let topicId: TopicID
    public let removeInviteIds: [InviteID]
    public let removeMemberIds: [AccountID]

    public init(topicId: TopicID, removeInviteIds: [InviteID], removeMemberIds: [AccountID]) {
        self.topicId = topicId
        self.removeInviteIds = removeInviteIds
        self.removeMemberIds = removeMemberIds
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/members/remove"
    }

    public var params: [String: AnyObject] {
        return ["removeInviteIds": removeInviteIds.map { $0.toJSON() }, "removeMemberIds": removeMemberIds.map { $0.toJSON() }]
    }
}

public class GetTeams: APIKitRequest {
    public typealias Response = GetTeamsResponse

    public init() {
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "teams"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetFriends: APIKitRequest {
    public typealias Response = GetFriendsResponse

    public init() {
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "search/friends"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class SearchAccounts: APIKitRequest {
    public typealias Response = Account
    public let nameOrEmailAddress: String

    public init(nameOrEmailAddress: String) {
        self.nameOrEmailAddress = nameOrEmailAddress
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "search/accounts"
    }

    public var params: [String: AnyObject] {
        return ["nameOrEmailAddress": nameOrEmailAddress.toJSON()]
    }
}

public class GetTalks: APIKitRequest {
    public typealias Response = GetTalksResponse
    public let topicId: TopicID

    public init(topicId: TopicID) {
        self.topicId = topicId
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)/talks"
    }

    public var params: [String: AnyObject] {
        return [:]
    }
}

public class GetTalk: APIKitRequest {
    public typealias Response = TalkMessages
    public let topicId: TopicID
    public let talkId: TalkID
    public let count: Int?
    public let from: PostID?
    public let direction: MessageDirection?

    public init(topicId: TopicID, talkId: TalkID, count: Int? = nil, from: PostID? = nil, direction: MessageDirection? = nil) {
        self.topicId = topicId
        self.talkId = talkId
        self.count = count
        self.from = from
        self.direction = direction
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)/talks/\(talkId)/posts"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = [:]
        count.map { p["count"] = $0.toJSON() }
        from.map { p["from"] = $0.toJSON() }
        direction.map { p["direction"] = $0.toJSON() }
        return p
    }
}

public class CreateTalk: APIKitRequest {
    public typealias Response = CreateTalkResponse
    public let topicId: TopicID
    public let talkName: String
    public let postIds: [Int]

    public init(topicId: TopicID, talkName: String, postIds: [Int]) {
        self.topicId = topicId
        self.talkName = talkName
        self.postIds = postIds
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "topics/\(topicId)/talks"
    }

    public var params: [String: AnyObject] {
        return ["talkName": talkName.toJSON(), "postIds": postIds.map { $0.toJSON() }]
    }
}

public class DownloadAttachment: APIKitRequest {
    public typealias Response = NSData
    public let topicId: TopicID
    public let postId: PostID
    public let attachmentId: AttachmentID
    public let filename: String
    public let type: AttachmentType?

    public init(topicId: TopicID, postId: PostID, attachmentId: AttachmentID, filename: String, type: AttachmentType? = nil) {
        self.topicId = topicId
        self.postId = postId
        self.attachmentId = attachmentId
        self.filename = filename
        self.type = type
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
    }

    public var params: [String: AnyObject] {
        var p: [String: AnyObject] = [:]
        type.map { p["type"] = $0.toJSON() }
        return p
    }
}

