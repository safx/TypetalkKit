// This file was auto-generated from ResponseModel.swift with swift-idl.

import Foundation


public struct GetProfileResponse: JSONDecodable {
	public let account: Account

	public static func parseJSON(data: AnyObject) throws -> GetProfileResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetProfileResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
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

		return GetProfileResponse(account: account)
	}
}

public struct GetTopicsResponse: JSONDecodable {
	public let topics: [TopicWithUserInfo]

	public static func parseJSON(data: AnyObject) throws -> GetTopicsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTopicsResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let topics: [TopicWithUserInfo]
		if let v: AnyObject = data["topics"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "topics", object: data)
			} else {
				topics = try TopicWithUserInfo.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topics", object: data)
		}

		return GetTopicsResponse(topics: topics)
	}
}

public struct GetMessagesResponse: JSONDecodable {
	public let team: Team
	public let topic: Topic
	public let bookmark: Bookmark
	public let posts: [Post]
	public let hasNext: Bool

	public static func parseJSON(data: AnyObject) throws -> GetMessagesResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetMessagesResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let team: Team
		if let v: AnyObject = data["team"] {
			if v is NSNull {
				team = Team()
			} else {
				team = try Team.parseJSON(v)
			}
		} else {
			team = Team()
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				topic = Topic()
			} else {
				topic = try Topic.parseJSON(v)
			}
		} else {
			topic = Topic()
		}

		let bookmark: Bookmark
		if let v: AnyObject = data["bookmark"] {
			if v is NSNull {
				bookmark = Bookmark()
			} else {
				bookmark = try Bookmark.parseJSON(v)
			}
		} else {
			bookmark = Bookmark()
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
				hasNext = false
			} else {
				hasNext = try Bool.parseJSON(v)
			}
		} else {
			hasNext = false
		}

		return GetMessagesResponse(team: team, topic: topic, bookmark: bookmark, posts: posts, hasNext: hasNext)
	}

	public init(team: Team = Team(), topic: Topic = Topic(), bookmark: Bookmark = Bookmark(), posts: [Post] = [], hasNext: Bool = false) {
		self.team = team
		self.topic = topic
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
	}
}

public struct PostMessageResponse: JSONDecodable {
	public let topic: Topic?
	public let post: Post?

	public static func parseJSON(data: AnyObject) throws -> PostMessageResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(PostMessageResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
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

		return PostMessageResponse(topic: topic, post: post)
	}
}

public struct GetTopicMembersResponse: JSONDecodable {
	public let accounts: [AccountWithOnlineStatus]
	public let pendings: [AccountWithMailAddress]

	public static func parseJSON(data: AnyObject) throws -> GetTopicMembersResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTopicMembersResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let accounts: [AccountWithOnlineStatus]
		if let v: AnyObject = data["accounts"] {
			if v is NSNull {
				accounts = []
			} else {
				accounts = try AccountWithOnlineStatus.parseJSONArray(v)
			}
		} else {
			accounts = []
		}

		let pendings: [AccountWithMailAddress]
		if let v: AnyObject = data["pendings"] {
			if v is NSNull {
				pendings = []
			} else {
				pendings = try AccountWithMailAddress.parseJSONArray(v)
			}
		} else {
			pendings = []
		}

		return GetTopicMembersResponse(accounts: accounts, pendings: pendings)
	}
}

public struct GetMessageResponse: JSONDecodable {
	public let team: Team
	public let topic: Topic
	public let post: Post
	public let replies: [Post]

	public static func parseJSON(data: AnyObject) throws -> GetMessageResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetMessageResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
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

		let replies: [Post]
		if let v: AnyObject = data["replies"] {
			if v is NSNull {
				replies = []
			} else {
				replies = try Post.parseJSONArray(v)
			}
		} else {
			replies = []
		}

		return GetMessageResponse(team: team, topic: topic, post: post, replies: replies)
	}
}

public struct LikeMessageResponse: JSONDecodable {
	public let like: Like

	public static func parseJSON(data: AnyObject) throws -> LikeMessageResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(LikeMessageResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let like: Like
		if let v: AnyObject = data["like"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "like", object: data)
			} else {
				like = try Like.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "like", object: data)
		}

		return LikeMessageResponse(like: like)
	}
}

public struct SaveReadTopicResponse: JSONDecodable {
	public let unread: Unread

	public static func parseJSON(data: AnyObject) throws -> SaveReadTopicResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(SaveReadTopicResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let unread: Unread
		if let v: AnyObject = data["unread"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "unread", object: data)
			} else {
				unread = try Unread.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "unread", object: data)
		}

		return SaveReadTopicResponse(unread: unread)
	}
}

public struct GetMentionsResponse: JSONDecodable {
	public let mentions: [Mention]

	public static func parseJSON(data: AnyObject) throws -> GetMentionsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetMentionsResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let mentions: [Mention]
		if let v: AnyObject = data["mentions"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "mentions", object: data)
			} else {
				mentions = try Mention.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "mentions", object: data)
		}

		return GetMentionsResponse(mentions: mentions)
	}
}

public struct SaveReadMentionResponse: JSONDecodable {
	public let mention: Mention

	public static func parseJSON(data: AnyObject) throws -> SaveReadMentionResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(SaveReadMentionResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let mention: Mention
		if let v: AnyObject = data["mention"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "mention", object: data)
			} else {
				mention = try Mention.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "mention", object: data)
		}

		return SaveReadMentionResponse(mention: mention)
	}
}

public struct AcceptTeamInviteResponse: JSONDecodable {
	public let topics: [Topic]
	public let invite: Invite? //TeamInvite?

	public static func parseJSON(data: AnyObject) throws -> AcceptTeamInviteResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(AcceptTeamInviteResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let topics: [Topic]
		if let v: AnyObject = data["topics"] {
			if v is NSNull {
				topics = []
			} else {
				topics = try Topic.parseJSONArray(v)
			}
		} else {
			topics = []
		}

		let invite: Invite?
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				invite = nil
			} else {
				invite = try Invite.parseJSON(v)
			}
		} else {
			invite = nil
		}

		return AcceptTeamInviteResponse(topics: topics, invite: invite)
	}
}

public struct DeclineTeamInviteResponse: JSONDecodable {
	public let invite: Invite? //TeamInvite?

	public static func parseJSON(data: AnyObject) throws -> DeclineTeamInviteResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(DeclineTeamInviteResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let invite: Invite?
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				invite = nil
			} else {
				invite = try Invite.parseJSON(v)
			}
		} else {
			invite = nil
		}

		return DeclineTeamInviteResponse(invite: invite)
	}
}

public struct AcceptTopicInviteResponse: JSONDecodable {
	public let invite: Invite //TopicInvite

	public static func parseJSON(data: AnyObject) throws -> AcceptTopicInviteResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(AcceptTopicInviteResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let invite: Invite
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "invite", object: data)
			} else {
				invite = try Invite.parseJSON(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "invite", object: data)
		}

		return AcceptTopicInviteResponse(invite: invite)
	}
}

public struct GetTeamsResponse: JSONDecodable {
	public let teams: [TeamWithCount]

	public static func parseJSON(data: AnyObject) throws -> GetTeamsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTeamsResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let teams: [TeamWithCount]
		if let v: AnyObject = data["teams"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "teams", object: data)
			} else {
				teams = try TeamWithCount.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "teams", object: data)
		}

		return GetTeamsResponse(teams: teams)
	}
}

public struct GetFriendsResponse: JSONDecodable {
	public let accounts: [Account]

	public static func parseJSON(data: AnyObject) throws -> GetFriendsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetFriendsResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let accounts: [Account]
		if let v: AnyObject = data["accounts"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "accounts", object: data)
			} else {
				accounts = try Account.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "accounts", object: data)
		}

		return GetFriendsResponse(accounts: accounts)
	}
}

public struct GetTalksResponse: JSONDecodable {
	public let talks: [Talk]

	public static func parseJSON(data: AnyObject) throws -> GetTalksResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTalksResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
		}

		let talks: [Talk]
		if let v: AnyObject = data["talks"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullable(key: "talks", object: data)
			} else {
				talks = try Talk.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "talks", object: data)
		}

		return GetTalksResponse(talks: talks)
	}
}

public struct CreateTalkResponse: JSONDecodable {
	public let topic: Topic
	public let talk: Talk
	public let postIds: [PostID]

	public static func parseJSON(data: AnyObject) throws -> CreateTalkResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(CreateTalkResponse)", object: data, expected: NSDictionary.self, actual: data.dynamicType)
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
				throw JSONDecodeError.NonNullable(key: "postIds", object: data)
			} else {
				postIds = try PostID.parseJSONArray(v)
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "postIds", object: data)
		}

		return CreateTalkResponse(topic: topic, talk: talk, postIds: postIds)
	}
}

