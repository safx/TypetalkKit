// This file was auto-generated from Model.swift with swift-idl.

import Foundation


public enum MessageDirection: String, JSONDecodable {
	case Backward = "backward"
	case Forward = "forward"

	public static func parseJSON(data: AnyObject) throws -> MessageDirection {
		if let v = data as? String, val = MessageDirection(rawValue: v) {
			return val
		}
		throw JSONDecodeError.ValueTranslationFailed(type: MessageDirection.self, object: data)
	}

	public func toJSON() -> String {
		return rawValue
	}
}

public enum AttachmentType: String, JSONDecodable {
	case Small = "small"
	case Medium = "medium"
	case Large = "large"

	public static func parseJSON(data: AnyObject) throws -> AttachmentType {
		if let v = data as? String, val = AttachmentType(rawValue: v) {
			return val
		}
		throw JSONDecodeError.ValueTranslationFailed(type: AttachmentType.self, object: data)
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

	public static func parseJSON(data: AnyObject) throws -> Scope {
		if let v = data as? String, val = Scope(rawValue: v) {
			return val
		}
		throw JSONDecodeError.ValueTranslationFailed(type: Scope.self, object: data)
	}

	public func toJSON() -> String {
		return rawValue
	}
}

public struct Account: JSONDecodable {
	public let id: AccountID
	public let name: String
	public let fullName: String
	public let suggestion: String
	public let imageUrl: NSURL
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> Account {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Account)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: AccountID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try AccountID.parseJSON(v)
			}
		} else {
			id = 0
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			name = ""
		}

		let fullName: String
		if let v: AnyObject = data["fullName"] {
			if v is NSNull {
				fullName = ""
			} else {
				fullName = try String.parseJSON(v)
			}
		} else {
			fullName = ""
		}

		let suggestion: String
		if let v: AnyObject = data["suggestion"] {
			if v is NSNull {
				suggestion = ""
			} else {
				suggestion = try String.parseJSON(v)
			}
		} else {
			suggestion = ""
		}

		let imageUrl: NSURL
		if let v: AnyObject = data["imageUrl"] {
			if v is NSNull {
				imageUrl = NSURL()
			} else {
				imageUrl = try NSURL.parseJSON(v)
			}
		} else {
			imageUrl = NSURL()
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = NSDate()
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = NSDate()
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return Account(id: id, name: name, fullName: fullName, suggestion: suggestion, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: AccountID = 0, name: String = "", fullName: String = "", suggestion: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
		self.id = id
		self.name = name
		self.fullName = fullName
		self.suggestion = suggestion
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct AccountWithOnlineStatus: JSONDecodable {
	public let account: Account
	public let online: Bool

	public static func parseJSON(data: AnyObject) throws -> AccountWithOnlineStatus {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(AccountWithOnlineStatus)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let account: Account
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "account", object: data)
			} else {
				account = try Account.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "account", object: data)
		}

		let online: Bool
		if let v: AnyObject = data["online"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "online", object: data)
			} else {
				online = try Bool.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "online", object: data)
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

	public static func parseJSON(data: AnyObject) throws -> AccountWithMailAddress {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(AccountWithMailAddress)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let account: Account
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "account", object: data)
			} else {
				account = try Account.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "account", object: data)
		}

		let mailAddress: String?
		if let v: AnyObject = data["mailAddress"] {
			if v is NSNull {
				mailAddress = nil
			} else {
				mailAddress = try String.parseJSON(v)
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

	public static func parseJSON(data: AnyObject) throws -> Attachment {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Attachment)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let contentType: String
		if let v: AnyObject = data["contentType"] {
			if v is NSNull {
				contentType = ""
			} else {
				contentType = try String.parseJSON(v)
			}
		} else {
			contentType = ""
		}

		let fileKey: String
		if let v: AnyObject = data["fileKey"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "fileKey", object: data)
			} else {
				fileKey = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "fileKey", object: data)
		}

		let fileName: String
		if let v: AnyObject = data["fileName"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "fileName", object: data)
			} else {
				fileName = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "fileName", object: data)
		}

		let fileSize: Int
		if let v: AnyObject = data["fileSize"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "fileSize", object: data)
			} else {
				fileSize = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "fileSize", object: data)
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
	public let postId: PostID
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> Bookmark {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Bookmark)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let postId: PostID
		if let v: AnyObject = data["postId"] {
			if v is NSNull {
				postId = 0
			} else {
				postId = try PostID.parseJSON(v)
			}
		} else {
			postId = 0
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return Bookmark(postId: postId, updatedAt: updatedAt)
	}

	public init(postId: PostID = 0, updatedAt: NSDate = NSDate()) {
		self.postId = postId
		self.updatedAt = updatedAt
	}
}

public struct Embed: JSONDecodable {
	public let type: String
	public let version: Int
	public let providerName: String // json:"provider_name"
	public let providerURL: NSURL? // json:"provider_url"
	public let title: String
	public let authorName: String // json:"author_name"
	public let authorURL: NSURL? // json:"author_url"
	public let html: String
	public let width: Int
	public let height: Int

	public static func parseJSON(data: AnyObject) throws -> Embed {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Embed)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let type: String
		if let v: AnyObject = data["type"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "type", object: data)
			} else {
				type = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "type", object: data)
		}

		let version: Int
		if let v: AnyObject = data["version"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "version", object: data)
			} else {
				version = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "version", object: data)
		}

		let providerName: String
		if let v: AnyObject = data["provider_name"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "provider_name", object: data)
			} else {
				providerName = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "provider_name", object: data)
		}

		let providerURL: NSURL?
		if let v: AnyObject = data["provider_url"] {
			if v is NSNull {
				providerURL = nil
			} else {
				providerURL = try NSURL.parseJSON(v)
			}
		} else {
			providerURL = nil
		}

		let title: String
		if let v: AnyObject = data["title"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "title", object: data)
			} else {
				title = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "title", object: data)
		}

		let authorName: String
		if let v: AnyObject = data["author_name"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "author_name", object: data)
			} else {
				authorName = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "author_name", object: data)
		}

		let authorURL: NSURL?
		if let v: AnyObject = data["author_url"] {
			if v is NSNull {
				authorURL = nil
			} else {
				authorURL = try NSURL.parseJSON(v)
			}
		} else {
			authorURL = nil
		}

		let html: String
		if let v: AnyObject = data["html"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "html", object: data)
			} else {
				html = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "html", object: data)
		}

		let width: Int
		if let v: AnyObject = data["width"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "width", object: data)
			} else {
				width = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "width", object: data)
		}

		let height: Int
		if let v: AnyObject = data["height"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "height", object: data)
			} else {
				height = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "height", object: data)
		}

		return Embed(type: type, version: version, providerName: providerName, providerURL: providerURL, title: title, authorName: authorName, authorURL: authorURL, html: html, width: width, height: height)
	}

	public init(type: String, version: Int, providerName: String, providerURL: NSURL? = nil, title: String, authorName: String, authorURL: NSURL? = nil, html: String, width: Int, height: Int) {
		self.type = type
		self.version = version
		self.providerName = providerName
		self.providerURL = providerURL
		self.title = title
		self.authorName = authorName
		self.authorURL = authorURL
		self.html = html
		self.width = width
		self.height = height
	}
}

public struct Invite: JSONDecodable {
	public let id: InviteID
	public let sender: Account?
	public let account: Account?
	public let message: String
	public let createdAt: NSDate?
	public let updatedAt: NSDate?
	public let mailAddress: String?
	public let status: String
	public let topic: Topic?
	public let team: Team?
	public let role: String?

	public static func parseJSON(data: AnyObject) throws -> Invite {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Invite)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: InviteID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "id", object: data)
			} else {
				id = try InviteID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "id", object: data)
		}

		let sender: Account?
		if let v: AnyObject = data["sender"] {
			if v is NSNull {
				sender = nil
			} else {
				sender = try Account.parseJSON(v)
			}
		} else {
			sender = nil
		}

		let account: Account?
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				account = nil
			} else {
				account = try Account.parseJSON(v)
			}
		} else {
			account = nil
		}

		let message: String
		if let v: AnyObject = data["message"] {
			if v is NSNull {
				message = ""
			} else {
				message = try String.parseJSON(v)
			}
		} else {
			message = ""
		}

		let createdAt: NSDate?
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = nil
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = nil
		}

		let updatedAt: NSDate?
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = nil
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = nil
		}

		let mailAddress: String?
		if let v: AnyObject = data["mailAddress"] {
			if v is NSNull {
				mailAddress = nil
			} else {
				mailAddress = try String.parseJSON(v)
			}
		} else {
			mailAddress = nil
		}

		let status: String
		if let v: AnyObject = data["status"] {
			if v is NSNull {
				status = ""
			} else {
				status = try String.parseJSON(v)
			}
		} else {
			status = ""
		}

		let topic: Topic?
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				topic = nil
			} else {
				topic = try Topic.parseJSON(v)
			}
		} else {
			topic = nil
		}

		let team: Team?
		if let v: AnyObject = data["team"] {
			if v is NSNull {
				team = nil
			} else {
				team = try Team.parseJSON(v)
			}
		} else {
			team = nil
		}

		let role: String?
		if let v: AnyObject = data["role"] {
			if v is NSNull {
				role = nil
			} else {
				role = try String.parseJSON(v)
			}
		} else {
			role = nil
		}

		return Invite(id: id, sender: sender, account: account, message: message, createdAt: createdAt, updatedAt: updatedAt, mailAddress: mailAddress, status: status, topic: topic, team: team, role: role)
	}

	public init(id: InviteID, sender: Account? = nil, account: Account? = nil, message: String = "", createdAt: NSDate? = nil, updatedAt: NSDate? = nil, mailAddress: String? = nil, status: String = "", topic: Topic? = nil, team: Team? = nil, role: String? = nil) {
		self.id = id
		self.sender = sender
		self.account = account
		self.message = message
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.mailAddress = mailAddress
		self.status = status
		self.topic = topic
		self.team = team
		self.role = role
	}
}

public struct Like: JSONDecodable {
	public let id: LikeID
	public let postId: PostID
	public let topicId: TopicID
	public let comment: String?
	public let account: Account?

	public static func parseJSON(data: AnyObject) throws -> Like {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Like)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: LikeID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "id", object: data)
			} else {
				id = try LikeID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "id", object: data)
		}

		let postId: PostID
		if let v: AnyObject = data["postId"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "postId", object: data)
			} else {
				postId = try PostID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "postId", object: data)
		}

		let topicId: TopicID
		if let v: AnyObject = data["topicId"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topicId", object: data)
			} else {
				topicId = try TopicID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topicId", object: data)
		}

		let comment: String?
		if let v: AnyObject = data["comment"] {
			if v is NSNull {
				comment = nil
			} else {
				comment = try String.parseJSON(v)
			}
		} else {
			comment = nil
		}

		let account: Account?
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				account = nil
			} else {
				account = try Account.parseJSON(v)
			}
		} else {
			account = nil
		}

		return Like(id: id, postId: postId, topicId: topicId, comment: comment, account: account)
	}

	public init(id: LikeID, postId: PostID, topicId: TopicID, comment: String? = nil, account: Account? = nil) {
		self.id = id
		self.postId = postId
		self.topicId = topicId
		self.comment = comment
		self.account = account
	}
}

public struct Link: JSONDecodable {
	public let id: LinkID
	public let url: NSURL
	public let contentType: String
	public let title: String
	public let description: String
	public let imageUrl: NSURL
	public let createdAt: NSDate
	public let updatedAt: NSDate
	public let embed: Embed?

	public static func parseJSON(data: AnyObject) throws -> Link {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Link)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: LinkID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "id", object: data)
			} else {
				id = try LinkID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "id", object: data)
		}

		let url: NSURL
		if let v: AnyObject = data["url"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "url", object: data)
			} else {
				url = try NSURL.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "url", object: data)
		}

		let contentType: String
		if let v: AnyObject = data["contentType"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "contentType", object: data)
			} else {
				contentType = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "contentType", object: data)
		}

		let title: String
		if let v: AnyObject = data["title"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "title", object: data)
			} else {
				title = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "title", object: data)
		}

		let description: String
		if let v: AnyObject = data["description"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "description", object: data)
			} else {
				description = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "description", object: data)
		}

		let imageUrl: NSURL
		if let v: AnyObject = data["imageUrl"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "imageUrl", object: data)
			} else {
				imageUrl = try NSURL.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "imageUrl", object: data)
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "createdAt", object: data)
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "createdAt", object: data)
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "updatedAt", object: data)
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "updatedAt", object: data)
		}

		let embed: Embed?
		if let v: AnyObject = data["embed"] {
			if v is NSNull {
				embed = nil
			} else {
				embed = try Embed.parseJSON(v)
			}
		} else {
			embed = nil
		}

		return Link(id: id, url: url, contentType: contentType, title: title, description: description, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt, embed: embed)
	}

	public init(id: LinkID, url: NSURL, contentType: String, title: String, description: String, imageUrl: NSURL, createdAt: NSDate, updatedAt: NSDate, embed: Embed? = nil) {
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

public struct Member: JSONDecodable {
	public let account: Account
	public let role: String

	public static func parseJSON(data: AnyObject) throws -> Member {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Member)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let account: Account
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "account", object: data)
			} else {
				account = try Account.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "account", object: data)
		}

		let role: String
		if let v: AnyObject = data["role"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "role", object: data)
			} else {
				role = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "role", object: data)
		}

		return Member(account: account, role: role)
	}

	public init(account: Account, role: String) {
		self.account = account
		self.role = role
	}
}

public struct Mention: JSONDecodable {
	public let id: MentionID
	public let readAt: NSDate?
	public let post: Post

	public static func parseJSON(data: AnyObject) throws -> Mention {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Mention)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: MentionID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try MentionID.parseJSON(v)
			}
		} else {
			id = 0
		}

		let readAt: NSDate?
		if let v: AnyObject = data["readAt"] {
			if v is NSNull {
				readAt = nil
			} else {
				readAt = try NSDate.parseJSON(v)
			}
		} else {
			readAt = nil
		}

		let post: Post
		if let v: AnyObject = data["post"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "post", object: data)
			} else {
				post = try Post.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "post", object: data)
		}

		return Mention(id: id, readAt: readAt, post: post)
	}

	public init(id: MentionID = 0, readAt: NSDate? = nil, post: Post) {
		self.id = id
		self.readAt = readAt
		self.post = post
	}
}

public struct Notifications: JSONDecodable {
	public let mentions: [Mention]
	public let invites: Notifications.Invites

	public static func parseJSON(data: AnyObject) throws -> Notifications {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Notifications)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let mentions: [Mention]
		if let v: AnyObject = data["mentions"] {
			if v is NSNull {
				mentions = []
			} else {
				mentions = try Mention.parseJSONArray(v)
			}
		} else {
			mentions = []
		}

		let invites: Notifications.Invites
		if let v: AnyObject = data["invites"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "invites", object: data)
			} else {
				invites = try Notifications.Invites.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "invites", object: data)
		}

		return Notifications(mentions: mentions, invites: invites)
	}

	public init(mentions: [Mention] = [], invites: Notifications.Invites) {
		self.mentions = mentions
		self.invites = invites
	}

	public struct Invites: JSONDecodable {
		public let teams: [Invite]
		public let topics: [Invite]

		public static func parseJSON(data: AnyObject) throws -> Invites {
			if !(data is NSDictionary) {
				throw JSONDecodeError.TypeMismatch(key: "(Invites)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
			}

			let teams: [Invite]
			if let v: AnyObject = data["teams"] {
				if v is NSNull {
					teams = []
				} else {
					teams = try Invite.parseJSONArray(v)
				}
			} else {
				teams = []
			}

			let topics: [Invite]
			if let v: AnyObject = data["topics"] {
				if v is NSNull {
					topics = []
				} else {
					topics = try Invite.parseJSONArray(v)
				}
			} else {
				topics = []
			}

			return Invites(teams: teams, topics: topics)
		}

		public init(teams: [Invite] = [], topics: [Invite] = []) {
			self.teams = teams
			self.topics = topics
		}
	}
}

public struct NotificationStatus: JSONDecodable {
	public let mention: NotificationStatus.Mention?
	public let access: NotificationStatus.Access?
	public let invite: NotificationStatus.Invite?

	public static func parseJSON(data: AnyObject) throws -> NotificationStatus {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(NotificationStatus)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let mention: NotificationStatus.Mention?
		if let v: AnyObject = data["mention"] {
			if v is NSNull {
				mention = nil
			} else {
				mention = try NotificationStatus.Mention.parseJSON(v)
			}
		} else {
			mention = nil
		}

		let access: NotificationStatus.Access?
		if let v: AnyObject = data["access"] {
			if v is NSNull {
				access = nil
			} else {
				access = try NotificationStatus.Access.parseJSON(v)
			}
		} else {
			access = nil
		}

		let invite: NotificationStatus.Invite?
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				invite = nil
			} else {
				invite = try NotificationStatus.Invite.parseJSON(v)
			}
		} else {
			invite = nil
		}

		return NotificationStatus(mention: mention, access: access, invite: invite)
	}

	public init(mention: NotificationStatus.Mention? = nil, access: NotificationStatus.Access? = nil, invite: NotificationStatus.Invite? = nil) {
		self.mention = mention
		self.access = access
		self.invite = invite
	}

	public struct Mention: JSONDecodable {
		public let unread: Int?

		public static func parseJSON(data: AnyObject) throws -> Mention {
			if !(data is NSDictionary) {
				throw JSONDecodeError.TypeMismatch(key: "(Mention)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
			}

			let unread: Int?
			if let v: AnyObject = data["unread"] {
				if v is NSNull {
					unread = nil
				} else {
					unread = try Int.parseJSON(v)
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

		public static func parseJSON(data: AnyObject) throws -> Access {
			if !(data is NSDictionary) {
				throw JSONDecodeError.TypeMismatch(key: "(Access)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
			}

			let unopened: Int?
			if let v: AnyObject = data["unopened"] {
				if v is NSNull {
					unopened = nil
				} else {
					unopened = try Int.parseJSON(v)
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

		public static func parseJSON(data: AnyObject) throws -> Invite {
			if !(data is NSDictionary) {
				throw JSONDecodeError.TypeMismatch(key: "(Invite)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
			}

			let team: NotificationStatus.Invite.PendingCount?
			if let v: AnyObject = data["team"] {
				if v is NSNull {
					team = nil
				} else {
					team = try NotificationStatus.Invite.PendingCount.parseJSON(v)
				}
			} else {
				team = nil
			}

			let topic: NotificationStatus.Invite.PendingCount?
			if let v: AnyObject = data["topic"] {
				if v is NSNull {
					topic = nil
				} else {
					topic = try NotificationStatus.Invite.PendingCount.parseJSON(v)
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

			public static func parseJSON(data: AnyObject) throws -> PendingCount {
				if !(data is NSDictionary) {
					throw JSONDecodeError.TypeMismatch(key: "(PendingCount)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
				}

				let pending: Int?
				if let v: AnyObject = data["pending"] {
					if v is NSNull {
						pending = nil
					} else {
						pending = try Int.parseJSON(v)
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
}

public class Post: JSONDecodable {
	public let id: PostID
	public let topicId: TopicID
	public let topic: Topic?
	public let replyTo: Int?
	public let message: String
	public let account: Account
	public let mention: Mention?
	public let attachments: [URLAttachment]
	public let likes: [Like]
	public let talks: [Talk]
	public let links: [Link]
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public class func parseJSON(data: AnyObject) throws -> Post {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Post)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: PostID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try PostID.parseJSON(v)
			}
		} else {
			id = 0
		}

		let topicId: TopicID
		if let v: AnyObject = data["topicId"] {
			if v is NSNull {
				topicId = 0
			} else {
				topicId = try TopicID.parseJSON(v)
			}
		} else {
			topicId = 0
		}

		let topic: Topic?
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				topic = nil
			} else {
				topic = try Topic.parseJSON(v)
			}
		} else {
			topic = nil
		}

		let replyTo: Int?
		if let v: AnyObject = data["replyTo"] {
			if v is NSNull {
				replyTo = nil
			} else {
				replyTo = try Int.parseJSON(v)
			}
		} else {
			replyTo = nil
		}

		let message: String
		if let v: AnyObject = data["message"] {
			if v is NSNull {
				message = ""
			} else {
				message = try String.parseJSON(v)
			}
		} else {
			message = ""
		}

		let account: Account
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				account = Account()
			} else {
				account = try Account.parseJSON(v)
			}
		} else {
			account = Account()
		}

		let mention: Mention?
		if let v: AnyObject = data["mention"] {
			if v is NSNull {
				mention = nil
			} else {
				mention = try Mention.parseJSON(v)
			}
		} else {
			mention = nil
		}

		let attachments: [URLAttachment]
		if let v: AnyObject = data["attachments"] {
			if v is NSNull {
				attachments = []
			} else {
				attachments = try URLAttachment.parseJSONArray(v)
			}
		} else {
			attachments = []
		}

		let likes: [Like]
		if let v: AnyObject = data["likes"] {
			if v is NSNull {
				likes = []
			} else {
				likes = try Like.parseJSONArray(v)
			}
		} else {
			likes = []
		}

		let talks: [Talk]
		if let v: AnyObject = data["talks"] {
			if v is NSNull {
				talks = []
			} else {
				talks = try Talk.parseJSONArray(v)
			}
		} else {
			talks = []
		}

		let links: [Link]
		if let v: AnyObject = data["links"] {
			if v is NSNull {
				links = []
			} else {
				links = try Link.parseJSONArray(v)
			}
		} else {
			links = []
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = NSDate()
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = NSDate()
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return Post(id: id, topicId: topicId, topic: topic, replyTo: replyTo, message: message, account: account, mention: mention, attachments: attachments, likes: likes, talks: talks, links: links, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: PostID = 0, topicId: TopicID = 0, topic: Topic? = nil, replyTo: Int? = nil, message: String = "", account: Account = Account(), mention: Mention? = nil, attachments: [URLAttachment] = [], likes: [Like] = [], talks: [Talk] = [], links: [Link] = [], createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
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
	public let id: TalkID
	public let topicId: TopicID
	public let name: String
	public let suggestion: String
	public let createdAt: NSDate
	public let updatedAt: NSDate
	public let backlog: String?

	public static func parseJSON(data: AnyObject) throws -> Talk {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Talk)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: TalkID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "id", object: data)
			} else {
				id = try TalkID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "id", object: data)
		}

		let topicId: TopicID
		if let v: AnyObject = data["topicId"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topicId", object: data)
			} else {
				topicId = try TopicID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topicId", object: data)
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "name", object: data)
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "name", object: data)
		}

		let suggestion: String
		if let v: AnyObject = data["suggestion"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "suggestion", object: data)
			} else {
				suggestion = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "suggestion", object: data)
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "createdAt", object: data)
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "createdAt", object: data)
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "updatedAt", object: data)
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "updatedAt", object: data)
		}

		let backlog: String?
		if let v: AnyObject = data["backlog"] {
			if v is NSNull {
				backlog = nil
			} else {
				backlog = try String.parseJSON(v)
			}
		} else {
			backlog = nil
		}

		return Talk(id: id, topicId: topicId, name: name, suggestion: suggestion, createdAt: createdAt, updatedAt: updatedAt, backlog: backlog)
	}

	public init(id: TalkID, topicId: TopicID, name: String, suggestion: String, createdAt: NSDate, updatedAt: NSDate, backlog: String? = nil) {
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
	public let id: TeamID
	public let name: String
	public let imageUrl: NSURL
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> Team {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Team)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: TeamID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try TeamID.parseJSON(v)
			}
		} else {
			id = 0
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			name = ""
		}

		let imageUrl: NSURL
		if let v: AnyObject = data["imageUrl"] {
			if v is NSNull {
				imageUrl = NSURL()
			} else {
				imageUrl = try NSURL.parseJSON(v)
			}
		} else {
			imageUrl = NSURL()
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = NSDate()
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = NSDate()
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return Team(id: id, name: name, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: TeamID = 0, name: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
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

	public static func parseJSON(data: AnyObject) throws -> TeamWithMembers {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TeamWithMembers)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let team: Team
		if let v: AnyObject = data["team"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "team", object: data)
			} else {
				team = try Team.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "team", object: data)
		}

		let members: [Member]
		if let v: AnyObject = data["members"] {
			if v is NSNull {
				members = []
			} else {
				members = try Member.parseJSONArray(v)
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

	public static func parseJSON(data: AnyObject) throws -> TeamWithCount {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TeamWithCount)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let team: Team
		if let v: AnyObject = data["team"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "team", object: data)
			} else {
				team = try Team.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "team", object: data)
		}

		let memberCount: Int
		if let v: AnyObject = data["memberCount"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "memberCount", object: data)
			} else {
				memberCount = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "memberCount", object: data)
		}

		return TeamWithCount(team: team, memberCount: memberCount)
	}

	public init(team: Team, memberCount: Int) {
		self.team = team
		self.memberCount = memberCount
	}
}

public struct Thumbnail: JSONDecodable {
	public let type: AttachmentType
	public let fileSize: Int
	public let width: Int
	public let height: Int

	public static func parseJSON(data: AnyObject) throws -> Thumbnail {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Thumbnail)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let type: AttachmentType
		if let v: AnyObject = data["type"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "type", object: data)
			} else {
				type = try AttachmentType.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "type", object: data)
		}

		let fileSize: Int
		if let v: AnyObject = data["fileSize"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "fileSize", object: data)
			} else {
				fileSize = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "fileSize", object: data)
		}

		let width: Int
		if let v: AnyObject = data["width"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "width", object: data)
			} else {
				width = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "width", object: data)
		}

		let height: Int
		if let v: AnyObject = data["height"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "height", object: data)
			} else {
				height = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "height", object: data)
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
	public let id: TopicID
	public let name: String
	public let suggestion: String
	public let lastPostedAt: NSDate?
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> Topic {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Topic)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: TopicID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				id = 0
			} else {
				id = try TopicID.parseJSON(v)
			}
		} else {
			id = 0
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			name = ""
		}

		let suggestion: String
		if let v: AnyObject = data["suggestion"] {
			if v is NSNull {
				suggestion = ""
			} else {
				suggestion = try String.parseJSON(v)
			}
		} else {
			suggestion = ""
		}

		let lastPostedAt: NSDate?
		if let v: AnyObject = data["lastPostedAt"] {
			if v is NSNull {
				lastPostedAt = nil
			} else {
				lastPostedAt = try NSDate.parseJSON(v)
			}
		} else {
			lastPostedAt = nil
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = NSDate()
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = NSDate()
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return Topic(id: id, name: name, suggestion: suggestion, lastPostedAt: lastPostedAt, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: TopicID = 0, name: String = "", suggestion: String = "", lastPostedAt: NSDate? = nil, createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
		self.id = id
		self.name = name
		self.suggestion = suggestion
		self.lastPostedAt = lastPostedAt
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct TopicWithAccounts: JSONDecodable {
	public let topic: Topic
	public let mySpace: Space
	public let teams: [TeamWithMembers]
	public let groups: [GroupWithCount]
	public let accounts: [Account]
	public let invitingAccounts: [Account]
	public let invites: [Invite]
	public let accountsForApi: [Account]
	public let integrations: [Account]
	public let remainingInvitations: Bool?

	public static func parseJSON(data: AnyObject) throws -> TopicWithAccounts {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TopicWithAccounts)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topic", object: data)
			} else {
				topic = try Topic.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topic", object: data)
		}

		let mySpace: Space
		if let v: AnyObject = data["mySpace"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "mySpace", object: data)
			} else {
				mySpace = try Space.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "mySpace", object: data)
		}

		let teams: [TeamWithMembers]
		if let v: AnyObject = data["teams"] {
			if v is NSNull {
				teams = []
			} else {
				teams = try TeamWithMembers.parseJSONArray(v)
			}
		} else {
			teams = []
		}

		let groups: [GroupWithCount]
		if let v: AnyObject = data["groups"] {
			if v is NSNull {
				groups = []
			} else {
				groups = try GroupWithCount.parseJSONArray(v)
			}
		} else {
			groups = []
		}

		let accounts: [Account]
		if let v: AnyObject = data["accounts"] {
			if v is NSNull {
				accounts = []
			} else {
				accounts = try Account.parseJSONArray(v)
			}
		} else {
			accounts = []
		}

		let invitingAccounts: [Account]
		if let v: AnyObject = data["invitingAccounts"] {
			if v is NSNull {
				invitingAccounts = []
			} else {
				invitingAccounts = try Account.parseJSONArray(v)
			}
		} else {
			invitingAccounts = []
		}

		let invites: [Invite]
		if let v: AnyObject = data["invites"] {
			if v is NSNull {
				invites = []
			} else {
				invites = try Invite.parseJSONArray(v)
			}
		} else {
			invites = []
		}

		let accountsForApi: [Account]
		if let v: AnyObject = data["accountsForApi"] {
			if v is NSNull {
				accountsForApi = []
			} else {
				accountsForApi = try Account.parseJSONArray(v)
			}
		} else {
			accountsForApi = []
		}

		let integrations: [Account]
		if let v: AnyObject = data["integrations"] {
			if v is NSNull {
				integrations = []
			} else {
				integrations = try Account.parseJSONArray(v)
			}
		} else {
			integrations = []
		}

		let remainingInvitations: Bool?
		if let v: AnyObject = data["remainingInvitations"] {
			if v is NSNull {
				remainingInvitations = nil
			} else {
				remainingInvitations = try Bool.parseJSON(v)
			}
		} else {
			remainingInvitations = nil
		}

		return TopicWithAccounts(topic: topic, mySpace: mySpace, teams: teams, groups: groups, accounts: accounts, invitingAccounts: invitingAccounts, invites: invites, accountsForApi: accountsForApi, integrations: integrations, remainingInvitations: remainingInvitations)
	}

	public init(topic: Topic, mySpace: Space, teams: [TeamWithMembers] = [], groups: [GroupWithCount] = [], accounts: [Account] = [], invitingAccounts: [Account] = [], invites: [Invite] = [], accountsForApi: [Account] = [], integrations: [Account] = [], remainingInvitations: Bool? = nil) {
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

	public static func parseJSON(data: AnyObject) throws -> TopicWithUserInfo {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TopicWithUserInfo)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topic", object: data)
			} else {
				topic = try Topic.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topic", object: data)
		}

		let favorite: Bool
		if let v: AnyObject = data["favorite"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "favorite", object: data)
			} else {
				favorite = try Bool.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "favorite", object: data)
		}

		let unread: Unread?
		if let v: AnyObject = data["unread"] {
			if v is NSNull {
				unread = nil
			} else {
				unread = try Unread.parseJSON(v)
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

public struct Unread: JSONDecodable {
	public let topicId: TopicID
	public let postId: PostID
	public let count: Int

	public static func parseJSON(data: AnyObject) throws -> Unread {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Unread)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let topicId: TopicID
		if let v: AnyObject = data["topicId"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topicId", object: data)
			} else {
				topicId = try TopicID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topicId", object: data)
		}

		let postId: PostID
		if let v: AnyObject = data["postId"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "postId", object: data)
			} else {
				postId = try PostID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "postId", object: data)
		}

		let count: Int
		if let v: AnyObject = data["count"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "count", object: data)
			} else {
				count = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "count", object: data)
		}

		return Unread(topicId: topicId, postId: postId, count: count)
	}

	public init(topicId: TopicID, postId: PostID, count: Int) {
		self.topicId = topicId
		self.postId = postId
		self.count = count
	}
}

public struct URLAttachment: JSONDecodable {
	public let attachment: Attachment
	public let webUrl: NSURL
	public let apiUrl: NSURL
	public let thumbnails: [Thumbnail]

	public static func parseJSON(data: AnyObject) throws -> URLAttachment {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(URLAttachment)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let attachment: Attachment
		if let v: AnyObject = data["attachment"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "attachment", object: data)
			} else {
				attachment = try Attachment.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "attachment", object: data)
		}

		let webUrl: NSURL
		if let v: AnyObject = data["webUrl"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "webUrl", object: data)
			} else {
				webUrl = try NSURL.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "webUrl", object: data)
		}

		let apiUrl: NSURL
		if let v: AnyObject = data["apiUrl"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "apiUrl", object: data)
			} else {
				apiUrl = try NSURL.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "apiUrl", object: data)
		}

		let thumbnails: [Thumbnail]
		if let v: AnyObject = data["thumbnails"] {
			if v is NSNull {
				thumbnails = []
			} else {
				thumbnails = try Thumbnail.parseJSONArray(v)
			}
		} else {
			thumbnails = []
		}

		return URLAttachment(attachment: attachment, webUrl: webUrl, apiUrl: apiUrl, thumbnails: thumbnails)
	}

	public init(attachment: Attachment, webUrl: NSURL, apiUrl: NSURL, thumbnails: [Thumbnail] = []) {
		self.attachment = attachment
		self.webUrl = webUrl
		self.apiUrl = apiUrl
		self.thumbnails = thumbnails
	}
}

public struct SpaceBasicInfo: JSONDecodable {
	public let key: String
	public let name: String
	public let enabled: Bool
	public let imageUrl: NSURL

	public static func parseJSON(data: AnyObject) throws -> SpaceBasicInfo {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(SpaceBasicInfo)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let key: String
		if let v: AnyObject = data["key"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "key", object: data)
			} else {
				key = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "key", object: data)
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "name", object: data)
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "name", object: data)
		}

		let enabled: Bool
		if let v: AnyObject = data["enabled"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "enabled", object: data)
			} else {
				enabled = try Bool.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "enabled", object: data)
		}

		let imageUrl: NSURL
		if let v: AnyObject = data["imageUrl"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "imageUrl", object: data)
			} else {
				imageUrl = try NSURL.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "imageUrl", object: data)
		}

		return SpaceBasicInfo(key: key, name: name, enabled: enabled, imageUrl: imageUrl)
	}

	public init(key: String, name: String, enabled: Bool, imageUrl: NSURL) {
		self.key = key
		self.name = name
		self.enabled = enabled
		self.imageUrl = imageUrl
	}
}

public struct Space: JSONDecodable {
	public let space: SpaceBasicInfo
	public let myRole: String
	public let isPaymentAdmin: Bool
	public let myPlan: PaymentPlan

	public static func parseJSON(data: AnyObject) throws -> Space {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Space)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let space: SpaceBasicInfo
		if let v: AnyObject = data["space"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "space", object: data)
			} else {
				space = try SpaceBasicInfo.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "space", object: data)
		}

		let myRole: String
		if let v: AnyObject = data["myRole"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "myRole", object: data)
			} else {
				myRole = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "myRole", object: data)
		}

		let isPaymentAdmin: Bool
		if let v: AnyObject = data["isPaymentAdmin"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "isPaymentAdmin", object: data)
			} else {
				isPaymentAdmin = try Bool.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "isPaymentAdmin", object: data)
		}

		let myPlan: PaymentPlan
		if let v: AnyObject = data["myPlan"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "myPlan", object: data)
			} else {
				myPlan = try PaymentPlan.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "myPlan", object: data)
		}

		return Space(space: space, myRole: myRole, isPaymentAdmin: isPaymentAdmin, myPlan: myPlan)
	}

	public init(space: SpaceBasicInfo, myRole: String, isPaymentAdmin: Bool, myPlan: PaymentPlan) {
		self.space = space
		self.myRole = myRole
		self.isPaymentAdmin = isPaymentAdmin
		self.myPlan = myPlan
	}
}

public struct Group: JSONDecodable {
	public let id: GroupID
	public let key: String
	public let name: String
	public let suggestion: String
	public let imageUrl: NSURL
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> Group {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(Group)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let id: GroupID
		if let v: AnyObject = data["id"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "id", object: data)
			} else {
				id = try GroupID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "id", object: data)
		}

		let key: String
		if let v: AnyObject = data["key"] {
			if v is NSNull {
				key = ""
			} else {
				key = try String.parseJSON(v)
			}
		} else {
			key = ""
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				name = ""
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			name = ""
		}

		let suggestion: String
		if let v: AnyObject = data["suggestion"] {
			if v is NSNull {
				suggestion = ""
			} else {
				suggestion = try String.parseJSON(v)
			}
		} else {
			suggestion = ""
		}

		let imageUrl: NSURL
		if let v: AnyObject = data["imageUrl"] {
			if v is NSNull {
				imageUrl = NSURL()
			} else {
				imageUrl = try NSURL.parseJSON(v)
			}
		} else {
			imageUrl = NSURL()
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = NSDate()
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = NSDate()
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return Group(id: id, key: key, name: name, suggestion: suggestion, imageUrl: imageUrl, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: GroupID, key: String = "", name: String = "", suggestion: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
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

	public static func parseJSON(data: AnyObject) throws -> GroupWithCount {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GroupWithCount)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let group: Group
		if let v: AnyObject = data["group"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "group", object: data)
			} else {
				group = try Group.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "group", object: data)
		}

		let memberCount: Int
		if let v: AnyObject = data["memberCount"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "memberCount", object: data)
			} else {
				memberCount = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "memberCount", object: data)
		}

		return GroupWithCount(group: group, memberCount: memberCount)
	}

	public init(group: Group, memberCount: Int) {
		self.group = group
		self.memberCount = memberCount
	}
}

public struct PaymentPlan: JSONDecodable {
	public let plan: PlanInformation
	public let enabled: Bool
	public let trial: TrialInfo?
	public let numberOfUsers: Int
	public let totalAttachmentSize: Int
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> PaymentPlan {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(PaymentPlan)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let plan: PlanInformation
		if let v: AnyObject = data["plan"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "plan", object: data)
			} else {
				plan = try PlanInformation.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "plan", object: data)
		}

		let enabled: Bool
		if let v: AnyObject = data["enabled"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "enabled", object: data)
			} else {
				enabled = try Bool.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "enabled", object: data)
		}

		let trial: TrialInfo?
		if let v: AnyObject = data["trial"] {
			if v is NSNull {
				trial = nil
			} else {
				trial = try TrialInfo.parseJSON(v)
			}
		} else {
			trial = nil
		}

		let numberOfUsers: Int
		if let v: AnyObject = data["numberOfUsers"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "numberOfUsers", object: data)
			} else {
				numberOfUsers = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "numberOfUsers", object: data)
		}

		let totalAttachmentSize: Int
		if let v: AnyObject = data["totalAttachmentSize"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "totalAttachmentSize", object: data)
			} else {
				totalAttachmentSize = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "totalAttachmentSize", object: data)
		}

		let createdAt: NSDate
		if let v: AnyObject = data["createdAt"] {
			if v is NSNull {
				createdAt = NSDate()
			} else {
				createdAt = try NSDate.parseJSON(v)
			}
		} else {
			createdAt = NSDate()
		}

		let updatedAt: NSDate
		if let v: AnyObject = data["updatedAt"] {
			if v is NSNull {
				updatedAt = NSDate()
			} else {
				updatedAt = try NSDate.parseJSON(v)
			}
		} else {
			updatedAt = NSDate()
		}

		return PaymentPlan(plan: plan, enabled: enabled, trial: trial, numberOfUsers: numberOfUsers, totalAttachmentSize: totalAttachmentSize, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(plan: PlanInformation, enabled: Bool, trial: TrialInfo? = nil, numberOfUsers: Int, totalAttachmentSize: Int, createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
		self.plan = plan
		self.enabled = enabled
		self.trial = trial
		self.numberOfUsers = numberOfUsers
		self.totalAttachmentSize = totalAttachmentSize
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct TrialInfo: JSONDecodable {
	public let endDate: String
	public let daysLeft: Int

	public static func parseJSON(data: AnyObject) throws -> TrialInfo {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TrialInfo)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let endDate: String
		if let v: AnyObject = data["endDate"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "endDate", object: data)
			} else {
				endDate = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "endDate", object: data)
		}

		let daysLeft: Int
		if let v: AnyObject = data["daysLeft"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "daysLeft", object: data)
			} else {
				daysLeft = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "daysLeft", object: data)
		}

		return TrialInfo(endDate: endDate, daysLeft: daysLeft)
	}

	public init(endDate: String, daysLeft: Int) {
		self.endDate = endDate
		self.daysLeft = daysLeft
	}
}

public struct PlanInformation: JSONDecodable {
	public let key: String
	public let name: String
	public let limitNumberOfUsers: Int
	public let limitTotalAttachmentSize: Int

	public static func parseJSON(data: AnyObject) throws -> PlanInformation {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(PlanInformation)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let key: String
		if let v: AnyObject = data["key"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "key", object: data)
			} else {
				key = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "key", object: data)
		}

		let name: String
		if let v: AnyObject = data["name"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "name", object: data)
			} else {
				name = try String.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "name", object: data)
		}

		let limitNumberOfUsers: Int
		if let v: AnyObject = data["limitNumberOfUsers"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "limitNumberOfUsers", object: data)
			} else {
				limitNumberOfUsers = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "limitNumberOfUsers", object: data)
		}

		let limitTotalAttachmentSize: Int
		if let v: AnyObject = data["limitTotalAttachmentSize"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "limitTotalAttachmentSize", object: data)
			} else {
				limitTotalAttachmentSize = try Int.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "limitTotalAttachmentSize", object: data)
		}

		return PlanInformation(key: key, name: name, limitNumberOfUsers: limitNumberOfUsers, limitTotalAttachmentSize: limitTotalAttachmentSize)
	}

	public init(key: String, name: String, limitNumberOfUsers: Int, limitTotalAttachmentSize: Int) {
		self.key = key
		self.name = name
		self.limitNumberOfUsers = limitNumberOfUsers
		self.limitTotalAttachmentSize = limitTotalAttachmentSize
	}
}

public struct TalkPost: JSONDecodable {
	public let topic: Topic
	public let talk: Talk
	public let postIds: [PostID]

	public static func parseJSON(data: AnyObject) throws -> TalkPost {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TalkPost)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topic", object: data)
			} else {
				topic = try Topic.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topic", object: data)
		}

		let talk: Talk
		if let v: AnyObject = data["talk"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "talk", object: data)
			} else {
				talk = try Talk.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "talk", object: data)
		}

		let postIds: [PostID]
		if let v: AnyObject = data["postIds"] {
			if v is NSNull {
				postIds = []
			} else {
				postIds = try PostID.parseJSONArray(v)
			}
		} else {
			postIds = []
		}

		return TalkPost(topic: topic, talk: talk, postIds: postIds)
	}

	public init(topic: Topic, talk: Talk, postIds: [PostID] = []) {
		self.topic = topic
		self.talk = talk
		self.postIds = postIds
	}
}

public struct PostLinksEvent: JSONDecodable {
	public let postId: PostID
	public let links: [Link]

	public static func parseJSON(data: AnyObject) throws -> PostLinksEvent {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(PostLinksEvent)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let postId: PostID
		if let v: AnyObject = data["postId"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "postId", object: data)
			} else {
				postId = try PostID.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "postId", object: data)
		}

		let links: [Link]
		if let v: AnyObject = data["links"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "links", object: data)
			} else {
				links = try Link.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "links", object: data)
		}

		return PostLinksEvent(postId: postId, links: links)
	}

	public init(postId: PostID, links: [Link]) {
		self.postId = postId
		self.links = links
	}
}

