// This file was auto-generated from Request.swift with swift-idl.

import Foundation
import APIKit


public class GetProfile: TypetalkRequest {
	public typealias APIKitResponse = GetProfileResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .GET
	}

	public var path: String {
		return "profile"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetTopics: TypetalkRequest {
	public typealias APIKitResponse = GetTopicsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .GET
	}

	public var path: String {
		return "topics"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetMessages: TypetalkRequest {
	public typealias APIKitResponse = GetMessagesResponse
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = [:]
		if let v = count { p["count"] = v.toJSON() }
		if let v = from { p["from"] = v.toJSON() }
		if let v = direction { p["direction"] = v.toJSON() }
		return p
	}
}

public class PostMessage: TypetalkRequest {
	public typealias APIKitResponse = PostMessageResponse
	public let topicId: TopicID
	public let message: String
	public let replyTo: Int?
	public let fileKeys: [String]
	public let talkIds: [TalkID]

	public init(topicId: TopicID, message: String, replyTo: Int? = nil, fileKeys: [String] = [], talkIds: [TalkID] = []) {
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = ["message": message.toJSON(), "fileKeys": fileKeys.map { $0.toJSON() }, "talkIds": talkIds.map { $0.toJSON() }]
		if let v = replyTo { p["replyTo"] = v.toJSON() }
		return p
	}
}

public class UploadAttachment: TypetalkRequest {
	public typealias APIKitResponse = Attachment
	public let topicId: TopicID
	public let name: String	 // router:"-"
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetTopicMembers: TypetalkRequest {
	public typealias APIKitResponse = GetTopicMembersResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetMessage: TypetalkRequest {
	public typealias APIKitResponse = GetMessageResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class DeleteMessage: TypetalkRequest {
	public typealias APIKitResponse = Post
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class LikeMessage: TypetalkRequest {
	public typealias APIKitResponse = LikeMessageResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class UnlikeMessage: TypetalkRequest {
	public typealias APIKitResponse = LikeMessageResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class FavoriteTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithUserInfo
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class UnfavoriteTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithUserInfo
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetNotifications: TypetalkRequest {
	public typealias APIKitResponse = Notifications

	public init() {
	}

	public var method: HTTPMethod {
		return .GET
	}

	public var path: String {
		return "notifications"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetNotificationStatus: TypetalkRequest {
	public typealias APIKitResponse = NotificationStatus

	public init() {
	}

	public var method: HTTPMethod {
		return .GET
	}

	public var path: String {
		return "notifications/status"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class OpenNotification: TypetalkRequest {
	public typealias APIKitResponse = NotificationStatus

	public init() {
	}

	public var method: HTTPMethod {
		return .PUT
	}

	public var path: String {
		return "notifications"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class SaveReadTopic: TypetalkRequest {
	public typealias APIKitResponse = SaveReadTopicResponse
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = ["topicId": topicId.toJSON()]
		if let v = postId { p["postId"] = v.toJSON() }
		return p
	}
}

public class GetMentions: TypetalkRequest {
	public typealias APIKitResponse = GetMentionsResponse
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = [:]
		if let v = from { p["from"] = v.toJSON() }
		if let v = unread { p["unread"] = v.toJSON() }
		return p
	}
}

public class SaveReadMention: TypetalkRequest {
	public typealias APIKitResponse = SaveReadMentionResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class AcceptTeamInvite: TypetalkRequest {
	public typealias APIKitResponse = AcceptTeamInviteResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class DeclineTeamInvite: TypetalkRequest {
	public typealias APIKitResponse = Invite
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class AcceptTopicInvite: TypetalkRequest {
	public typealias APIKitResponse = AcceptTopicInviteResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class DeclineTopicInvite: TypetalkRequest {
	public typealias APIKitResponse = AcceptTopicInviteResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class CreateTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public let name: String
	public let teamId: TeamID?
	public let inviteMembers: [String]
	public let inviteMessage: String

	public init(name: String, teamId: TeamID? = nil, inviteMembers: [String] = [], inviteMessage: String = "") {
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = ["name": name.toJSON(), "inviteMembers": inviteMembers.map { $0.toJSON() }, "inviteMessage": inviteMessage.toJSON()]
		if let v = teamId { p["teamId"] = v.toJSON() }
		return p
	}
}

public class UpdateTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = [:]
		if let v = name { p["name"] = v.toJSON() }
		if let v = teamId { p["teamId"] = v.toJSON() }
		return p
	}
}

public class DeleteTopic: TypetalkRequest {
	public typealias APIKitResponse = Topic
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetTopicDetails: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class InviteTopicMember: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public let topicId: TopicID
	public let inviteMembers: [String]
	public let inviteMessage: String?

	public init(topicId: TopicID, inviteMembers: [String] = [], inviteMessage: String? = nil) {
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = ["inviteMembers": inviteMembers.map { $0.toJSON() }]
		if let v = inviteMessage { p["inviteMessage"] = v.toJSON() }
		return p
	}
}

public class RemoveTopicMember: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public let topicId: TopicID
	public let removeInviteIds: [InviteID]
	public let removeMemberIds: [AccountID]

	public init(topicId: TopicID, removeInviteIds: [InviteID] = [], removeMemberIds: [AccountID] = []) {
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

	public var parameters: [String: AnyObject] {
		return ["removeInviteIds": removeInviteIds.map { $0.toJSON() }, "removeMemberIds": removeMemberIds.map { $0.toJSON() }]
	}
}

public class GetTeams: TypetalkRequest {
	public typealias APIKitResponse = GetTeamsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .GET
	}

	public var path: String {
		return "teams"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetFriends: TypetalkRequest {
	public typealias APIKitResponse = GetFriendsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .GET
	}

	public var path: String {
		return "search/friends"
	}

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class SearchAccounts: TypetalkRequest {
	public typealias APIKitResponse = Account
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

	public var parameters: [String: AnyObject] {
		return ["nameOrEmailAddress": nameOrEmailAddress.toJSON()]
	}
}

public class GetTalks: TypetalkRequest {
	public typealias APIKitResponse = GetTalksResponse
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

	public var parameters: [String: AnyObject] {
		return [:]
	}
}

public class GetTalk: TypetalkRequest {
	public typealias APIKitResponse = TalkMessages
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = [:]
		if let v = count { p["count"] = v.toJSON() }
		if let v = from { p["from"] = v.toJSON() }
		if let v = direction { p["direction"] = v.toJSON() }
		return p
	}
}

public class CreateTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public let topicId: TopicID
	public let talkName: String
	public let postIds: [Int]

	public init(topicId: TopicID, talkName: String, postIds: [Int] = []) {
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

	public var parameters: [String: AnyObject] {
		return ["talkName": talkName.toJSON(), "postIds": postIds.map { $0.toJSON() }]
	}
}

public class DownloadAttachment: TypetalkRequest {
	public typealias APIKitResponse = NSData
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

	public var parameters: [String: AnyObject] {
		var p: [String: AnyObject] = [:]
		if let v = type { p["type"] = v.toJSON() }
		return p
	}
}

