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
	public let version: Float
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

		let version: Float
		if let v: AnyObject = data["version"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "version", object: data)
			} else {
				version = try Float.parseJSON(v)
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
}

public struct Mention: JSONDecodable {
	public let id: MentionID
	public let readAt: NSDate?
	public let post: Post?

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

		let post: Post?
		if let v: AnyObject = data["post"] {
			if v is NSNull {
				post = nil
			} else {
				post = try Post.parseJSON(v)
			}
		} else {
			post = nil
		}

		return Mention(id: id, readAt: readAt, post: post)
	}

	public init(id: MentionID = 0, readAt: NSDate? = nil, post: Post? = nil) {
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
		}
	}
}

public struct Post: JSONDecodable {
	public let id: PostID
	public let topicId: TopicID
	public let topic: Topic?
	public let replyTo: Int?
	public let message: String
	public let account: Account
	public let attachments: [URLAttachment]
	public let likes: [Like]
	public let talks: [Talk]
	public let links: [Link]
	public let createdAt: NSDate
	public let updatedAt: NSDate

	public static func parseJSON(data: AnyObject) throws -> Post {
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

		return Post(id: id, topicId: topicId, topic: topic, replyTo: replyTo, message: message, account: account, attachments: attachments, likes: likes, talks: talks, links: links, createdAt: createdAt, updatedAt: updatedAt)
	}

	public init(id: PostID = 0, topicId: TopicID = 0, topic: Topic? = nil, replyTo: Int? = nil, message: String = "", account: Account = Account(), attachments: [URLAttachment] = [], likes: [Like] = [], talks: [Talk] = [], links: [Link] = [], createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
		self.id = id
		self.topicId = topicId
		self.topic = topic
		self.replyTo = replyTo
		self.message = message
		self.account = account
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

		return Talk(id: id, topicId: topicId, name: name, suggestion: suggestion, createdAt: createdAt, updatedAt: updatedAt)
	}
}

public struct TalkMessages: JSONDecodable {
	public let topic: Topic
	public let talk: Talk
	public let posts: [Post]
	public let hasNext: Bool

	public static func parseJSON(data: AnyObject) throws -> TalkMessages {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(TalkMessages)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
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

		let posts: [Post]
		if let v: AnyObject = data["posts"] {
			if v is NSNull {
				posts = []
			} else {
				posts = try Post.parseJSONArray(v)
			}
		} else {
			posts = []
		}

		let hasNext: Bool
		if let v: AnyObject = data["hasNext"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "hasNext", object: data)
			} else {
				hasNext = try Bool.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "hasNext", object: data)
		}

		return TalkMessages(topic: topic, talk: talk, posts: posts, hasNext: hasNext)
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
	public let teams: [TeamWithMembers]
	public let accounts: [Account]
	public let invites: [Invite]

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

		return TopicWithAccounts(topic: topic, teams: teams, accounts: accounts, invites: invites)
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
}

