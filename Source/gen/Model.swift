// This file was auto-generated from Model.swift with swift-idl.

import Foundation


public enum MessageDirection: String, JSONDecodable {
	case Backward = "backward"
	case Forward = "forward"

	public static func parse(with JSONObject: Any) throws -> MessageDirection {
		if let v = JSONObject as? String, let val = MessageDirection(rawValue: v) {
			return val
		}
		throw JSONDecodeError.valueTranslationFailed(type: MessageDirection.self, object: JSONObject)
	}

	public func toJSON() -> String {
		return rawValue
	}
}

public enum AttachmentType: String, JSONDecodable {
	case Small = "small"
	case Medium = "medium"
	case Large = "large"

	public static func parse(with JSONObject: Any) throws -> AttachmentType {
		if let v = JSONObject as? String, let val = AttachmentType(rawValue: v) {
			return val
		}
		throw JSONDecodeError.valueTranslationFailed(type: AttachmentType.self, object: JSONObject)
	}

	public func toJSON() -> String {
		return rawValue
	}
}

public enum Scope: String, JSONDecodable {
	case my = "my"
	case topic_read = "topic.read"
	case topic_post = "topic.post"
	case topic_write = "topic.write"
	case topic_delete = "topic.delete"

	public static func parse(with JSONObject: Any) throws -> Scope {
		if let v = JSONObject as? String, let val = Scope(rawValue: v) {
			return val
		}
		throw JSONDecodeError.valueTranslationFailed(type: Scope.self, object: JSONObject)
	}

	public func toJSON() -> String {
		return rawValue
	}
}

public struct Account: JSONDecodable {
	public let id: Int
	public let name: String
	public let fullName: String
	public let suggestion: String
	public let imageUrl: URL
	public let imageUpdatedAt: Date?
	public let createdAt: Date
	public let updatedAt: Date
	public let isBot: Bool?
	public let mailAddress: String?

	public static func parse(with JSONObject: Any) throws -> Account {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			id = 0
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parse(with: v)
			}
		} else {
			name = ""
		}

		let fullName: String
		if let v: AnyObject = dic["fullName"] {
			if v is NSNull {
				fullName = ""
			} else {
				fullName = try String.parse(with: v)
			}
		} else {
			fullName = ""
		}

		let suggestion: String
		if let v: AnyObject = dic["suggestion"] {
			if v is NSNull {
				suggestion = ""
			} else {
				suggestion = try String.parse(with: v)
			}
		} else {
			suggestion = ""
		}

		let imageUrl: URL
		if let v: AnyObject = dic["imageUrl"] {
			if v is NSNull {
				imageUrl = URL(string: "INVALID")!
			} else {
				imageUrl = try URL.parse(with: v)
			}
		} else {
			imageUrl = URL(string: "INVALID")!
		}

		let imageUpdatedAt: Date?
		if let v: AnyObject = dic["imageUpdatedAt"] {
			if v is NSNull {
				imageUpdatedAt = nil
			} else {
				imageUpdatedAt = try Date.parse(with: v)
			}
		} else {
			imageUpdatedAt = nil
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = Date()
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = Date()
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		let isBot: Bool?
		if let v: AnyObject = dic["isBot"] {
			if v is NSNull {
				isBot = nil
			} else {
				isBot = try Bool.parse(with: v)
			}
		} else {
			isBot = nil
		}

		let mailAddress: String?
		if let v: AnyObject = dic["mailAddress"] {
			if v is NSNull {
				mailAddress = nil
			} else {
				mailAddress = try String.parse(with: v)
			}
		} else {
			mailAddress = nil
		}

		return Account(id: id, name: name, fullName: fullName, suggestion: suggestion, imageUrl: imageUrl, imageUpdatedAt: imageUpdatedAt, createdAt: createdAt, updatedAt: updatedAt, isBot: isBot, mailAddress: mailAddress)
	}

	public init(id: Int = 0, name: String = "", fullName: String = "", suggestion: String = "", imageUrl: URL = URL(string: "INVALID")!, imageUpdatedAt: Date? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), isBot: Bool? = nil, mailAddress: String? = nil) {
		self.id = id
		self.name = name
		self.fullName = fullName
		self.suggestion = suggestion
		self.imageUrl = imageUrl
		self.imageUpdatedAt = imageUpdatedAt
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.isBot = isBot
		self.mailAddress = mailAddress
	}
}

public struct AccountWithLoginStatus: JSONDecodable {
	public let status: LoginStatus?
	public let account: Account

	public static func parse(with JSONObject: Any) throws -> AccountWithLoginStatus {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let status: LoginStatus?
		if let v: AnyObject = dic["status"] {
			if v is NSNull {
				status = nil
			} else {
				status = try LoginStatus.parse(with: v)
			}
		} else {
			status = nil
		}

		let account: Account
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "account", object: JSONObject)
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "account", object: JSONObject)
		}

		return AccountWithLoginStatus(status: status, account: account)
	}

	public init(status: LoginStatus? = nil, account: Account) {
		self.status = status
		self.account = account
	}
}

public struct AccountWithOnlineStatus: JSONDecodable {
	public let account: Account
	public let online: Bool

	public static func parse(with JSONObject: Any) throws -> AccountWithOnlineStatus {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let account: Account
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "account", object: JSONObject)
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "account", object: JSONObject)
		}

		let online: Bool
		if let v: AnyObject = dic["online"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "online", object: JSONObject)
			} else {
				online = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "online", object: JSONObject)
		}

		return AccountWithOnlineStatus(account: account, online: online)
	}

	public init(account: Account, online: Bool) {
		self.account = account
		self.online = online
	}
}

public struct AccountWithMailAddress: JSONDecodable {
	public let account: Account
	public let mailAddress: String?

	public static func parse(with JSONObject: Any) throws -> AccountWithMailAddress {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let account: Account
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "account", object: JSONObject)
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "account", object: JSONObject)
		}

		let mailAddress: String?
		if let v: AnyObject = dic["mailAddress"] {
			if v is NSNull {
				mailAddress = nil
			} else {
				mailAddress = try String.parse(with: v)
			}
		} else {
			mailAddress = nil
		}

		return AccountWithMailAddress(account: account, mailAddress: mailAddress)
	}

	public init(account: Account, mailAddress: String? = nil) {
		self.account = account
		self.mailAddress = mailAddress
	}
}

public struct Attachment: JSONDecodable {
	public let contentType: String
	public let fileKey: String
	public let fileName: String
	public let fileSize: Int

	public static func parse(with JSONObject: Any) throws -> Attachment {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let contentType: String
		if let v: AnyObject = dic["contentType"] {
			if v is NSNull {
				contentType = ""
			} else {
				contentType = try String.parse(with: v)
			}
		} else {
			contentType = ""
		}

		let fileKey: String
		if let v: AnyObject = dic["fileKey"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "fileKey", object: JSONObject)
			} else {
				fileKey = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "fileKey", object: JSONObject)
		}

		let fileName: String
		if let v: AnyObject = dic["fileName"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "fileName", object: JSONObject)
			} else {
				fileName = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "fileName", object: JSONObject)
		}

		let fileSize: Int
		if let v: AnyObject = dic["fileSize"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "fileSize", object: JSONObject)
			} else {
				fileSize = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "fileSize", object: JSONObject)
		}

		return Attachment(contentType: contentType, fileKey: fileKey, fileName: fileName, fileSize: fileSize)
	}

	public init(contentType: String = "", fileKey: String, fileName: String, fileSize: Int) {
		self.contentType = contentType
		self.fileKey = fileKey
		self.fileName = fileName
		self.fileSize = fileSize
	}
}

public struct Bookmark: JSONDecodable {
	public let postId: Int
	public let updatedAt: Date

	public static func parse(with JSONObject: Any) throws -> Bookmark {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let postId: Int
		if let v: AnyObject = dic["postId"] {
			if v is NSNull {
				postId = 0
			} else {
				postId = try Int.parse(with: v)
			}
		} else {
			postId = 0
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		return Bookmark(postId: postId, updatedAt: updatedAt)
	}

	public init(postId: Int = 0, updatedAt: Date = Date()) {
		self.postId = postId
		self.updatedAt = updatedAt
	}
}

public struct DirectMessageTopic: JSONDecodable {
	public let topic: Topic
	public let unread: Unread
	public let directMessage: AccountWithLoginStatus

	public static func parse(with JSONObject: Any) throws -> DirectMessageTopic {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topic: Topic
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topic", object: JSONObject)
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topic", object: JSONObject)
		}

		let unread: Unread
		if let v: AnyObject = dic["unread"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "unread", object: JSONObject)
			} else {
				unread = try Unread.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "unread", object: JSONObject)
		}

		let directMessage: AccountWithLoginStatus
		if let v: AnyObject = dic["directMessage"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "directMessage", object: JSONObject)
			} else {
				directMessage = try AccountWithLoginStatus.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "directMessage", object: JSONObject)
		}

		return DirectMessageTopic(topic: topic, unread: unread, directMessage: directMessage)
	}

	public init(topic: Topic, unread: Unread, directMessage: AccountWithLoginStatus) {
		self.topic = topic
		self.unread = unread
		self.directMessage = directMessage
	}
}

public struct Embed: JSONDecodable {
	public let type: String
	public let version: Int
	public let providerName: String // json:"provider_name"
	public let providerUrl: URL? // json:"provider_url"
	public let title: String
	public let authorName: String // json:"author_name"
	public let authorUrl: URL? // json:"author_url"
	public let html: String
	public let width: Int
	public let height: Int

	public static func parse(with JSONObject: Any) throws -> Embed {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let type: String
		if let v: AnyObject = dic["type"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "type", object: JSONObject)
			} else {
				type = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "type", object: JSONObject)
		}

		let version: Int
		if let v: AnyObject = dic["version"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "version", object: JSONObject)
			} else {
				version = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "version", object: JSONObject)
		}

		let providerName: String
		if let v: AnyObject = dic["provider_name"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "provider_name", object: JSONObject)
			} else {
				providerName = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "provider_name", object: JSONObject)
		}

		let providerUrl: URL?
		if let v: AnyObject = dic["provider_url"] {
			if v is NSNull {
				providerUrl = nil
			} else {
				providerUrl = try URL.parse(with: v)
			}
		} else {
			providerUrl = nil
		}

		let title: String
		if let v: AnyObject = dic["title"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "title", object: JSONObject)
			} else {
				title = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "title", object: JSONObject)
		}

		let authorName: String
		if let v: AnyObject = dic["author_name"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "author_name", object: JSONObject)
			} else {
				authorName = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "author_name", object: JSONObject)
		}

		let authorUrl: URL?
		if let v: AnyObject = dic["author_url"] {
			if v is NSNull {
				authorUrl = nil
			} else {
				authorUrl = try URL.parse(with: v)
			}
		} else {
			authorUrl = nil
		}

		let html: String
		if let v: AnyObject = dic["html"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "html", object: JSONObject)
			} else {
				html = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "html", object: JSONObject)
		}

		let width: Int
		if let v: AnyObject = dic["width"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "width", object: JSONObject)
			} else {
				width = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "width", object: JSONObject)
		}

		let height: Int
		if let v: AnyObject = dic["height"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "height", object: JSONObject)
			} else {
				height = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "height", object: JSONObject)
		}

		return Embed(type: type, version: version, providerName: providerName, providerUrl: providerUrl, title: title, authorName: authorName, authorUrl: authorUrl, html: html, width: width, height: height)
	}

	public init(type: String, version: Int, providerName: String, providerUrl: URL? = nil, title: String, authorName: String, authorUrl: URL? = nil, html: String, width: Int, height: Int) {
		self.type = type
		self.version = version
		self.providerName = providerName
		self.providerUrl = providerUrl
		self.title = title
		self.authorName = authorName
		self.authorUrl = authorUrl
		self.html = html
		self.width = width
		self.height = height
	}
}

public struct Group: JSONDecodable {
	public let id: Int
	public let key: String
	public let name: String
	public let suggestion: String
	public let imageUrl: URL
	public let createdAt: Date
	public let updatedAt: Date

	public static func parse(with JSONObject: Any) throws -> Group {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "id", object: JSONObject)
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "id", object: JSONObject)
		}

		let key: String
		if let v: AnyObject = dic["key"] {
			if v is NSNull {
				key = ""
			} else {
				key = try String.parse(with: v)
			}
		} else {
			key = ""
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parse(with: v)
			}
		} else {
			name = ""
		}

		let suggestion: String
		if let v: AnyObject = dic["suggestion"] {
			if v is NSNull {
				suggestion = ""
			} else {
				suggestion = try String.parse(with: v)
			}
		} else {
			suggestion = ""
		}

		let imageUrl: URL
		if let v: AnyObject = dic["imageUrl"] {
			if v is NSNull {
				imageUrl = URL(string: "INVALID")!
			} else {
				imageUrl = try URL.parse(with: v)
			}
		} else {
			imageUrl = URL(string: "INVALID")!
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = Date()
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = Date()
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		return Group(id: id, key: key, name: name, suggestion: suggestion, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: Int, key: String = "", name: String = "", suggestion: String = "", imageUrl: URL = URL(string: "INVALID")!, createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.id = id
		self.key = key
		self.name = name
		self.suggestion = suggestion
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct GroupWithCount: JSONDecodable {
	public let group: Group
	public let memberCount: Int

	public static func parse(with JSONObject: Any) throws -> GroupWithCount {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let group: Group
		if let v: AnyObject = dic["group"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "group", object: JSONObject)
			} else {
				group = try Group.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "group", object: JSONObject)
		}

		let memberCount: Int
		if let v: AnyObject = dic["memberCount"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "memberCount", object: JSONObject)
			} else {
				memberCount = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "memberCount", object: JSONObject)
		}

		return GroupWithCount(group: group, memberCount: memberCount)
	}

	public init(group: Group, memberCount: Int) {
		self.group = group
		self.memberCount = memberCount
	}
}

public struct Like: JSONDecodable {
	public let id: Int
	public let postId: Int
	public let topicId: Int
	public let comment: String?
	public let account: Account?
	public let createdAt: Date?

	public static func parse(with JSONObject: Any) throws -> Like {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "id", object: JSONObject)
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "id", object: JSONObject)
		}

		let postId: Int
		if let v: AnyObject = dic["postId"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "postId", object: JSONObject)
			} else {
				postId = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "postId", object: JSONObject)
		}

		let topicId: Int
		if let v: AnyObject = dic["topicId"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topicId", object: JSONObject)
			} else {
				topicId = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topicId", object: JSONObject)
		}

		let comment: String?
		if let v: AnyObject = dic["comment"] {
			if v is NSNull {
				comment = nil
			} else {
				comment = try String.parse(with: v)
			}
		} else {
			comment = nil
		}

		let account: Account?
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				account = nil
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			account = nil
		}

		let createdAt: Date?
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = nil
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = nil
		}

		return Like(id: id, postId: postId, topicId: topicId, comment: comment, account: account, createdAt: createdAt)
	}

	public init(id: Int, postId: Int, topicId: Int, comment: String? = nil, account: Account? = nil, createdAt: Date? = nil) {
		self.id = id
		self.postId = postId
		self.topicId = topicId
		self.comment = comment
		self.account = account
		self.createdAt = createdAt
	}
}

public struct Link: JSONDecodable {
	public let id: Int
	public let url: URL
	public let contentType: String
	public let title: String
	public let description: String
	public let imageUrl: URL
	public let createdAt: Date
	public let updatedAt: Date
	public let embed: Embed?

	public static func parse(with JSONObject: Any) throws -> Link {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "id", object: JSONObject)
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "id", object: JSONObject)
		}

		let url: URL
		if let v: AnyObject = dic["url"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "url", object: JSONObject)
			} else {
				url = try URL.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "url", object: JSONObject)
		}

		let contentType: String
		if let v: AnyObject = dic["contentType"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "contentType", object: JSONObject)
			} else {
				contentType = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "contentType", object: JSONObject)
		}

		let title: String
		if let v: AnyObject = dic["title"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "title", object: JSONObject)
			} else {
				title = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "title", object: JSONObject)
		}

		let description: String
		if let v: AnyObject = dic["description"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "description", object: JSONObject)
			} else {
				description = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "description", object: JSONObject)
		}

		let imageUrl: URL
		if let v: AnyObject = dic["imageUrl"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "imageUrl", object: JSONObject)
			} else {
				imageUrl = try URL.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "imageUrl", object: JSONObject)
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "createdAt", object: JSONObject)
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "createdAt", object: JSONObject)
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "updatedAt", object: JSONObject)
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "updatedAt", object: JSONObject)
		}

		let embed: Embed?
		if let v: AnyObject = dic["embed"] {
			if v is NSNull {
				embed = nil
			} else {
				embed = try Embed.parse(with: v)
			}
		} else {
			embed = nil
		}

		return Link(id: id, url: url, contentType: contentType, title: title, description: description, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt, embed: embed)
	}

	public init(id: Int, url: URL, contentType: String, title: String, description: String, imageUrl: URL, createdAt: Date, updatedAt: Date, embed: Embed? = nil) {
		self.id = id
		self.url = url
		self.contentType = contentType
		self.title = title
		self.description = description
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.embed = embed
	}
}

public struct LoginStatus: JSONDecodable {
	public let mobile: String?
	public let web: String?
	public let presence: String

	public static func parse(with JSONObject: Any) throws -> LoginStatus {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let mobile: String?
		if let v: AnyObject = dic["mobile"] {
			if v is NSNull {
				mobile = nil
			} else {
				mobile = try String.parse(with: v)
			}
		} else {
			mobile = nil
		}

		let web: String?
		if let v: AnyObject = dic["web"] {
			if v is NSNull {
				web = nil
			} else {
				web = try String.parse(with: v)
			}
		} else {
			web = nil
		}

		let presence: String
		if let v: AnyObject = dic["presence"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "presence", object: JSONObject)
			} else {
				presence = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "presence", object: JSONObject)
		}

		return LoginStatus(mobile: mobile, web: web, presence: presence)
	}

	public init(mobile: String? = nil, web: String? = nil, presence: String) {
		self.mobile = mobile
		self.web = web
		self.presence = presence
	}
}

public struct Member: JSONDecodable {
	public let account: Account
	public let role: String

	public static func parse(with JSONObject: Any) throws -> Member {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let account: Account
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "account", object: JSONObject)
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "account", object: JSONObject)
		}

		let role: String
		if let v: AnyObject = dic["role"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "role", object: JSONObject)
			} else {
				role = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "role", object: JSONObject)
		}

		return Member(account: account, role: role)
	}

	public init(account: Account, role: String) {
		self.account = account
		self.role = role
	}
}

public struct Mention: JSONDecodable {
	public let id: Int
	public let readAt: Date?
	public let post: Post?

	public static func parse(with JSONObject: Any) throws -> Mention {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			id = 0
		}

		let readAt: Date?
		if let v: AnyObject = dic["readAt"] {
			if v is NSNull {
				readAt = nil
			} else {
				readAt = try Date.parse(with: v)
			}
		} else {
			readAt = nil
		}

		let post: Post?
		if let v: AnyObject = dic["post"] {
			if v is NSNull {
				post = nil
			} else {
				post = try Post.parse(with: v)
			}
		} else {
			post = nil
		}

		return Mention(id: id, readAt: readAt, post: post)
	}

	public init(id: Int = 0, readAt: Date? = nil, post: Post? = nil) {
		self.id = id
		self.readAt = readAt
		self.post = post
	}
}

public struct Notifications: JSONDecodable {
	public let mentions: [Mention]
	public let invites: Notifications.Invites

	public static func parse(with JSONObject: Any) throws -> Notifications {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let mentions: [Mention]
		if let v: AnyObject = dic["mentions"] {
			if v is NSNull {
				mentions = []
			} else {
				mentions = try Mention.parseAsArray(with: v)
			}
		} else {
			mentions = []
		}

		let invites: Notifications.Invites
		if let v: AnyObject = dic["invites"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "invites", object: JSONObject)
			} else {
				invites = try Notifications.Invites.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "invites", object: JSONObject)
		}

		return Notifications(mentions: mentions, invites: invites)
	}

	public init(mentions: [Mention] = [], invites: Notifications.Invites) {
		self.mentions = mentions
		self.invites = invites
	}

	public struct Invites: JSONDecodable {
		public let teams: [TeamInvite]
		public let topics: [TopicInvite]

		public static func parse(with JSONObject: Any) throws -> Invites {
			guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
				throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
			}

			let teams: [TeamInvite]
			if let v: AnyObject = dic["teams"] {
				if v is NSNull {
					teams = []
				} else {
					teams = try TeamInvite.parseAsArray(with: v)
				}
			} else {
				teams = []
			}

			let topics: [TopicInvite]
			if let v: AnyObject = dic["topics"] {
				if v is NSNull {
					topics = []
				} else {
					topics = try TopicInvite.parseAsArray(with: v)
				}
			} else {
				topics = []
			}

			return Invites(teams: teams, topics: topics)
		}

		public init(teams: [TeamInvite] = [], topics: [TopicInvite] = []) {
			self.teams = teams
			self.topics = topics
		}
	}
}

public struct NotificationStatus: JSONDecodable {
	public let mention: NotificationStatus.Mention?
	public let access: NotificationStatus.Access?
	public let invite: NotificationStatus.Invite?
	public let like: NotificationStatus.Like?
	public let directMessage: NotificationStatus.DirectMessage?

	public static func parse(with JSONObject: Any) throws -> NotificationStatus {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let mention: NotificationStatus.Mention?
		if let v: AnyObject = dic["mention"] {
			if v is NSNull {
				mention = nil
			} else {
				mention = try NotificationStatus.Mention.parse(with: v)
			}
		} else {
			mention = nil
		}

		let access: NotificationStatus.Access?
		if let v: AnyObject = dic["access"] {
			if v is NSNull {
				access = nil
			} else {
				access = try NotificationStatus.Access.parse(with: v)
			}
		} else {
			access = nil
		}

		let invite: NotificationStatus.Invite?
		if let v: AnyObject = dic["invite"] {
			if v is NSNull {
				invite = nil
			} else {
				invite = try NotificationStatus.Invite.parse(with: v)
			}
		} else {
			invite = nil
		}

		let like: NotificationStatus.Like?
		if let v: AnyObject = dic["like"] {
			if v is NSNull {
				like = nil
			} else {
				like = try NotificationStatus.Like.parse(with: v)
			}
		} else {
			like = nil
		}

		let directMessage: NotificationStatus.DirectMessage?
		if let v: AnyObject = dic["directMessage"] {
			if v is NSNull {
				directMessage = nil
			} else {
				directMessage = try NotificationStatus.DirectMessage.parse(with: v)
			}
		} else {
			directMessage = nil
		}

		return NotificationStatus(mention: mention, access: access, invite: invite, like: like, directMessage: directMessage)
	}

	public init(mention: NotificationStatus.Mention? = nil, access: NotificationStatus.Access? = nil, invite: NotificationStatus.Invite? = nil, like: NotificationStatus.Like? = nil, directMessage: NotificationStatus.DirectMessage? = nil) {
		self.mention = mention
		self.access = access
		self.invite = invite
		self.like = like
		self.directMessage = directMessage
	}

	public struct Mention: JSONDecodable {
		public let unread: Int?

		public static func parse(with JSONObject: Any) throws -> Mention {
			guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
				throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
			}

			let unread: Int?
			if let v: AnyObject = dic["unread"] {
				if v is NSNull {
					unread = nil
				} else {
					unread = try Int.parse(with: v)
				}
			} else {
				unread = nil
			}

			return Mention(unread: unread)
		}

		public init(unread: Int? = nil) {
			self.unread = unread
		}
	}

	public struct Access: JSONDecodable {
		public let unopened: Int?

		public static func parse(with JSONObject: Any) throws -> Access {
			guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
				throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
			}

			let unopened: Int?
			if let v: AnyObject = dic["unopened"] {
				if v is NSNull {
					unopened = nil
				} else {
					unopened = try Int.parse(with: v)
				}
			} else {
				unopened = nil
			}

			return Access(unopened: unopened)
		}

		public init(unopened: Int? = nil) {
			self.unopened = unopened
		}
	}

	public struct Invite: JSONDecodable {
		public let team: NotificationStatus.Invite.PendingCount?
		public let topic: NotificationStatus.Invite.PendingCount?

		public static func parse(with JSONObject: Any) throws -> Invite {
			guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
				throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
			}

			let team: NotificationStatus.Invite.PendingCount?
			if let v: AnyObject = dic["team"] {
				if v is NSNull {
					team = nil
				} else {
					team = try NotificationStatus.Invite.PendingCount.parse(with: v)
				}
			} else {
				team = nil
			}

			let topic: NotificationStatus.Invite.PendingCount?
			if let v: AnyObject = dic["topic"] {
				if v is NSNull {
					topic = nil
				} else {
					topic = try NotificationStatus.Invite.PendingCount.parse(with: v)
				}
			} else {
				topic = nil
			}

			return Invite(team: team, topic: topic)
		}

		public init(team: NotificationStatus.Invite.PendingCount? = nil, topic: NotificationStatus.Invite.PendingCount? = nil) {
			self.team = team
			self.topic = topic
		}

		public struct PendingCount: JSONDecodable {
			public let pending: Int?

			public static func parse(with JSONObject: Any) throws -> PendingCount {
				guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
					throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
				}

				let pending: Int?
				if let v: AnyObject = dic["pending"] {
					if v is NSNull {
						pending = nil
					} else {
						pending = try Int.parse(with: v)
					}
				} else {
					pending = nil
				}

				return PendingCount(pending: pending)
			}

			public init(pending: Int? = nil) {
				self.pending = pending
			}
		}
	}

	public struct Like: JSONDecodable {
		public let receive: Int?

		public static func parse(with JSONObject: Any) throws -> Like {
			guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
				throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
			}

			let receive: Int?
			if let v: AnyObject = dic["receive"] {
				if v is NSNull {
					receive = nil
				} else {
					receive = try Int.parse(with: v)
				}
			} else {
				receive = nil
			}

			return Like(receive: receive)
		}

		public init(receive: Int? = nil) {
			self.receive = receive
		}
	}

	public struct DirectMessage: JSONDecodable {
		public let unreadTopics: Int?

		public static func parse(with JSONObject: Any) throws -> DirectMessage {
			guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
				throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
			}

			let unreadTopics: Int?
			if let v: AnyObject = dic["unreadTopics"] {
				if v is NSNull {
					unreadTopics = nil
				} else {
					unreadTopics = try Int.parse(with: v)
				}
			} else {
				unreadTopics = nil
			}

			return DirectMessage(unreadTopics: unreadTopics)
		}

		public init(unreadTopics: Int? = nil) {
			self.unreadTopics = unreadTopics
		}
	}
}

public class Post: JSONDecodable {
	public let id: Int
	public let topicId: Int
	public let topic: Topic?
	public let replyTo: Int?
	public let message: String
	public let account: Account
	public let mention: Mention?
	public let attachments: [URLAttachment]
	public let likes: [Like]
	public let talks: [Talk]
	public let links: [Link]
	public let createdAt: Date
	public let updatedAt: Date

	public class func parse(with JSONObject: Any) throws -> Post {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			id = 0
		}

		let topicId: Int
		if let v: AnyObject = dic["topicId"] {
			if v is NSNull {
				topicId = 0
			} else {
				topicId = try Int.parse(with: v)
			}
		} else {
			topicId = 0
		}

		let topic: Topic?
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				topic = nil
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			topic = nil
		}

		let replyTo: Int?
		if let v: AnyObject = dic["replyTo"] {
			if v is NSNull {
				replyTo = nil
			} else {
				replyTo = try Int.parse(with: v)
			}
		} else {
			replyTo = nil
		}

		let message: String
		if let v: AnyObject = dic["message"] {
			if v is NSNull {
				message = ""
			} else {
				message = try String.parse(with: v)
			}
		} else {
			message = ""
		}

		let account: Account
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				account = Account()
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			account = Account()
		}

		let mention: Mention?
		if let v: AnyObject = dic["mention"] {
			if v is NSNull {
				mention = nil
			} else {
				mention = try Mention.parse(with: v)
			}
		} else {
			mention = nil
		}

		let attachments: [URLAttachment]
		if let v: AnyObject = dic["attachments"] {
			if v is NSNull {
				attachments = []
			} else {
				attachments = try URLAttachment.parseAsArray(with: v)
			}
		} else {
			attachments = []
		}

		let likes: [Like]
		if let v: AnyObject = dic["likes"] {
			if v is NSNull {
				likes = []
			} else {
				likes = try Like.parseAsArray(with: v)
			}
		} else {
			likes = []
		}

		let talks: [Talk]
		if let v: AnyObject = dic["talks"] {
			if v is NSNull {
				talks = []
			} else {
				talks = try Talk.parseAsArray(with: v)
			}
		} else {
			talks = []
		}

		let links: [Link]
		if let v: AnyObject = dic["links"] {
			if v is NSNull {
				links = []
			} else {
				links = try Link.parseAsArray(with: v)
			}
		} else {
			links = []
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = Date()
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = Date()
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		return Post(id: id, topicId: topicId, topic: topic, replyTo: replyTo, message: message, account: account, mention: mention, attachments: attachments, likes: likes, talks: talks, links: links, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: Int = 0, topicId: Int = 0, topic: Topic? = nil, replyTo: Int? = nil, message: String = "", account: Account = Account(), mention: Mention? = nil, attachments: [URLAttachment] = [], likes: [Like] = [], talks: [Talk] = [], links: [Link] = [], createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.id = id
		self.topicId = topicId
		self.topic = topic
		self.replyTo = replyTo
		self.message = message
		self.account = account
		self.mention = mention
		self.attachments = attachments
		self.likes = likes
		self.talks = talks
		self.links = links
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct Talk: JSONDecodable {
	public let id: Int
	public let topicId: Int
	public let name: String
	public let suggestion: String
	public let createdAt: Date
	public let updatedAt: Date
	public let backlog: String?

	public static func parse(with JSONObject: Any) throws -> Talk {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "id", object: JSONObject)
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "id", object: JSONObject)
		}

		let topicId: Int
		if let v: AnyObject = dic["topicId"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topicId", object: JSONObject)
			} else {
				topicId = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topicId", object: JSONObject)
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "name", object: JSONObject)
			} else {
				name = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "name", object: JSONObject)
		}

		let suggestion: String
		if let v: AnyObject = dic["suggestion"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "suggestion", object: JSONObject)
			} else {
				suggestion = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "suggestion", object: JSONObject)
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "createdAt", object: JSONObject)
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "createdAt", object: JSONObject)
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "updatedAt", object: JSONObject)
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "updatedAt", object: JSONObject)
		}

		let backlog: String?
		if let v: AnyObject = dic["backlog"] {
			if v is NSNull {
				backlog = nil
			} else {
				backlog = try String.parse(with: v)
			}
		} else {
			backlog = nil
		}

		return Talk(id: id, topicId: topicId, name: name, suggestion: suggestion, createdAt: createdAt, updatedAt: updatedAt, backlog: backlog)
	}

	public init(id: Int, topicId: Int, name: String, suggestion: String, createdAt: Date, updatedAt: Date, backlog: String? = nil) {
		self.id = id
		self.topicId = topicId
		self.name = name
		self.suggestion = suggestion
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.backlog = backlog
	}
}

public struct Team: JSONDecodable {
	public let id: Int
	public let name: String
	public let imageUrl: URL
	public let createdAt: Date
	public let updatedAt: Date

	public static func parse(with JSONObject: Any) throws -> Team {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			id = 0
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parse(with: v)
			}
		} else {
			name = ""
		}

		let imageUrl: URL
		if let v: AnyObject = dic["imageUrl"] {
			if v is NSNull {
				imageUrl = URL(string: "INVALID")!
			} else {
				imageUrl = try URL.parse(with: v)
			}
		} else {
			imageUrl = URL(string: "INVALID")!
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = Date()
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = Date()
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		return Team(id: id, name: name, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: Int = 0, name: String = "", imageUrl: URL = URL(string: "INVALID")!, createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.id = id
		self.name = name
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct TeamWithMembers: JSONDecodable {
	public let team: Team
	public let members: [Member]

	public static func parse(with JSONObject: Any) throws -> TeamWithMembers {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let team: Team
		if let v: AnyObject = dic["team"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "team", object: JSONObject)
			} else {
				team = try Team.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "team", object: JSONObject)
		}

		let members: [Member]
		if let v: AnyObject = dic["members"] {
			if v is NSNull {
				members = []
			} else {
				members = try Member.parseAsArray(with: v)
			}
		} else {
			members = []
		}

		return TeamWithMembers(team: team, members: members)
	}

	public init(team: Team, members: [Member] = []) {
		self.team = team
		self.members = members
	}
}

public struct TeamWithCount: JSONDecodable {
	public let team: Team
	public let memberCount: Int

	public static func parse(with JSONObject: Any) throws -> TeamWithCount {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let team: Team
		if let v: AnyObject = dic["team"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "team", object: JSONObject)
			} else {
				team = try Team.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "team", object: JSONObject)
		}

		let memberCount: Int
		if let v: AnyObject = dic["memberCount"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "memberCount", object: JSONObject)
			} else {
				memberCount = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "memberCount", object: JSONObject)
		}

		return TeamWithCount(team: team, memberCount: memberCount)
	}

	public init(team: Team, memberCount: Int) {
		self.team = team
		self.memberCount = memberCount
	}
}

public struct TeamInvite: JSONDecodable {
	public let id: Int
	public let sender: Account?
	public let account: Account?
	public let message: String
	public let createdAt: Date?
	public let updatedAt: Date?
	public let mailAddress: String?
	public let status: String
	public let team: Team
	public let role: String?

	public static func parse(with JSONObject: Any) throws -> TeamInvite {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "id", object: JSONObject)
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "id", object: JSONObject)
		}

		let sender: Account?
		if let v: AnyObject = dic["sender"] {
			if v is NSNull {
				sender = nil
			} else {
				sender = try Account.parse(with: v)
			}
		} else {
			sender = nil
		}

		let account: Account?
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				account = nil
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			account = nil
		}

		let message: String
		if let v: AnyObject = dic["message"] {
			if v is NSNull {
				message = ""
			} else {
				message = try String.parse(with: v)
			}
		} else {
			message = ""
		}

		let createdAt: Date?
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = nil
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = nil
		}

		let updatedAt: Date?
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = nil
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = nil
		}

		let mailAddress: String?
		if let v: AnyObject = dic["mailAddress"] {
			if v is NSNull {
				mailAddress = nil
			} else {
				mailAddress = try String.parse(with: v)
			}
		} else {
			mailAddress = nil
		}

		let status: String
		if let v: AnyObject = dic["status"] {
			if v is NSNull {
				status = ""
			} else {
				status = try String.parse(with: v)
			}
		} else {
			status = ""
		}

		let team: Team
		if let v: AnyObject = dic["team"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "team", object: JSONObject)
			} else {
				team = try Team.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "team", object: JSONObject)
		}

		let role: String?
		if let v: AnyObject = dic["role"] {
			if v is NSNull {
				role = nil
			} else {
				role = try String.parse(with: v)
			}
		} else {
			role = nil
		}

		return TeamInvite(id: id, sender: sender, account: account, message: message, createdAt: createdAt, updatedAt: updatedAt, mailAddress: mailAddress, status: status, team: team, role: role)
	}

	public init(id: Int, sender: Account? = nil, account: Account? = nil, message: String = "", createdAt: Date? = nil, updatedAt: Date? = nil, mailAddress: String? = nil, status: String = "", team: Team, role: String? = nil) {
		self.id = id
		self.sender = sender
		self.account = account
		self.message = message
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.mailAddress = mailAddress
		self.status = status
		self.team = team
		self.role = role
	}
}

public struct Thumbnail: JSONDecodable {
	public let type: AttachmentType
	public let fileSize: Int
	public let width: Int
	public let height: Int

	public static func parse(with JSONObject: Any) throws -> Thumbnail {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let type: AttachmentType
		if let v: AnyObject = dic["type"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "type", object: JSONObject)
			} else {
				type = try AttachmentType.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "type", object: JSONObject)
		}

		let fileSize: Int
		if let v: AnyObject = dic["fileSize"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "fileSize", object: JSONObject)
			} else {
				fileSize = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "fileSize", object: JSONObject)
		}

		let width: Int
		if let v: AnyObject = dic["width"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "width", object: JSONObject)
			} else {
				width = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "width", object: JSONObject)
		}

		let height: Int
		if let v: AnyObject = dic["height"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "height", object: JSONObject)
			} else {
				height = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "height", object: JSONObject)
		}

		return Thumbnail(type: type, fileSize: fileSize, width: width, height: height)
	}

	public init(type: AttachmentType, fileSize: Int, width: Int, height: Int) {
		self.type = type
		self.fileSize = fileSize
		self.width = width
		self.height = height
	}
}

public struct Topic: JSONDecodable {
	public let id: Int
	public let name: String
	public let description: String
	public let suggestion: String
	public let lastPostedAt: Date?
	public let createdAt: Date
	public let updatedAt: Date
	public let isDirectMessage: Bool?

	public static func parse(with JSONObject: Any) throws -> Topic {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			id = 0
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parse(with: v)
			}
		} else {
			name = ""
		}

		let description: String
		if let v: AnyObject = dic["description"] {
			if v is NSNull {
				description = ""
			} else {
				description = try String.parse(with: v)
			}
		} else {
			description = ""
		}

		let suggestion: String
		if let v: AnyObject = dic["suggestion"] {
			if v is NSNull {
				suggestion = ""
			} else {
				suggestion = try String.parse(with: v)
			}
		} else {
			suggestion = ""
		}

		let lastPostedAt: Date?
		if let v: AnyObject = dic["lastPostedAt"] {
			if v is NSNull {
				lastPostedAt = nil
			} else {
				lastPostedAt = try Date.parse(with: v)
			}
		} else {
			lastPostedAt = nil
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = Date()
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = Date()
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		let isDirectMessage: Bool?
		if let v: AnyObject = dic["isDirectMessage"] {
			if v is NSNull {
				isDirectMessage = nil
			} else {
				isDirectMessage = try Bool.parse(with: v)
			}
		} else {
			isDirectMessage = nil
		}

		return Topic(id: id, name: name, description: description, suggestion: suggestion, lastPostedAt: lastPostedAt, createdAt: createdAt, updatedAt: updatedAt, isDirectMessage: isDirectMessage)
	}

	public init(id: Int = 0, name: String = "", description: String = "", suggestion: String = "", lastPostedAt: Date? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), isDirectMessage: Bool? = nil) {
		self.id = id
		self.name = name
		self.description = description
		self.suggestion = suggestion
		self.lastPostedAt = lastPostedAt
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.isDirectMessage = isDirectMessage
	}
}

public struct TopicWithAccounts: JSONDecodable {
	public let topic: Topic
	public let mySpace: Space?
	public let teams: [TeamWithMembers]
	public let groups: [GroupWithCount]
	public let accounts: [Account]
	public let invitingAccounts: [Account]
	public let invites: [TopicInvite]
	public let accountsForApi: [Account]
	public let integrations: [Account]
	public let remainingInvitations: Bool?

	public static func parse(with JSONObject: Any) throws -> TopicWithAccounts {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topic: Topic
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topic", object: JSONObject)
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topic", object: JSONObject)
		}

		let mySpace: Space?
		if let v: AnyObject = dic["mySpace"] {
			if v is NSNull {
				mySpace = nil
			} else {
				mySpace = try Space.parse(with: v)
			}
		} else {
			mySpace = nil
		}

		let teams: [TeamWithMembers]
		if let v: AnyObject = dic["teams"] {
			if v is NSNull {
				teams = []
			} else {
				teams = try TeamWithMembers.parseAsArray(with: v)
			}
		} else {
			teams = []
		}

		let groups: [GroupWithCount]
		if let v: AnyObject = dic["groups"] {
			if v is NSNull {
				groups = []
			} else {
				groups = try GroupWithCount.parseAsArray(with: v)
			}
		} else {
			groups = []
		}

		let accounts: [Account]
		if let v: AnyObject = dic["accounts"] {
			if v is NSNull {
				accounts = []
			} else {
				accounts = try Account.parseAsArray(with: v)
			}
		} else {
			accounts = []
		}

		let invitingAccounts: [Account]
		if let v: AnyObject = dic["invitingAccounts"] {
			if v is NSNull {
				invitingAccounts = []
			} else {
				invitingAccounts = try Account.parseAsArray(with: v)
			}
		} else {
			invitingAccounts = []
		}

		let invites: [TopicInvite]
		if let v: AnyObject = dic["invites"] {
			if v is NSNull {
				invites = []
			} else {
				invites = try TopicInvite.parseAsArray(with: v)
			}
		} else {
			invites = []
		}

		let accountsForApi: [Account]
		if let v: AnyObject = dic["accountsForApi"] {
			if v is NSNull {
				accountsForApi = []
			} else {
				accountsForApi = try Account.parseAsArray(with: v)
			}
		} else {
			accountsForApi = []
		}

		let integrations: [Account]
		if let v: AnyObject = dic["integrations"] {
			if v is NSNull {
				integrations = []
			} else {
				integrations = try Account.parseAsArray(with: v)
			}
		} else {
			integrations = []
		}

		let remainingInvitations: Bool?
		if let v: AnyObject = dic["remainingInvitations"] {
			if v is NSNull {
				remainingInvitations = nil
			} else {
				remainingInvitations = try Bool.parse(with: v)
			}
		} else {
			remainingInvitations = nil
		}

		return TopicWithAccounts(topic: topic, mySpace: mySpace, teams: teams, groups: groups, accounts: accounts, invitingAccounts: invitingAccounts, invites: invites, accountsForApi: accountsForApi, integrations: integrations, remainingInvitations: remainingInvitations)
	}

	public init(topic: Topic, mySpace: Space? = nil, teams: [TeamWithMembers] = [], groups: [GroupWithCount] = [], accounts: [Account] = [], invitingAccounts: [Account] = [], invites: [TopicInvite] = [], accountsForApi: [Account] = [], integrations: [Account] = [], remainingInvitations: Bool? = nil) {
		self.topic = topic
		self.mySpace = mySpace
		self.teams = teams
		self.groups = groups
		self.accounts = accounts
		self.invitingAccounts = invitingAccounts
		self.invites = invites
		self.accountsForApi = accountsForApi
		self.integrations = integrations
		self.remainingInvitations = remainingInvitations
	}
}

public struct TopicWithUserInfo: JSONDecodable {
	public let topic: Topic
	public let favorite: Bool
	public let unread: Unread?

	public static func parse(with JSONObject: Any) throws -> TopicWithUserInfo {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topic: Topic
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topic", object: JSONObject)
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topic", object: JSONObject)
		}

		let favorite: Bool
		if let v: AnyObject = dic["favorite"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "favorite", object: JSONObject)
			} else {
				favorite = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "favorite", object: JSONObject)
		}

		let unread: Unread?
		if let v: AnyObject = dic["unread"] {
			if v is NSNull {
				unread = nil
			} else {
				unread = try Unread.parse(with: v)
			}
		} else {
			unread = nil
		}

		return TopicWithUserInfo(topic: topic, favorite: favorite, unread: unread)
	}

	public init(topic: Topic, favorite: Bool, unread: Unread? = nil) {
		self.topic = topic
		self.favorite = favorite
		self.unread = unread
	}
}

public struct TopicInvite: JSONDecodable {
	public let id: Int
	public let sender: Account?
	public let account: Account?
	public let message: String
	public let createdAt: Date?
	public let updatedAt: Date?
	public let mailAddress: String?
	public let topic: Topic?

	public static func parse(with JSONObject: Any) throws -> TopicInvite {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let id: Int
		if let v: AnyObject = dic["id"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "id", object: JSONObject)
			} else {
				id = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "id", object: JSONObject)
		}

		let sender: Account?
		if let v: AnyObject = dic["sender"] {
			if v is NSNull {
				sender = nil
			} else {
				sender = try Account.parse(with: v)
			}
		} else {
			sender = nil
		}

		let account: Account?
		if let v: AnyObject = dic["account"] {
			if v is NSNull {
				account = nil
			} else {
				account = try Account.parse(with: v)
			}
		} else {
			account = nil
		}

		let message: String
		if let v: AnyObject = dic["message"] {
			if v is NSNull {
				message = ""
			} else {
				message = try String.parse(with: v)
			}
		} else {
			message = ""
		}

		let createdAt: Date?
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = nil
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = nil
		}

		let updatedAt: Date?
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = nil
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = nil
		}

		let mailAddress: String?
		if let v: AnyObject = dic["mailAddress"] {
			if v is NSNull {
				mailAddress = nil
			} else {
				mailAddress = try String.parse(with: v)
			}
		} else {
			mailAddress = nil
		}

		let topic: Topic?
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				topic = nil
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			topic = nil
		}

		return TopicInvite(id: id, sender: sender, account: account, message: message, createdAt: createdAt, updatedAt: updatedAt, mailAddress: mailAddress, topic: topic)
	}

	public init(id: Int, sender: Account? = nil, account: Account? = nil, message: String = "", createdAt: Date? = nil, updatedAt: Date? = nil, mailAddress: String? = nil, topic: Topic? = nil) {
		self.id = id
		self.sender = sender
		self.account = account
		self.message = message
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.mailAddress = mailAddress
		self.topic = topic
	}
}

public struct PaymentPlan: JSONDecodable {
	public let plan: PlanInfo
	public let enabled: Bool
	public let trial: TrialInfo?
	public let numberOfUsers: Int
	public let totalAttachmentSize: Int
	public let createdAt: Date
	public let updatedAt: Date

	public static func parse(with JSONObject: Any) throws -> PaymentPlan {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let plan: PlanInfo
		if let v: AnyObject = dic["plan"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "plan", object: JSONObject)
			} else {
				plan = try PlanInfo.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "plan", object: JSONObject)
		}

		let enabled: Bool
		if let v: AnyObject = dic["enabled"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "enabled", object: JSONObject)
			} else {
				enabled = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "enabled", object: JSONObject)
		}

		let trial: TrialInfo?
		if let v: AnyObject = dic["trial"] {
			if v is NSNull {
				trial = nil
			} else {
				trial = try TrialInfo.parse(with: v)
			}
		} else {
			trial = nil
		}

		let numberOfUsers: Int
		if let v: AnyObject = dic["numberOfUsers"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "numberOfUsers", object: JSONObject)
			} else {
				numberOfUsers = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "numberOfUsers", object: JSONObject)
		}

		let totalAttachmentSize: Int
		if let v: AnyObject = dic["totalAttachmentSize"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "totalAttachmentSize", object: JSONObject)
			} else {
				totalAttachmentSize = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "totalAttachmentSize", object: JSONObject)
		}

		let createdAt: Date
		if let v: AnyObject = dic["createdAt"] {
			if v is NSNull {
				createdAt = Date()
			} else {
				createdAt = try Date.parse(with: v)
			}
		} else {
			createdAt = Date()
		}

		let updatedAt: Date
		if let v: AnyObject = dic["updatedAt"] {
			if v is NSNull {
				updatedAt = Date()
			} else {
				updatedAt = try Date.parse(with: v)
			}
		} else {
			updatedAt = Date()
		}

		return PaymentPlan(plan: plan, enabled: enabled, trial: trial, numberOfUsers: numberOfUsers, totalAttachmentSize: totalAttachmentSize, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(plan: PlanInfo, enabled: Bool, trial: TrialInfo? = nil, numberOfUsers: Int, totalAttachmentSize: Int, createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.plan = plan
		self.enabled = enabled
		self.trial = trial
		self.numberOfUsers = numberOfUsers
		self.totalAttachmentSize = totalAttachmentSize
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct PlanInfo: JSONDecodable {
	public let key: String
	public let name: String
	public let limitNumberOfUsers: Int
	public let limitTotalAttachmentSize: Int

	public static func parse(with JSONObject: Any) throws -> PlanInfo {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let key: String
		if let v: AnyObject = dic["key"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "key", object: JSONObject)
			} else {
				key = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "key", object: JSONObject)
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "name", object: JSONObject)
			} else {
				name = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "name", object: JSONObject)
		}

		let limitNumberOfUsers: Int
		if let v: AnyObject = dic["limitNumberOfUsers"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "limitNumberOfUsers", object: JSONObject)
			} else {
				limitNumberOfUsers = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "limitNumberOfUsers", object: JSONObject)
		}

		let limitTotalAttachmentSize: Int
		if let v: AnyObject = dic["limitTotalAttachmentSize"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "limitTotalAttachmentSize", object: JSONObject)
			} else {
				limitTotalAttachmentSize = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "limitTotalAttachmentSize", object: JSONObject)
		}

		return PlanInfo(key: key, name: name, limitNumberOfUsers: limitNumberOfUsers, limitTotalAttachmentSize: limitTotalAttachmentSize)
	}

	public init(key: String, name: String, limitNumberOfUsers: Int, limitTotalAttachmentSize: Int) {
		self.key = key
		self.name = name
		self.limitNumberOfUsers = limitNumberOfUsers
		self.limitTotalAttachmentSize = limitTotalAttachmentSize
	}
}

public struct Space: JSONDecodable {
	public let space: SpaceInfo
	public let myRole: String
	public let isPaymentAdmin: Bool
	public let myPlan: PaymentPlan

	public static func parse(with JSONObject: Any) throws -> Space {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let space: SpaceInfo
		if let v: AnyObject = dic["space"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "space", object: JSONObject)
			} else {
				space = try SpaceInfo.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "space", object: JSONObject)
		}

		let myRole: String
		if let v: AnyObject = dic["myRole"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "myRole", object: JSONObject)
			} else {
				myRole = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "myRole", object: JSONObject)
		}

		let isPaymentAdmin: Bool
		if let v: AnyObject = dic["isPaymentAdmin"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "isPaymentAdmin", object: JSONObject)
			} else {
				isPaymentAdmin = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "isPaymentAdmin", object: JSONObject)
		}

		let myPlan: PaymentPlan
		if let v: AnyObject = dic["myPlan"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "myPlan", object: JSONObject)
			} else {
				myPlan = try PaymentPlan.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "myPlan", object: JSONObject)
		}

		return Space(space: space, myRole: myRole, isPaymentAdmin: isPaymentAdmin, myPlan: myPlan)
	}

	public init(space: SpaceInfo, myRole: String, isPaymentAdmin: Bool, myPlan: PaymentPlan) {
		self.space = space
		self.myRole = myRole
		self.isPaymentAdmin = isPaymentAdmin
		self.myPlan = myPlan
	}
}

public struct SpaceInfo: JSONDecodable {
	public let key: String
	public let name: String
	public let enabled: Bool
	public let imageUrl: URL

	public static func parse(with JSONObject: Any) throws -> SpaceInfo {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let key: String
		if let v: AnyObject = dic["key"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "key", object: JSONObject)
			} else {
				key = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "key", object: JSONObject)
		}

		let name: String
		if let v: AnyObject = dic["name"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "name", object: JSONObject)
			} else {
				name = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "name", object: JSONObject)
		}

		let enabled: Bool
		if let v: AnyObject = dic["enabled"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "enabled", object: JSONObject)
			} else {
				enabled = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "enabled", object: JSONObject)
		}

		let imageUrl: URL
		if let v: AnyObject = dic["imageUrl"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "imageUrl", object: JSONObject)
			} else {
				imageUrl = try URL.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "imageUrl", object: JSONObject)
		}

		return SpaceInfo(key: key, name: name, enabled: enabled, imageUrl: imageUrl)
	}

	public init(key: String, name: String, enabled: Bool, imageUrl: URL) {
		self.key = key
		self.name = name
		self.enabled = enabled
		self.imageUrl = imageUrl
	}
}

public struct TrialInfo: JSONDecodable {
	public let endDate: String
	public let daysLeft: Int

	public static func parse(with JSONObject: Any) throws -> TrialInfo {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let endDate: String
		if let v: AnyObject = dic["endDate"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "endDate", object: JSONObject)
			} else {
				endDate = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "endDate", object: JSONObject)
		}

		let daysLeft: Int
		if let v: AnyObject = dic["daysLeft"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "daysLeft", object: JSONObject)
			} else {
				daysLeft = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "daysLeft", object: JSONObject)
		}

		return TrialInfo(endDate: endDate, daysLeft: daysLeft)
	}

	public init(endDate: String, daysLeft: Int) {
		self.endDate = endDate
		self.daysLeft = daysLeft
	}
}

public struct Unread: JSONDecodable {
	public let topicId: Int
	public let postId: Int
	public let count: Int

	public static func parse(with JSONObject: Any) throws -> Unread {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topicId: Int
		if let v: AnyObject = dic["topicId"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topicId", object: JSONObject)
			} else {
				topicId = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topicId", object: JSONObject)
		}

		let postId: Int
		if let v: AnyObject = dic["postId"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "postId", object: JSONObject)
			} else {
				postId = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "postId", object: JSONObject)
		}

		let count: Int
		if let v: AnyObject = dic["count"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "count", object: JSONObject)
			} else {
				count = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "count", object: JSONObject)
		}

		return Unread(topicId: topicId, postId: postId, count: count)
	}

	public init(topicId: Int, postId: Int, count: Int) {
		self.topicId = topicId
		self.postId = postId
		self.count = count
	}
}

public struct URLAttachment: JSONDecodable {
	public let attachment: Attachment
	public let webUrl: URL
	public let apiUrl: URL
	public let thumbnails: [Thumbnail]

	public static func parse(with JSONObject: Any) throws -> URLAttachment {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let attachment: Attachment
		if let v: AnyObject = dic["attachment"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "attachment", object: JSONObject)
			} else {
				attachment = try Attachment.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "attachment", object: JSONObject)
		}

		let webUrl: URL
		if let v: AnyObject = dic["webUrl"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "webUrl", object: JSONObject)
			} else {
				webUrl = try URL.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "webUrl", object: JSONObject)
		}

		let apiUrl: URL
		if let v: AnyObject = dic["apiUrl"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "apiUrl", object: JSONObject)
			} else {
				apiUrl = try URL.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "apiUrl", object: JSONObject)
		}

		let thumbnails: [Thumbnail]
		if let v: AnyObject = dic["thumbnails"] {
			if v is NSNull {
				thumbnails = []
			} else {
				thumbnails = try Thumbnail.parseAsArray(with: v)
			}
		} else {
			thumbnails = []
		}

		return URLAttachment(attachment: attachment, webUrl: webUrl, apiUrl: apiUrl, thumbnails: thumbnails)
	}

	public init(attachment: Attachment, webUrl: URL, apiUrl: URL, thumbnails: [Thumbnail] = []) {
		self.attachment = attachment
		self.webUrl = webUrl
		self.apiUrl = apiUrl
		self.thumbnails = thumbnails
	}
}

public struct TalkPost: JSONDecodable {
	public let topic: Topic
	public let talk: Talk
	public let postIds: [Int]

	public static func parse(with JSONObject: Any) throws -> TalkPost {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topic: Topic
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topic", object: JSONObject)
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topic", object: JSONObject)
		}

		let talk: Talk
		if let v: AnyObject = dic["talk"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "talk", object: JSONObject)
			} else {
				talk = try Talk.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "talk", object: JSONObject)
		}

		let postIds: [Int]
		if let v: AnyObject = dic["postIds"] {
			if v is NSNull {
				postIds = []
			} else {
				postIds = try Int.parseAsArray(with: v)
			}
		} else {
			postIds = []
		}

		return TalkPost(topic: topic, talk: talk, postIds: postIds)
	}

	public init(topic: Topic, talk: Talk, postIds: [Int] = []) {
		self.topic = topic
		self.talk = talk
		self.postIds = postIds
	}
}

public struct PostLinksEvent: JSONDecodable {
	public let postId: Int
	public let links: [Link]

	public static func parse(with JSONObject: Any) throws -> PostLinksEvent {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let postId: Int
		if let v: AnyObject = dic["postId"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "postId", object: JSONObject)
			} else {
				postId = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "postId", object: JSONObject)
		}

		let links: [Link]
		if let v: AnyObject = dic["links"] {
			if v is NSNull {
				links = []
			} else {
				links = try Link.parseAsArray(with: v)
			}
		} else {
			links = []
		}

		return PostLinksEvent(postId: postId, links: links)
	}

	public init(postId: Int, links: [Link] = []) {
		self.postId = postId
		self.links = links
	}
}

