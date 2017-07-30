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

public class GetFriendProfile: TypetalkRequest {
	public typealias APIKitResponse = AccountWithLoginStatus
	public typealias Response = AccountWithLoginStatus
	public let accountName: String

	public init(accountName: String) {
		self.accountName = accountName
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "accounts/profile/\(accountName)"
	}

}

public class GetOnlineStatus: TypetalkRequest {
	public typealias APIKitResponse = GetOnlineStatusResponse
	public typealias Response = GetOnlineStatusResponse
	public let accountIds: [Int]

	public init(accountIds: [Int]) {
		self.accountIds = accountIds
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "accounts/status"
	}

	public var parameters: Any? {
		return ["accountIds": accountIds.map { $0 as AnyObject } as AnyObject]
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

public class GetDmTopics: TypetalkRequest {
	public typealias APIKitResponse = GetDmTopicsResponse
	public typealias Response = GetDmTopicsResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "messages"
	}

}

public class GetMessages: TypetalkRequest {
	public typealias APIKitResponse = GetMessagesResponse
	public typealias Response = GetMessagesResponse
	public let topicId: Int
	public let count: Int?
	public let from: Int?
	public let direction: MessageDirection?

	public init(topicId: Int, count: Int? = nil, from: Int? = nil, direction: MessageDirection? = nil) {
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
		_ = count.map { p["count"] = $0 as AnyObject }
		_ = from.map { p["from"] = $0 as AnyObject }
		_ = direction.map { p["direction"] = $0.rawValue as AnyObject }
		return p
	}
}

public class PostMessage: TypetalkRequest {
	public typealias APIKitResponse = PostMessageResponse
	public typealias Response = PostMessageResponse
	public let topicId: Int
	public let message: String
	public let replyTo: Int?
	public let showLinkMeta: Bool?
	public let fileKeys: [String]
	public let talkIds: [Int]

	public init(topicId: Int, message: String, replyTo: Int? = nil, showLinkMeta: Bool? = nil, fileKeys: [String] = [], talkIds: [Int] = []) {
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
		var p: [String: AnyObject] = ["message": message as AnyObject, "fileKeys": fileKeys.map { $0 as AnyObject } as AnyObject, "talkIds": talkIds.map { $0 as AnyObject } as AnyObject]
		_ = replyTo.map { p["replyTo"] = $0 as AnyObject }
		_ = showLinkMeta.map { p["showLinkMeta"] = $0 as AnyObject }
		return p
	}
}

public class UploadAttachment: TypetalkRequest {
	public typealias APIKitResponse = Attachment
	public typealias Response = Attachment
	public let topicId: Int
	public let name: String // router:"-"
	public let contents: Data // router:"-"

	public init(topicId: Int, name: String, contents: Data) {
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
	public typealias Response = Data
	public let topicId: Int
	public let postId: Int
	public let attachmentId: Int
	public let filename: String
	public let type: AttachmentType?

	public init(topicId: Int, postId: Int, attachmentId: Int, filename: String, type: AttachmentType? = nil) {
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
		_ = type.map { p["type"] = $0.rawValue as AnyObject }
		return p
	}
}

public class GetTopicMembers: TypetalkRequest {
	public typealias APIKitResponse = GetTopicMembersResponse
	public typealias Response = GetTopicMembersResponse
	public let topicId: Int

	public init(topicId: Int) {
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
	public let topicId: Int
	public let postId: Int

	public init(topicId: Int, postId: Int) {
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
	public typealias Response = PostMessageResponse
	public let topicId: Int
	public let postId: Int
	public let message: String

	public init(topicId: Int, postId: Int, message: String) {
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
		return ["message": message as AnyObject]
	}
}

public class DeleteMessage: TypetalkRequest {
	public typealias APIKitResponse = Post
	public typealias Response = Post
	public let topicId: Int
	public let postId: Int

	public init(topicId: Int, postId: Int) {
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
	public let topicId: Int
	public let postId: Int

	public init(topicId: Int, postId: Int) {
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
	public typealias Response = LikeMessageResponse
	public let topicId: Int
	public let postId: Int

	public init(topicId: Int, postId: Int) {
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
	public typealias APIKitResponse = FavoriteTopicResponse
	public typealias Response = FavoriteTopicResponse
	public let topicId: Int

	public init(topicId: Int) {
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
	public typealias APIKitResponse = FavoriteTopicResponse
	public typealias Response = FavoriteTopicResponse
	public let topicId: Int

	public init(topicId: Int) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "topics/\(topicId)/favorite"
	}

}

public class GetDirectMessages: TypetalkRequest {
	public typealias APIKitResponse = GetDirectMessagesResponse
	public typealias Response = GetDirectMessagesResponse
	public let accountName: String
	public let count: Int?
	public let from: Int?
	public let direction: MessageDirection?

	public init(accountName: String, count: Int? = nil, from: Int? = nil, direction: MessageDirection? = nil) {
		self.accountName = accountName
		self.count = count
		self.from = from
		self.direction = direction
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "messages/@\(accountName)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = count.map { p["count"] = $0 as AnyObject }
		_ = from.map { p["from"] = $0 as AnyObject }
		_ = direction.map { p["direction"] = $0.rawValue as AnyObject }
		return p
	}
}

public class PostDirectMessage: TypetalkRequest {
	public typealias APIKitResponse = PostDirectMessageResponse
	public typealias Response = PostDirectMessageResponse
	public let accountName: String
	public let message: String
	public let replyTo: Int?
	public let showLinkMeta: Bool?
	public let fileKeys: [String]
	public let talkIds: [Int]

	public init(accountName: String, message: String, replyTo: Int? = nil, showLinkMeta: Bool? = nil, fileKeys: [String] = [], talkIds: [Int] = []) {
		self.accountName = accountName
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
		return "messages/@\(accountName)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["message": message as AnyObject, "fileKeys": fileKeys.map { $0 as AnyObject } as AnyObject, "talkIds": talkIds.map { $0 as AnyObject } as AnyObject]
		_ = replyTo.map { p["replyTo"] = $0 as AnyObject }
		_ = showLinkMeta.map { p["showLinkMeta"] = $0 as AnyObject }
		return p
	}
}

public class GetNotifications: TypetalkRequest {
	public typealias APIKitResponse = Notifications
	public typealias Response = Notifications

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
	public typealias Response = NotificationStatus

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
	public typealias Response = NotificationStatus

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
	public let topicId: Int
	public let postId: Int?

	public init(topicId: Int, postId: Int? = nil) {
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
		var p: [String: AnyObject] = ["topicId": topicId as AnyObject]
		_ = postId.map { p["postId"] = $0 as AnyObject }
		return p
	}
}

public class GetMentions: TypetalkRequest {
	public typealias APIKitResponse = GetMentionsResponse
	public typealias Response = GetMentionsResponse
	public let from: Int?
	public let unread: Bool?

	public init(from: Int? = nil, unread: Bool? = nil) {
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
		_ = from.map { p["from"] = $0 as AnyObject }
		_ = unread.map { p["unread"] = $0 as AnyObject }
		return p
	}
}

public class SaveReadMention: TypetalkRequest {
	public typealias APIKitResponse = SaveReadMentionResponse
	public typealias Response = SaveReadMentionResponse
	public let mentionId: Int

	public init(mentionId: Int) {
		self.mentionId = mentionId
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "mentions/\(mentionId)"
	}

}

public class CreateTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public typealias Response = TopicWithAccounts
	public let name: String
	public let spaceKey: String
	public let addAccountIds: [Int]
	public let addGroupIds: [Int]

	public init(name: String, spaceKey: String, addAccountIds: [Int] = [], addGroupIds: [Int] = []) {
		self.name = name
		self.spaceKey = spaceKey
		self.addAccountIds = addAccountIds
		self.addGroupIds = addGroupIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics"
	}

	public var parameters: Any? {
		return ["name": name as AnyObject, "spaceKey": spaceKey as AnyObject, "addAccountIds": addAccountIds.map { $0 as AnyObject } as AnyObject, "addGroupIds": addGroupIds.map { $0 as AnyObject } as AnyObject]
	}
}

public class UpdateTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public typealias Response = TopicWithAccounts
	public let topicId: Int
	public let name: String?
	public let description: String?

	public init(topicId: Int, name: String? = nil, description: String? = nil) {
		self.topicId = topicId
		self.name = name
		self.description = description
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "topics/\(topicId)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = name.map { p["name"] = $0 as AnyObject }
		_ = description.map { p["description"] = $0 as AnyObject }
		return p
	}
}

public class DeleteTopic: TypetalkRequest {
	public typealias APIKitResponse = Topic
	public typealias Response = Topic
	public let topicId: Int

	public init(topicId: Int) {
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
	public typealias Response = TopicWithAccounts
	public let topicId: Int

	public init(topicId: Int) {
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
	public typealias Response = TopicWithAccounts
	public let topicId: Int
	public let addAccountIds: [Int]
	public let addGroupIds: [Int]
	public let removeGroupIds: [Int]

	public init(topicId: Int, addAccountIds: [Int] = [], addGroupIds: [Int] = [], removeGroupIds: [Int] = []) {
		self.topicId = topicId
		self.addAccountIds = addAccountIds
		self.addGroupIds = addGroupIds
		self.removeGroupIds = removeGroupIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "topics/\(topicId)/members/update"
	}

	public var parameters: Any? {
		return ["addAccountIds": addAccountIds.map { $0 as AnyObject } as AnyObject, "addGroupIds": addGroupIds.map { $0 as AnyObject } as AnyObject, "removeGroupIds": removeGroupIds.map { $0 as AnyObject } as AnyObject]
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
		return ["excludesGuest": excludesGuest as AnyObject]
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
	public typealias Response = Account
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
		return ["nameOrEmailAddress": nameOrEmailAddress as AnyObject]
	}
}

public class GetTalks: TypetalkRequest {
	public typealias APIKitResponse = GetTalksResponse
	public typealias Response = GetTalksResponse
	public let topicId: Int

	public init(topicId: Int) {
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
	public let topicId: Int
	public let talkId: Int
	public let count: Int?
	public let from: Int?
	public let direction: MessageDirection?

	public init(topicId: Int, talkId: Int, count: Int? = nil, from: Int? = nil, direction: MessageDirection? = nil) {
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
		_ = count.map { p["count"] = $0 as AnyObject }
		_ = from.map { p["from"] = $0 as AnyObject }
		_ = direction.map { p["direction"] = $0.rawValue as AnyObject }
		return p
	}
}

public class CreateTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public typealias Response = CreateTalkResponse
	public let topicId: Int
	public let talkName: String
	public let postIds: [Int]

	public init(topicId: Int, talkName: String, postIds: [Int] = []) {
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
		return ["talkName": talkName as AnyObject, "postIds": postIds.map { $0 as AnyObject } as AnyObject]
	}
}

public class UpdateTalk: TypetalkRequest {
	public typealias APIKitResponse = UpdateTalkResponse
	public typealias Response = UpdateTalkResponse
	public let topicId: Int
	public let talkId: Int
	public let talkName: String

	public init(topicId: Int, talkId: Int, talkName: String) {
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
		return ["talkName": talkName as AnyObject]
	}
}

public class DeleteTalk: TypetalkRequest {
	public typealias APIKitResponse = UpdateTalkResponse
	public typealias Response = UpdateTalkResponse
	public let topicId: Int
	public let talkId: Int

	public init(topicId: Int, talkId: Int) {
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
	public typealias Response = CreateTalkResponse
	public let topicId: Int
	public let talkId: Int
	public let postIds: [Int]

	public init(topicId: Int, talkId: Int, postIds: [Int] = []) {
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
		return ["postIds": postIds.map { $0 as AnyObject } as AnyObject]
	}
}

public class RemoveMessageFromTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public typealias Response = CreateTalkResponse
	public let topicId: Int
	public let talkId: Int
	public let postIds: [Int]

	public init(topicId: Int, talkId: Int, postIds: [Int] = []) {
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
		return ["postIds": postIds.map { $0 as AnyObject } as AnyObject]
	}
}

