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
		return "v1/profile"
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
		return "v1/accounts/profile/\(accountName)"
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
		return "v1/accounts/status"
	}

	public var parameters: Any? {
		return ["accountIds": accountIds.map { $0 as AnyObject } as AnyObject]
	}
}

public class GetTopics: TypetalkRequest {
	public typealias APIKitResponse = GetTopicsResponse
	public typealias Response = GetTopicsResponse
	public let spaceKey: String

	public init(spaceKey: String) {
		self.spaceKey = spaceKey
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v2/topics"
	}

	public var parameters: Any? {
		return ["spaceKey": spaceKey as AnyObject]
	}
}

public class GetDmTopics: TypetalkRequest {
	public typealias APIKitResponse = GetDmTopicsResponse
	public typealias Response = GetDmTopicsResponse
	public let spaceKey: String

	public init(spaceKey: String) {
		self.spaceKey = spaceKey
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v2/messages"
	}

	public var parameters: Any? {
		return ["spaceKey": spaceKey as AnyObject]
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
		return "v1/topics/\(topicId)"
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
	public let attachments: [PostMessage.Attachment]

	public init(topicId: Int, message: String, replyTo: Int? = nil, showLinkMeta: Bool? = nil, fileKeys: [String] = [], talkIds: [Int] = [], attachments: [PostMessage.Attachment] = []) {
		self.topicId = topicId
		self.message = message
		self.replyTo = replyTo
		self.showLinkMeta = showLinkMeta
		self.fileKeys = fileKeys
		self.talkIds = talkIds
		self.attachments = attachments
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/topics/\(topicId)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["message": message as AnyObject, "fileKeys": fileKeys.map { $0 as AnyObject } as AnyObject, "talkIds": talkIds.map { $0 as AnyObject } as AnyObject, "attachments": attachments.map { $0 as AnyObject } as AnyObject]
		_ = replyTo.map { p["replyTo"] = $0 as AnyObject }
		_ = showLinkMeta.map { p["showLinkMeta"] = $0 as AnyObject }
		return p
	}

	public class Attachment {
		public let fileUrl: URL
		public let fileName: String

		public init(fileUrl: URL, fileName: String) {
			self.fileUrl = fileUrl
			self.fileName = fileName
		}
	}
}

public class UploadAttachment: TypetalkRequest {
	public typealias APIKitResponse = Attachment
	public typealias Response = Attachment
	public let topicId: Int
	public let file: Data

	public init(topicId: Int, file: Data) {
		self.topicId = topicId
		self.file = file
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/topics/\(topicId)/attachments"
	}

	public var parameters: Any? {
		return ["file": file as AnyObject]
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
		return "v1/topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
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
		return "v1/topics/\(topicId)/members/status"
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
		return "v1/topics/\(topicId)/posts/\(postId)"
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
		return "v1/topics/\(topicId)/posts/\(postId)"
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
		return "v1/topics/\(topicId)/posts/\(postId)"
	}

}

public class SearchMessages: TypetalkRequest {
	public typealias APIKitResponse = SearchMessagesResponse
	public typealias Response = SearchMessagesResponse
	public let q: String
	public let spaceKey: String
	public let topicIds: Int?
	public let hasAttachments: Bool?
	public let accountIds: [Int]?
	public let from: Date?
	public let to: Date?

	public init(q: String, spaceKey: String, topicIds: Int? = nil, hasAttachments: Bool? = nil, accountIds: [Int]? = nil, from: Date? = nil, to: Date? = nil) {
		self.q = q
		self.spaceKey = spaceKey
		self.topicIds = topicIds
		self.hasAttachments = hasAttachments
		self.accountIds = accountIds
		self.from = from
		self.to = to
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v2/search/posts"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["q": q as AnyObject, "spaceKey": spaceKey as AnyObject]
		_ = topicIds.map { p["topicIds"] = $0 as AnyObject }
		_ = hasAttachments.map { p["hasAttachments"] = $0 as AnyObject }
		_ = accountIds.map { p["accountIds"] = $0 as AnyObject }
		_ = from.map { p["from"] = $0 as AnyObject }
		_ = to.map { p["to"] = $0 as AnyObject }
		return p
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
		return "v1/topics/\(topicId)/posts/\(postId)/like"
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
		return "v1/topics/\(topicId)/posts/\(postId)/like"
	}

}

public class GetDirectMessages: TypetalkRequest {
	public typealias APIKitResponse = GetDirectMessagesResponse
	public typealias Response = GetDirectMessagesResponse
	public let spaceKey: String
	public let accountName: String
	public let count: Int?
	public let from: Int?
	public let direction: String?

	public init(spaceKey: String, accountName: String, count: Int? = nil, from: Int? = nil, direction: String? = nil) {
		self.spaceKey = spaceKey
		self.accountName = accountName
		self.count = count
		self.from = from
		self.direction = direction
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v2/spaces/\(spaceKey)/messages/@\(accountName)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = count.map { p["count"] = $0 as AnyObject }
		_ = from.map { p["from"] = $0 as AnyObject }
		_ = direction.map { p["direction"] = $0 as AnyObject }
		return p
	}
}

public class PostDirectMessage: TypetalkRequest {
	public typealias APIKitResponse = PostDirectMessageResponse
	public typealias Response = PostDirectMessageResponse
	public let spaceKey: String
	public let accountName: String
	public let message: String
	public let replyTo: Int?
	public let showLinkMeta: Bool?
	public let fileKeys: [String]
	public let talkIds: [Int]
	public let attachments: [PostDirectMessage.Attachment]

	public init(spaceKey: String, accountName: String, message: String, replyTo: Int? = nil, showLinkMeta: Bool? = nil, fileKeys: [String] = [], talkIds: [Int] = [], attachments: [PostDirectMessage.Attachment] = []) {
		self.spaceKey = spaceKey
		self.accountName = accountName
		self.message = message
		self.replyTo = replyTo
		self.showLinkMeta = showLinkMeta
		self.fileKeys = fileKeys
		self.talkIds = talkIds
		self.attachments = attachments
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v2/spaces/\(spaceKey)/messages/@\(accountName)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["message": message as AnyObject, "fileKeys": fileKeys.map { $0 as AnyObject } as AnyObject, "talkIds": talkIds.map { $0 as AnyObject } as AnyObject, "attachments": attachments.map { $0 as AnyObject } as AnyObject]
		_ = replyTo.map { p["replyTo"] = $0 as AnyObject }
		_ = showLinkMeta.map { p["showLinkMeta"] = $0 as AnyObject }
		return p
	}

	public class Attachment {
		public let fileUrl: URL
		public let fileName: String

		public init(fileUrl: URL, fileName: String) {
			self.fileUrl = fileUrl
			self.fileName = fileName
		}
	}
}

public class GetNotificationStatus: TypetalkRequest {
	public typealias APIKitResponse = GetNotificationStatusResponse
	public typealias Response = GetNotificationStatusResponse

	public init() {
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v5/notifications/status"
	}

}

public class OpenNotification: TypetalkRequest {
	public typealias APIKitResponse = NotificationStatus
	public typealias Response = NotificationStatus
	public let spaceKey: String

	public init(spaceKey: String) {
		self.spaceKey = spaceKey
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "v3/notifications"
	}

	public var parameters: Any? {
		return ["spaceKey": spaceKey as AnyObject]
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
		return "v1/bookmarks"
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
	public let spaceKey: String
	public let from: Int?
	public let unread: Bool?

	public init(spaceKey: String, from: Int? = nil, unread: Bool? = nil) {
		self.spaceKey = spaceKey
		self.from = from
		self.unread = unread
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v2/mentions"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["spaceKey": spaceKey as AnyObject]
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
		return "v1/mentions/\(mentionId)"
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
		return "v1/topics"
	}

	public var parameters: Any? {
		return ["name": name as AnyObject, "spaceKey": spaceKey as AnyObject, "addAccountIds": addAccountIds.map { $0 as AnyObject } as AnyObject, "addGroupIds": addGroupIds.map { $0 as AnyObject } as AnyObject]
	}
}

public class UpdateTopic: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public typealias Response = TopicWithAccounts
	public let topicId: Int
	public let name: String
	public let description: String?

	public init(topicId: Int, name: String, description: String? = nil) {
		self.topicId = topicId
		self.name = name
		self.description = description
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "v1/topics/\(topicId)"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["name": name as AnyObject]
		_ = description.map { p["description"] = $0 as AnyObject }
		return p
	}
}

public class DeleteTopic: TypetalkRequest {
	public typealias APIKitResponse = DeleteTopicResponse
	public typealias Response = DeleteTopicResponse
	public let topicId: Int

	public init(topicId: Int) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "v1/topics/\(topicId)"
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
		return "v1/topics/\(topicId)/details"
	}

}

public class UpdateTopicMembers: TypetalkRequest {
	public typealias APIKitResponse = TopicWithAccounts
	public typealias Response = TopicWithAccounts
	public let topicId: Int

	public init(topicId: Int) {
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/topics/\(topicId)/members/update"
	}

}

public class GetSpaces: TypetalkRequest {
	public typealias APIKitResponse = GetSpacesResponse
	public typealias Response = GetSpacesResponse
	public let excludesGuest: Bool?

	public init(excludesGuest: Bool? = nil) {
		self.excludesGuest = excludesGuest
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v1/spaces"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = excludesGuest.map { p["excludesGuest"] = $0 as AnyObject }
		return p
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
		return "v1/spaces/\(spaceKey)/members"
	}

}

public class GetFriends: TypetalkRequest {
	public typealias APIKitResponse = GetFriendsResponse
	public typealias Response = GetFriendsResponse
	public let q: String
	public let spaceKey: String
	public let offset: Int?
	public let count: Int?

	public init(q: String, spaceKey: String, offset: Int? = nil, count: Int? = nil) {
		self.q = q
		self.spaceKey = spaceKey
		self.offset = offset
		self.count = count
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v4/search/friends"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["q": q as AnyObject, "spaceKey": spaceKey as AnyObject]
		_ = offset.map { p["offset"] = $0 as AnyObject }
		_ = count.map { p["count"] = $0 as AnyObject }
		return p
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
		return "v1/topics/\(topicId)/talks"
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
		return "v1/topics/\(topicId)/talks/\(talkId)/posts"
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

	public init(topicId: Int, talkName: String, postIds: [Int]) {
		self.topicId = topicId
		self.talkName = talkName
		self.postIds = postIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/topics/\(topicId)/talks"
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
		return "v1/topics/\(topicId)/talks/\(talkId)"
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
		return "v1/topics/\(topicId)/talks/\(talkId)"
	}

}

public class AddMessageToTalk: TypetalkRequest {
	public typealias APIKitResponse = CreateTalkResponse
	public typealias Response = CreateTalkResponse
	public let topicId: Int
	public let talkId: Int
	public let postIds: [Int]

	public init(topicId: Int, talkId: Int, postIds: [Int]) {
		self.topicId = topicId
		self.talkId = talkId
		self.postIds = postIds
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/topics/\(topicId)/talks/\(talkId)/posts"
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

	public init(topicId: Int, talkId: Int, postIds: [Int]) {
		self.topicId = topicId
		self.talkId = talkId
		self.postIds = postIds
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "v1/topics/\(topicId)/talks/\(talkId)/posts"
	}

	public var parameters: Any? {
		return ["postIds": postIds.map { $0 as AnyObject } as AnyObject]
	}
}

public class GetReceivedLikes: TypetalkRequest {
	public typealias APIKitResponse = GetReceivedLikesResponse
	public typealias Response = GetReceivedLikesResponse
	public let spaceKey: String
	public let from: Int?

	public init(spaceKey: String, from: Int? = nil) {
		self.spaceKey = spaceKey
		self.from = from
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/likes/receive"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = from.map { p["from"] = $0 as AnyObject }
		return p
	}
}

public class GetGivenLikes: TypetalkRequest {
	public typealias APIKitResponse = GetGivenLikesResponse
	public typealias Response = GetGivenLikesResponse
	public let spaceKey: String
	public let from: Int?

	public init(spaceKey: String, from: Int? = nil) {
		self.spaceKey = spaceKey
		self.from = from
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/likes/give"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = from.map { p["from"] = $0 as AnyObject }
		return p
	}
}

public class DiscoverLikes: TypetalkRequest {
	public typealias APIKitResponse = GetReceivedLikesResponse
	public typealias Response = GetReceivedLikesResponse
	public let spaceKey: String
	public let from: Int?

	public init(spaceKey: String, from: Int? = nil) {
		self.spaceKey = spaceKey
		self.from = from
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/likes/discover"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = [:]
		_ = from.map { p["from"] = $0 as AnyObject }
		return p
	}
}

public class SaveReadLikes: TypetalkRequest {
	public typealias APIKitResponse = SaveReadLikesResponse
	public typealias Response = SaveReadLikesResponse
	public let spaceKey: String
	public let likeId: Int

	public init(spaceKey: String, likeId: Int) {
		self.spaceKey = spaceKey
		self.likeId = likeId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v2/likes/receive/bookmark/save"
	}

	public var parameters: Any? {
		return ["spaceKey": spaceKey as AnyObject, "likeId": likeId as AnyObject]
	}
}

public class CreateTopicGroup: TypetalkRequest {
	public typealias APIKitResponse = CreateTopicGroupResponse
	public typealias Response = CreateTopicGroupResponse
	public let spaceKey: String
	public let name: String
	public let topicId: Int?

	public init(spaceKey: String, name: String, topicId: Int? = nil) {
		self.spaceKey = spaceKey
		self.name = name
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopicGroups"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["name": name as AnyObject]
		_ = topicId.map { p["topicId"] = $0 as AnyObject }
		return p
	}
}

public class UpdateTopicGroup: TypetalkRequest {
	public typealias APIKitResponse = UpdateTopicGroupResponse
	public typealias Response = UpdateTopicGroupResponse
	public let spaceKey: String
	public let myTopicGroupId: Int
	public let name: String
	public let sortType: SortType
	public let isMuted: Bool

	public init(spaceKey: String, myTopicGroupId: Int, name: String, sortType: SortType, isMuted: Bool) {
		self.spaceKey = spaceKey
		self.myTopicGroupId = myTopicGroupId
		self.name = name
		self.sortType = sortType
		self.isMuted = isMuted
	}

	public var method: HTTPMethod {
		return .put
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopicGroups/\(myTopicGroupId)"
	}

	public var parameters: Any? {
		return ["name": name as AnyObject, "sortType": sortType.rawValue as AnyObject, "isMuted": isMuted as AnyObject]
	}
}

public class DeleteTopicGroup: TypetalkRequest {
	public typealias APIKitResponse = UpdateTopicGroupResponse
	public typealias Response = UpdateTopicGroupResponse
	public let spaceKey: String
	public let myTopicGroupId: Int

	public init(spaceKey: String, myTopicGroupId: Int) {
		self.spaceKey = spaceKey
		self.myTopicGroupId = myTopicGroupId
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopicGroups/\(myTopicGroupId)"
	}

}

public class GetMyTopics: TypetalkRequest {
	public typealias APIKitResponse = GetMyTopicsResponse
	public typealias Response = GetMyTopicsResponse
	public let spaceKey: String

	public init(spaceKey: String) {
		self.spaceKey = spaceKey
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopics"
	}

}

public class AddTopicToGroup: TypetalkRequest {
	public typealias APIKitResponse = AddTopicToGroupResponse
	public typealias Response = AddTopicToGroupResponse
	public let spaceKey: String
	public let myTopicGroupId: Int
	public let topicId: Int

	public init(spaceKey: String, myTopicGroupId: Int, topicId: Int) {
		self.spaceKey = spaceKey
		self.myTopicGroupId = myTopicGroupId
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopics/myTopicGroups/\(myTopicGroupId)/topics/\(topicId)/add"
	}

}

public class DeleteMyTopic: TypetalkRequest {
	public typealias APIKitResponse = DeleteMyTopicResponse
	public typealias Response = DeleteMyTopicResponse
	public let spaceKey: String
	public let topicId: Int

	public init(spaceKey: String, topicId: Int) {
		self.spaceKey = spaceKey
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .delete
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopics/topics/\(topicId)"
	}

}

public class PinTopic: TypetalkRequest {
	public typealias APIKitResponse = PinTopicResponse
	public typealias Response = PinTopicResponse
	public let spaceKey: String
	public let topicId: Int

	public init(spaceKey: String, topicId: Int) {
		self.spaceKey = spaceKey
		self.topicId = topicId
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "v1/spaces/\(spaceKey)/myTopics/pin"
	}

	public var parameters: Any? {
		return ["topicId": topicId as AnyObject]
	}
}

