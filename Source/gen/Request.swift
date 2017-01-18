// This file was auto-generated from Request.swift with swift-idl.

import Foundation
import APIKit


public class GetProfile: TypetalkRequest {
	public typealias APIKitResponse = GetProfileResponse
	public typealias Response = GetProfileResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "profile"
	}

}

public class GetTopics: TypetalkRequest {
	public typealias APIKitResponse = GetTopicsResponse
	public typealias Response = GetTopicsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "topics"
	}

}

public class GetMessages: TypetalkRequest {
	public typealias APIKitResponse = GetMessagesResponse
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
		return .get
	}

	public var path: String {
		return "topics/\(topicId)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = count.map { p["count"] = $0.toJSON() as AnyObject }
		_ = from.map { p["from"] = $0.toJSON() as AnyObject }
		_ = direction.map { p["direction"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class PostMessage: TypetalkRequest {
	public typealias APIKitResponse = PostMessageResponse
	public typealias Response = PostMessageResponse
	public let topicId: TopicID
	public let message: String
	public let replyTo: Int?
	public let showLinkMeta: Bool?
	public let fileKeys: [String]
	public let talkIds: [TalkID]

	public init(topicId: TopicID, message: String, replyTo: Int? = nil, showLinkMeta: Bool? = nil, fileKeys: [String] = [], talkIds: [TalkID] = []) {
		self.topicId = topicId
		self.message = message
		self.replyTo = replyTo
		self.showLinkMeta = showLinkMeta
		self.fileKeys = fileKeys
		self.talkIds = talkIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["message": message.toJSON() as AnyObject, "fileKeys": fileKeys.map { $0.toJSON() } as AnyObject, "talkIds": talkIds.map { $0.toJSON() } as AnyObject]
		_ = replyTo.map { p["replyTo"] = $0.toJSON() as AnyObject }
		_ = showLinkMeta.map { p["showLinkMeta"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class UploadAttachment: TypetalkRequest {
	public typealias APIKitResponse = Attachment
	public let topicId: TopicID
	public let name: String // router:"-"
	public let contents: Data // router:"-"

	public init(topicId: TopicID, name: String, contents: Data) {
		self.topicId = topicId
		self.name = name
		self.contents = contents
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/attachments"
	}

}

public class DownloadAttachment: TypetalkRequest {
	public typealias APIKitResponse = Data
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
		return .get
	}

	public var path: String {
		return "topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = type.map { p["type"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class GetTopicMembers: TypetalkRequest {
	public typealias APIKitResponse = GetTopicMembersResponse
	public typealias Response = GetTopicMembersResponse
	public let topicId: TopicID

	public init(topicId: TopicID) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "topics/\(topicId)/members/status"
	}

}

public class GetMessage: TypetalkRequest {
	public typealias APIKitResponse = GetMessageResponse
	public typealias Response = GetMessageResponse
	public let topicId: TopicID
	public let postId: PostID

	public init(topicId: TopicID, postId: PostID) {
		self.topicId = topicId
		self.postId = postId
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "topics/\(topicId)/posts/\(postId)"
	}

}

public class UpdateMessage: TypetalkRequest {
	public typealias APIKitResponse = PostMessageResponse
	public let topicId: TopicID
	public let postId: PostID
	public let message: String

	public init(topicId: TopicID, postId: PostID, message: String) {
		self.topicId = topicId
		self.postId = postId
		self.message = message
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "topics/\(topicId)/posts/\(postId)"
	}

	public var parameters: Any? {
		return ["message": message.toJSON() as AnyObject]
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
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)/posts/\(postId)"
	}

}

public class LikeMessage: TypetalkRequest {
	public typealias APIKitResponse = LikeMessageResponse
	public typealias Response = LikeMessageResponse
	public let topicId: TopicID
	public let postId: PostID

	public init(topicId: TopicID, postId: PostID) {
		self.topicId = topicId
		self.postId = postId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/posts/\(postId)/like"
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
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)/posts/\(postId)/like"
	}

}

public class FavoriteTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithUserInfo
	public let topicId: TopicID

	public init(topicId: TopicID) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/favorite"
	}

}

public class UnfavoriteTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithUserInfo
	public let topicId: TopicID

	public init(topicId: TopicID) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)/favorite"
	}

}

public class GetNotifications: TypetalkRequest {
	public typealias APIKitResponse = Notifications

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "notifications"
	}

}

public class GetNotificationStatus: TypetalkRequest {
	public typealias APIKitResponse = NotificationStatus

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "notifications/status"
	}

}

public class OpenNotification: TypetalkRequest {
	public typealias APIKitResponse = NotificationStatus

	public init() {
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "notifications"
	}

}

public class SaveReadTopic: TypetalkRequest {
	public typealias APIKitResponse = SaveReadTopicResponse
	public typealias Response = SaveReadTopicResponse
	public let topicId: TopicID
	public let postId: PostID?

	public init(topicId: TopicID, postId: PostID? = nil) {
		self.topicId = topicId
		self.postId = postId
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "bookmarks"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["topicId": topicId.toJSON() as AnyObject]
		_ = postId.map { p["postId"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class GetMentions: TypetalkRequest {
	public typealias APIKitResponse = GetMentionsResponse
	public typealias Response = GetMentionsResponse
	public let from: MentionID?
	public let unread: Bool?

	public init(from: MentionID? = nil, unread: Bool? = nil) {
		self.from = from
		self.unread = unread
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "mentions"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = from.map { p["from"] = $0.toJSON() as AnyObject }
		_ = unread.map { p["unread"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class SaveReadMention: TypetalkRequest {
	public typealias APIKitResponse = SaveReadMentionResponse
	public typealias Response = SaveReadMentionResponse
	public let mentionId: MentionID

	public init(mentionId: MentionID) {
		self.mentionId = mentionId
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "mentions/\(mentionId)"
	}

}

public class AcceptTeamInvite: TypetalkRequest {
	public typealias APIKitResponse = AcceptTeamInviteResponse
	public typealias Response = AcceptTeamInviteResponse
	public let teamId: TeamID
	public let inviteId: InviteID

	public init(teamId: TeamID, inviteId: InviteID) {
		self.teamId = teamId
		self.inviteId = inviteId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "teams/\(teamId)/members/invite/\(inviteId)/accept"
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
		return .post
	}

	public var path: String {
		return "teams/\(teamId)/members/invite/\(inviteId)/decline"
	}

}

public class AcceptTopicInvite: TypetalkRequest {
	public typealias APIKitResponse = AcceptTopicInviteResponse
	public typealias Response = AcceptTopicInviteResponse
	public let topicId: TopicID
	public let inviteId: InviteID

	public init(topicId: TopicID, inviteId: InviteID) {
		self.topicId = topicId
		self.inviteId = inviteId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/members/invite/\(inviteId)/accept"
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
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/members/invite/\(inviteId)/decline"
	}

}

public class CreateTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public let name: String
	public let spaceKey: String
	public let inviteMembers: [String]
	public let inviteMessage: String

	public init(name: String, spaceKey: String, inviteMembers: [String] = [], inviteMessage: String = "") {
		self.name = name
		self.spaceKey = spaceKey
		self.inviteMembers = inviteMembers
		self.inviteMessage = inviteMessage
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics"
	}

	public var parameters: Any? {
		return ["name": name.toJSON() as AnyObject, "spaceKey": spaceKey.toJSON() as AnyObject, "inviteMembers": inviteMembers.map { $0.toJSON() } as AnyObject, "inviteMessage": inviteMessage.toJSON() as AnyObject]
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
		return .put
	}

	public var path: String {
		return "topics/\(topicId)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = name.map { p["name"] = $0.toJSON() as AnyObject }
		_ = teamId.map { p["teamId"] = $0.toJSON() as AnyObject }
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
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)"
	}

}

public class GetTopicDetails: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public let topicId: TopicID

	public init(topicId: TopicID) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "topics/\(topicId)/details"
	}

}

public class UpdateTopicMembers: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public let topicId: TopicID
	public let addAccountIds: [String]
	public let addGroupIds: [String]
	public let removeAccountIds: [Int]
	public let removeGroupIds: [Int]

	public init(topicId: TopicID, addAccountIds: [String] = [], addGroupIds: [String] = [], removeAccountIds: [Int] = [], removeGroupIds: [Int] = []) {
		self.topicId = topicId
		self.addAccountIds = addAccountIds
		self.addGroupIds = addGroupIds
		self.removeAccountIds = removeAccountIds
		self.removeGroupIds = removeGroupIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/members/update"
	}

	public var parameters: Any? {
		return ["addAccountIds": addAccountIds.map { $0.toJSON() } as AnyObject, "addGroupIds": addGroupIds.map { $0.toJSON() } as AnyObject, "removeAccountIds": removeAccountIds.map { $0.toJSON() } as AnyObject, "removeGroupIds": removeGroupIds.map { $0.toJSON() } as AnyObject]
	}
}

public class GetSpaces: TypetalkRequest {
	public typealias APIKitResponse = GetSpacesResponse
	public typealias Response = GetSpacesResponse
	public let excludesGuest: Bool

	public init(excludesGuest: Bool = false) {
		self.excludesGuest = excludesGuest
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "spaces"
	}

	public var parameters: Any? {
		return ["excludesGuest": excludesGuest.toJSON() as AnyObject]
	}
}

public class GetSpaceMembers: TypetalkRequest {
	public typealias APIKitResponse = GetSpaceMembersResponse
	public typealias Response = GetSpaceMembersResponse
	public let spaceKey: String

	public init(spaceKey: String) {
		self.spaceKey = spaceKey
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "spaces/\(spaceKey)/members"
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
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/members/invite"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["inviteMembers": inviteMembers.map { $0.toJSON() } as AnyObject]
		_ = inviteMessage.map { p["inviteMessage"] = $0.toJSON() as AnyObject }
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
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/members/remove"
	}

	public var parameters: Any? {
		return ["removeInviteIds": removeInviteIds.map { $0.toJSON() } as AnyObject, "removeMemberIds": removeMemberIds.map { $0.toJSON() } as AnyObject]
	}
}

public class GetTeams: TypetalkRequest {
	public typealias APIKitResponse = GetTeamsResponse
	public typealias Response = GetTeamsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "teams"
	}

}

public class GetFriends: TypetalkRequest {
	public typealias APIKitResponse = GetFriendsResponse
	public typealias Response = GetFriendsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "search/friends"
	}

}

public class SearchAccounts: TypetalkRequest {
	public typealias APIKitResponse = Account
	public let nameOrEmailAddress: String

	public init(nameOrEmailAddress: String) {
		self.nameOrEmailAddress = nameOrEmailAddress
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "search/accounts"
	}

	public var parameters: Any? {
		return ["nameOrEmailAddress": nameOrEmailAddress.toJSON() as AnyObject]
	}
}

public class GetTalks: TypetalkRequest {
	public typealias APIKitResponse = GetTalksResponse
	public typealias Response = GetTalksResponse
	public let topicId: TopicID

	public init(topicId: TopicID) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "topics/\(topicId)/talks"
	}

}

public class GetTalk: TypetalkRequest {
	public typealias APIKitResponse = GetTalkResponse
	public typealias Response = GetTalkResponse
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
		return .get
	}

	public var path: String {
		return "topics/\(topicId)/talks/\(talkId)/posts"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = count.map { p["count"] = $0.toJSON() as AnyObject }
		_ = from.map { p["from"] = $0.toJSON() as AnyObject }
		_ = direction.map { p["direction"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class CreateTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public typealias Response = CreateTalkResponse
	public let topicId: TopicID
	public let talkName: String
	public let postIds: [PostID]

	public init(topicId: TopicID, talkName: String, postIds: [PostID] = []) {
		self.topicId = topicId
		self.talkName = talkName
		self.postIds = postIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/talks"
	}

	public var parameters: Any? {
		return ["talkName": talkName.toJSON() as AnyObject, "postIds": postIds.map { $0.toJSON() } as AnyObject]
	}
}

public class UpdateTalk: TypetalkRequest {
	public typealias APIKitResponse = UpdateTalkResponse
	public typealias Response = UpdateTalkResponse
	public let topicId: TopicID
	public let talkId: TalkID
	public let talkName: String

	public init(topicId: TopicID, talkId: TalkID, talkName: String) {
		self.topicId = topicId
		self.talkId = talkId
		self.talkName = talkName
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "topics/\(topicId)/talks/\(talkId)"
	}

	public var parameters: Any? {
		return ["talkName": talkName.toJSON() as AnyObject]
	}
}

public class DeleteTalk: TypetalkRequest {
	public typealias APIKitResponse = UpdateTalkResponse
	public let topicId: TopicID
	public let talkId: TalkID

	public init(topicId: TopicID, talkId: TalkID) {
		self.topicId = topicId
		self.talkId = talkId
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)/talks/\(talkId)"
	}

}

public class AddMessageToTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public let topicId: TopicID
	public let talkId: TalkID
	public let postIds: [PostID]

	public init(topicId: TopicID, talkId: TalkID, postIds: [PostID] = []) {
		self.topicId = topicId
		self.talkId = talkId
		self.postIds = postIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/talks/\(talkId)/posts"
	}

	public var parameters: Any? {
		return ["postIds": postIds.map { $0.toJSON() } as AnyObject]
	}
}

public class RemoveMessageFromTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public let topicId: TopicID
	public let talkId: TalkID
	public let postIds: [PostID]

	public init(topicId: TopicID, talkId: TalkID, postIds: [PostID] = []) {
		self.topicId = topicId
		self.talkId = talkId
		self.postIds = postIds
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)/talks/\(talkId)/posts"
	}

	public var parameters: Any? {
		return ["postIds": postIds.map { $0.toJSON() } as AnyObject]
	}
}

