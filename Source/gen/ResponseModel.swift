// This file was auto-generated from ResponseModel.swift with swift-idl.

import Foundation


public struct GetProfileResponse: JSONDecodable {
	public let account: Account

	public static func parse(with JSONObject: Any) throws -> GetProfileResponse {
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

		return GetProfileResponse(account: account)
	}
}

public struct GetOnlineStatusResponse: JSONDecodable {
	public let accounts: [AccountWithLoginStatus]

	public static func parse(with JSONObject: Any) throws -> GetOnlineStatusResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let accounts: [AccountWithLoginStatus]
		if let v: AnyObject = dic["accounts"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "accounts", object: JSONObject)
			} else {
				accounts = try AccountWithLoginStatus.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "accounts", object: JSONObject)
		}

		return GetOnlineStatusResponse(accounts: accounts)
	}
}

public struct GetTopicsResponse: JSONDecodable {
	public let topics: [TopicWithUserInfo]

	public static func parse(with JSONObject: Any) throws -> GetTopicsResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topics: [TopicWithUserInfo]
		if let v: AnyObject = dic["topics"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topics", object: JSONObject)
			} else {
				topics = try TopicWithUserInfo.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topics", object: JSONObject)
		}

		return GetTopicsResponse(topics: topics)
	}
}

public struct GetDmTopicsResponse: JSONDecodable {
	public let topics: [DirectMessageTopic]

	public static func parse(with JSONObject: Any) throws -> GetDmTopicsResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let topics: [DirectMessageTopic]
		if let v: AnyObject = dic["topics"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "topics", object: JSONObject)
			} else {
				topics = try DirectMessageTopic.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "topics", object: JSONObject)
		}

		return GetDmTopicsResponse(topics: topics)
	}
}

public struct GetMessagesResponse: JSONDecodable {
	public let mySpace: Space?
	public let team: Team?
	public let topic: Topic
	public let bookmark: Bookmark
	public let posts: [Post]
	public let hasNext: Bool
	public let exceedsAttachmentLimit: Bool

	public static func parse(with JSONObject: Any) throws -> GetMessagesResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
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

		let team: Team?
		if let v: AnyObject = dic["team"] {
			if v is NSNull {
				team = nil
			} else {
				team = try Team.parse(with: v)
			}
		} else {
			team = nil
		}

		let topic: Topic
		if let v: AnyObject = dic["topic"] {
			if v is NSNull {
				topic = Topic()
			} else {
				topic = try Topic.parse(with: v)
			}
		} else {
			topic = Topic()
		}

		let bookmark: Bookmark
		if let v: AnyObject = dic["bookmark"] {
			if v is NSNull {
				bookmark = Bookmark()
			} else {
				bookmark = try Bookmark.parse(with: v)
			}
		} else {
			bookmark = Bookmark()
		}

		let posts: [Post]
		if let v: AnyObject = dic["posts"] {
			if v is NSNull {
				posts = []
			} else {
				posts = try Post.parseAsArray(with: v)
			}
		} else {
			posts = []
		}

		let hasNext: Bool
		if let v: AnyObject = dic["hasNext"] {
			if v is NSNull {
				hasNext = false
			} else {
				hasNext = try Bool.parse(with: v)
			}
		} else {
			hasNext = false
		}

		let exceedsAttachmentLimit: Bool
		if let v: AnyObject = dic["exceedsAttachmentLimit"] {
			if v is NSNull {
				exceedsAttachmentLimit = false
			} else {
				exceedsAttachmentLimit = try Bool.parse(with: v)
			}
		} else {
			exceedsAttachmentLimit = false
		}

		return GetMessagesResponse(mySpace: mySpace, team: team, topic: topic, bookmark: bookmark, posts: posts, hasNext: hasNext, exceedsAttachmentLimit: exceedsAttachmentLimit)
	}

	public init(mySpace: Space? = nil, team: Team? = nil, topic: Topic = Topic(), bookmark: Bookmark = Bookmark(), posts: [Post] = [], hasNext: Bool = false, exceedsAttachmentLimit: Bool = false) {
		self.mySpace = mySpace
		self.team = team
		self.topic = topic
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
		self.exceedsAttachmentLimit = exceedsAttachmentLimit
	}
}

public struct PostMessageResponse: JSONDecodable {
	public let topic: Topic?
	public let post: Post?
	public let mentions: [Mention]
	public let exceedsAttachmentLimit: Bool

	public static func parse(with JSONObject: Any) throws -> PostMessageResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
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

		let exceedsAttachmentLimit: Bool
		if let v: AnyObject = dic["exceedsAttachmentLimit"] {
			if v is NSNull {
				exceedsAttachmentLimit = false
			} else {
				exceedsAttachmentLimit = try Bool.parse(with: v)
			}
		} else {
			exceedsAttachmentLimit = false
		}

		return PostMessageResponse(topic: topic, post: post, mentions: mentions, exceedsAttachmentLimit: exceedsAttachmentLimit)
	}
}

public struct GetTopicMembersResponse: JSONDecodable {
	public let accounts: [AccountWithOnlineStatus]
	public let pendings: [AccountWithMailAddress]

	public static func parse(with JSONObject: Any) throws -> GetTopicMembersResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let accounts: [AccountWithOnlineStatus]
		if let v: AnyObject = dic["accounts"] {
			if v is NSNull {
				accounts = []
			} else {
				accounts = try AccountWithOnlineStatus.parseAsArray(with: v)
			}
		} else {
			accounts = []
		}

		let pendings: [AccountWithMailAddress]
		if let v: AnyObject = dic["pendings"] {
			if v is NSNull {
				pendings = []
			} else {
				pendings = try AccountWithMailAddress.parseAsArray(with: v)
			}
		} else {
			pendings = []
		}

		return GetTopicMembersResponse(accounts: accounts, pendings: pendings)
	}
}

public struct GetMessageResponse: JSONDecodable {
	public let mySpace: Space?
	public let team: Team?
	public let topic: Topic
	public let post: Post
	public let replies: [Post]
	public let exceedsAttachmentLimit: Bool

	public static func parse(with JSONObject: Any) throws -> GetMessageResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
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

		let team: Team?
		if let v: AnyObject = dic["team"] {
			if v is NSNull {
				team = nil
			} else {
				team = try Team.parse(with: v)
			}
		} else {
			team = nil
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

		let post: Post
		if let v: AnyObject = dic["post"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "post", object: JSONObject)
			} else {
				post = try Post.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "post", object: JSONObject)
		}

		let replies: [Post]
		if let v: AnyObject = dic["replies"] {
			if v is NSNull {
				replies = []
			} else {
				replies = try Post.parseAsArray(with: v)
			}
		} else {
			replies = []
		}

		let exceedsAttachmentLimit: Bool
		if let v: AnyObject = dic["exceedsAttachmentLimit"] {
			if v is NSNull {
				exceedsAttachmentLimit = false
			} else {
				exceedsAttachmentLimit = try Bool.parse(with: v)
			}
		} else {
			exceedsAttachmentLimit = false
		}

		return GetMessageResponse(mySpace: mySpace, team: team, topic: topic, post: post, replies: replies, exceedsAttachmentLimit: exceedsAttachmentLimit)
	}
}

public struct LikeMessageResponse: JSONDecodable {
	public let like: Like
	public let topic: Topic?
	public let directMessage: DirectMessageTopic?
	public let post: Post?

	public static func parse(with JSONObject: Any) throws -> LikeMessageResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let like: Like
		if let v: AnyObject = dic["like"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "like", object: JSONObject)
			} else {
				like = try Like.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "like", object: JSONObject)
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

		let directMessage: DirectMessageTopic?
		if let v: AnyObject = dic["directMessage"] {
			if v is NSNull {
				directMessage = nil
			} else {
				directMessage = try DirectMessageTopic.parse(with: v)
			}
		} else {
			directMessage = nil
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

		return LikeMessageResponse(like: like, topic: topic, directMessage: directMessage, post: post)
	}
}

public struct FavoriteTopicResponse: JSONDecodable {
	public let topic: Topic
	public let favorite: Bool

	public static func parse(with JSONObject: Any) throws -> FavoriteTopicResponse {
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

		return FavoriteTopicResponse(topic: topic, favorite: favorite)
	}
}

public struct GetDirectMessagesResponse: JSONDecodable {
	public let topic: Topic?
	public let directMessage: AccountWithLoginStatus
	public let bookmark: Bookmark?
	public let posts: [Post]
	public let hasNext: Bool?

	public static func parse(with JSONObject: Any) throws -> GetDirectMessagesResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
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

		let bookmark: Bookmark?
		if let v: AnyObject = dic["bookmark"] {
			if v is NSNull {
				bookmark = nil
			} else {
				bookmark = try Bookmark.parse(with: v)
			}
		} else {
			bookmark = nil
		}

		let posts: [Post]
		if let v: AnyObject = dic["posts"] {
			if v is NSNull {
				posts = []
			} else {
				posts = try Post.parseAsArray(with: v)
			}
		} else {
			posts = []
		}

		let hasNext: Bool?
		if let v: AnyObject = dic["hasNext"] {
			if v is NSNull {
				hasNext = nil
			} else {
				hasNext = try Bool.parse(with: v)
			}
		} else {
			hasNext = nil
		}

		return GetDirectMessagesResponse(topic: topic, directMessage: directMessage, bookmark: bookmark, posts: posts, hasNext: hasNext)
	}

	public init(topic: Topic? = nil, directMessage: AccountWithLoginStatus, bookmark: Bookmark? = nil, posts: [Post] = [], hasNext: Bool? = nil) {
		self.topic = topic
		self.directMessage = directMessage
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
	}
}

public struct PostDirectMessageResponse: JSONDecodable {
	public let topic: Topic
	public let directMessage: AccountWithLoginStatus
	public let mentions: [Mention]
	public let post: Post
	public let exceedsAttachmentLimit: Bool

	public static func parse(with JSONObject: Any) throws -> PostDirectMessageResponse {
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

		let mentions: [Mention]
		if let v: AnyObject = dic["mentions"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "mentions", object: JSONObject)
			} else {
				mentions = try Mention.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "mentions", object: JSONObject)
		}

		let post: Post
		if let v: AnyObject = dic["post"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "post", object: JSONObject)
			} else {
				post = try Post.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "post", object: JSONObject)
		}

		let exceedsAttachmentLimit: Bool
		if let v: AnyObject = dic["exceedsAttachmentLimit"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "exceedsAttachmentLimit", object: JSONObject)
			} else {
				exceedsAttachmentLimit = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "exceedsAttachmentLimit", object: JSONObject)
		}

		return PostDirectMessageResponse(topic: topic, directMessage: directMessage, mentions: mentions, post: post, exceedsAttachmentLimit: exceedsAttachmentLimit)
	}

	public init(topic: Topic, directMessage: AccountWithLoginStatus, mentions: [Mention], post: Post, exceedsAttachmentLimit: Bool) {
		self.topic = topic
		self.directMessage = directMessage
		self.mentions = mentions
		self.post = post
		self.exceedsAttachmentLimit = exceedsAttachmentLimit
	}
}

public struct SaveReadTopicResponse: JSONDecodable {
	public let unread: Unread

	public static func parse(with JSONObject: Any) throws -> SaveReadTopicResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
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

		return SaveReadTopicResponse(unread: unread)
	}
}

public struct GetMentionsResponse: JSONDecodable {
	public let mentions: [Mention]

	public static func parse(with JSONObject: Any) throws -> GetMentionsResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let mentions: [Mention]
		if let v: AnyObject = dic["mentions"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "mentions", object: JSONObject)
			} else {
				mentions = try Mention.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "mentions", object: JSONObject)
		}

		return GetMentionsResponse(mentions: mentions)
	}
}

public struct SaveReadMentionResponse: JSONDecodable {
	public let mention: Mention

	public static func parse(with JSONObject: Any) throws -> SaveReadMentionResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let mention: Mention
		if let v: AnyObject = dic["mention"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "mention", object: JSONObject)
			} else {
				mention = try Mention.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "mention", object: JSONObject)
		}

		return SaveReadMentionResponse(mention: mention)
	}
}

public struct GetSpacesResponse: JSONDecodable {
	public let mySpaces: [Space]

	public static func parse(with JSONObject: Any) throws -> GetSpacesResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let mySpaces: [Space]
		if let v: AnyObject = dic["mySpaces"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "mySpaces", object: JSONObject)
			} else {
				mySpaces = try Space.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "mySpaces", object: JSONObject)
		}

		return GetSpacesResponse(mySpaces: mySpaces)
	}
}

public struct GetSpaceMembersResponse: JSONDecodable {
	public let accounts: [Account]
	public let groups: [GroupWithCount]

	public static func parse(with JSONObject: Any) throws -> GetSpaceMembersResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let accounts: [Account]
		if let v: AnyObject = dic["accounts"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "accounts", object: JSONObject)
			} else {
				accounts = try Account.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "accounts", object: JSONObject)
		}

		let groups: [GroupWithCount]
		if let v: AnyObject = dic["groups"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "groups", object: JSONObject)
			} else {
				groups = try GroupWithCount.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "groups", object: JSONObject)
		}

		return GetSpaceMembersResponse(accounts: accounts, groups: groups)
	}
}

public struct GetTeamsResponse: JSONDecodable {
	public let teams: [TeamWithCount]

	public static func parse(with JSONObject: Any) throws -> GetTeamsResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let teams: [TeamWithCount]
		if let v: AnyObject = dic["teams"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "teams", object: JSONObject)
			} else {
				teams = try TeamWithCount.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "teams", object: JSONObject)
		}

		return GetTeamsResponse(teams: teams)
	}
}

public struct GetFriendsResponse: JSONDecodable {
	public let accounts: [Account]

	public static func parse(with JSONObject: Any) throws -> GetFriendsResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let accounts: [Account]
		if let v: AnyObject = dic["accounts"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "accounts", object: JSONObject)
			} else {
				accounts = try Account.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "accounts", object: JSONObject)
		}

		return GetFriendsResponse(accounts: accounts)
	}
}

public struct GetTalksResponse: JSONDecodable {
	public let talks: [Talk]

	public static func parse(with JSONObject: Any) throws -> GetTalksResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let talks: [Talk]
		if let v: AnyObject = dic["talks"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "talks", object: JSONObject)
			} else {
				talks = try Talk.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "talks", object: JSONObject)
		}

		return GetTalksResponse(talks: talks)
	}
}

public struct GetTalkResponse: JSONDecodable {
	public let mySpace: Space?
	public let topic: Topic
	public let talk: Talk
	public let posts: [Post]
	public let hasNext: Bool

	public static func parse(with JSONObject: Any) throws -> GetTalkResponse {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
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

		let posts: [Post]
		if let v: AnyObject = dic["posts"] {
			if v is NSNull {
				posts = []
			} else {
				posts = try Post.parseAsArray(with: v)
			}
		} else {
			posts = []
		}

		let hasNext: Bool
		if let v: AnyObject = dic["hasNext"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "hasNext", object: JSONObject)
			} else {
				hasNext = try Bool.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "hasNext", object: JSONObject)
		}

		return GetTalkResponse(mySpace: mySpace, topic: topic, talk: talk, posts: posts, hasNext: hasNext)
	}

	public init(mySpace: Space? = nil, topic: Topic, talk: Talk, posts: [Post] = [], hasNext: Bool) {
		self.mySpace = mySpace
		self.topic = topic
		self.talk = talk
		self.posts = posts
		self.hasNext = hasNext
	}
}

public struct CreateTalkResponse: JSONDecodable {
	public let topic: Topic
	public let talk: Talk
	public let postIds: [Int]

	public static func parse(with JSONObject: Any) throws -> CreateTalkResponse {
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
				throw JSONDecodeError.nonNullable(key: "postIds", object: JSONObject)
			} else {
				postIds = try Int.parseAsArray(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "postIds", object: JSONObject)
		}

		return CreateTalkResponse(topic: topic, talk: talk, postIds: postIds)
	}
}

public struct UpdateTalkResponse: JSONDecodable {
	public let topic: Topic
	public let talk: Talk

	public static func parse(with JSONObject: Any) throws -> UpdateTalkResponse {
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

		return UpdateTalkResponse(topic: topic, talk: talk)
	}
}

