// This file was auto-generated from ResponseModel.swift with swift-idl.

import Foundation


public struct GetProfileResponse: JSONDecodable {
	public let account: Account

	public static func parseJSON(data: AnyObject) throws -> GetProfileResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetProfileResponse)", type: "NSDictionary")
		}

		let account: Account
		if let v: AnyObject = data["account"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "account")
			} else {
				do {
					account = try Account.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "account", type: "Account")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "account")
		}

		return GetProfileResponse(account: account)
	}
}

public struct GetTopicsResponse: JSONDecodable {
	public let topics: [TopicWithUserInfo]

	public static func parseJSON(data: AnyObject) throws -> GetTopicsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTopicsResponse)", type: "NSDictionary")
		}

		let topics: [TopicWithUserInfo]
		if let v: AnyObject = data["topics"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "topics")
			} else {
				do {
					topics = try TopicWithUserInfo.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "topics")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "topics", type: "TopicWithUserInfo")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topics")
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
			throw JSONDecodeError.TypeMismatch(key: "(GetMessagesResponse)", type: "NSDictionary")
		}

		let team: Team
		if let v: AnyObject = data["team"] {
			if v is NSNull {
				team = Team()
			} else {
				do {
					team = try Team.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "team", type: "Team")
				}
			}
		} else {
			team = Team()
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				topic = Topic()
			} else {
				do {
					topic = try Topic.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
				}
			}
		} else {
			topic = Topic()
		}

		let bookmark: Bookmark
		if let v: AnyObject = data["bookmark"] {
			if v is NSNull {
				bookmark = Bookmark()
			} else {
				do {
					bookmark = try Bookmark.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "bookmark", type: "Bookmark")
				}
			}
		} else {
			bookmark = Bookmark()
		}

		let posts: [Post]
		if let v: AnyObject = data["posts"] {
			if v is NSNull {
				posts = []
			} else {
				do {
					posts = try Post.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "posts")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "posts", type: "Post")
				}
			}
		} else {
			posts = []
		}

		let hasNext: Bool
		if let v: AnyObject = data["hasNext"] {
			if v is NSNull {
				hasNext = false
			} else {
				do {
					hasNext = try Bool.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "hasNext", type: "Bool")
				}
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
			throw JSONDecodeError.TypeMismatch(key: "(PostMessageResponse)", type: "NSDictionary")
		}

		let topic: Topic?
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				topic = nil
			} else {
				do {
					topic = try Topic.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
				}
			}
		} else {
			topic = nil
		}

		let post: Post?
		if let v: AnyObject = data["post"] {
			if v is NSNull {
				post = nil
			} else {
				do {
					post = try Post.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "post", type: "Post")
				}
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
			throw JSONDecodeError.TypeMismatch(key: "(GetTopicMembersResponse)", type: "NSDictionary")
		}

		let accounts: [AccountWithOnlineStatus]
		if let v: AnyObject = data["accounts"] {
			if v is NSNull {
				accounts = []
			} else {
				do {
					accounts = try AccountWithOnlineStatus.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "accounts")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "accounts", type: "AccountWithOnlineStatus")
				}
			}
		} else {
			accounts = []
		}

		let pendings: [AccountWithMailAddress]
		if let v: AnyObject = data["pendings"] {
			if v is NSNull {
				pendings = []
			} else {
				do {
					pendings = try AccountWithMailAddress.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "pendings")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "pendings", type: "AccountWithMailAddress")
				}
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
			throw JSONDecodeError.TypeMismatch(key: "(GetMessageResponse)", type: "NSDictionary")
		}

		let team: Team
		if let v: AnyObject = data["team"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "team")
			} else {
				do {
					team = try Team.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "team", type: "Team")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "team")
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "topic")
			} else {
				do {
					topic = try Topic.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topic")
		}

		let post: Post
		if let v: AnyObject = data["post"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "post")
			} else {
				do {
					post = try Post.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "post", type: "Post")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "post")
		}

		let replies: [Post]
		if let v: AnyObject = data["replies"] {
			if v is NSNull {
				replies = []
			} else {
				do {
					replies = try Post.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "replies")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "replies", type: "Post")
				}
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
			throw JSONDecodeError.TypeMismatch(key: "(LikeMessageResponse)", type: "NSDictionary")
		}

		let like: Like
		if let v: AnyObject = data["like"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "like")
			} else {
				do {
					like = try Like.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "like", type: "Like")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "like")
		}

		return LikeMessageResponse(like: like)
	}
}

public struct SaveReadTopicResponse: JSONDecodable {
	public let unread: Unread

	public static func parseJSON(data: AnyObject) throws -> SaveReadTopicResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(SaveReadTopicResponse)", type: "NSDictionary")
		}

		let unread: Unread
		if let v: AnyObject = data["unread"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "unread")
			} else {
				do {
					unread = try Unread.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "unread", type: "Unread")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "unread")
		}

		return SaveReadTopicResponse(unread: unread)
	}
}

public struct GetMentionsResponse: JSONDecodable {
	public let mentions: [Mention]

	public static func parseJSON(data: AnyObject) throws -> GetMentionsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetMentionsResponse)", type: "NSDictionary")
		}

		let mentions: [Mention]
		if let v: AnyObject = data["mentions"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "mentions")
			} else {
				do {
					mentions = try Mention.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "mentions")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "mentions", type: "Mention")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "mentions")
		}

		return GetMentionsResponse(mentions: mentions)
	}
}

public struct SaveReadMentionResponse: JSONDecodable {
	public let mention: Mention

	public static func parseJSON(data: AnyObject) throws -> SaveReadMentionResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(SaveReadMentionResponse)", type: "NSDictionary")
		}

		let mention: Mention
		if let v: AnyObject = data["mention"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "mention")
			} else {
				do {
					mention = try Mention.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "mention", type: "Mention")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "mention")
		}

		return SaveReadMentionResponse(mention: mention)
	}
}

public struct AcceptTeamInviteResponse: JSONDecodable {
	public let topics: [Topic]
	public let invite: Invite? //TeamInvite?

	public static func parseJSON(data: AnyObject) throws -> AcceptTeamInviteResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(AcceptTeamInviteResponse)", type: "NSDictionary")
		}

		let topics: [Topic]
		if let v: AnyObject = data["topics"] {
			if v is NSNull {
				topics = []
			} else {
				do {
					topics = try Topic.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "topics")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "topics", type: "Topic")
				}
			}
		} else {
			topics = []
		}

		let invite: Invite?
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				invite = nil
			} else {
				do {
					invite = try Invite.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "invite", type: "Invite")
				}
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
			throw JSONDecodeError.TypeMismatch(key: "(DeclineTeamInviteResponse)", type: "NSDictionary")
		}

		let invite: Invite?
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				invite = nil
			} else {
				do {
					invite = try Invite.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "invite", type: "Invite")
				}
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
			throw JSONDecodeError.TypeMismatch(key: "(AcceptTopicInviteResponse)", type: "NSDictionary")
		}

		let invite: Invite
		if let v: AnyObject = data["invite"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "invite")
			} else {
				do {
					invite = try Invite.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "invite", type: "Invite")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "invite")
		}

		return AcceptTopicInviteResponse(invite: invite)
	}
}

public struct GetTeamsResponse: JSONDecodable {
	public let teams: [TeamWithCount]

	public static func parseJSON(data: AnyObject) throws -> GetTeamsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTeamsResponse)", type: "NSDictionary")
		}

		let teams: [TeamWithCount]
		if let v: AnyObject = data["teams"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "teams")
			} else {
				do {
					teams = try TeamWithCount.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "teams")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "teams", type: "TeamWithCount")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "teams")
		}

		return GetTeamsResponse(teams: teams)
	}
}

public struct GetFriendsResponse: JSONDecodable {
	public let accounts: [Account]

	public static func parseJSON(data: AnyObject) throws -> GetFriendsResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetFriendsResponse)", type: "NSDictionary")
		}

		let accounts: [Account]
		if let v: AnyObject = data["accounts"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "accounts")
			} else {
				do {
					accounts = try Account.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "accounts")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "accounts", type: "Account")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "accounts")
		}

		return GetFriendsResponse(accounts: accounts)
	}
}

public struct GetTalksResponse: JSONDecodable {
	public let talks: [Talk]

	public static func parseJSON(data: AnyObject) throws -> GetTalksResponse {
		if !(data is NSDictionary) {
			throw JSONDecodeError.TypeMismatch(key: "(GetTalksResponse)", type: "NSDictionary")
		}

		let talks: [Talk]
		if let v: AnyObject = data["talks"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "talks")
			} else {
				do {
					talks = try Talk.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "talks")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "talks", type: "Talk")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "talks")
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
			throw JSONDecodeError.TypeMismatch(key: "(CreateTalkResponse)", type: "NSDictionary")
		}

		let topic: Topic
		if let v: AnyObject = data["topic"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "topic")
			} else {
				do {
					topic = try Topic.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "topic", type: "Topic")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "topic")
		}

		let talk: Talk
		if let v: AnyObject = data["talk"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "talk")
			} else {
				do {
					talk = try Talk.parseJSON(v)
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "talk", type: "Talk")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "talk")
		}

		let postIds: [PostID]
		if let v: AnyObject = data["postIds"] {
			if v is NSNull {
				throw JSONDecodeError.NonNullablle(key: "postIds")
			} else {
				do {
					postIds = try PostID.parseJSONArray(v)
				} catch JSONDecodeError.NonNullablle {
					throw JSONDecodeError.NonNullablle(key: "postIds")
				} catch JSONDecodeError.ValueTranslationFailed {
					throw JSONDecodeError.TypeMismatch(key: "postIds", type: "PostID")
				}
			}
		} else {
			throw JSONDecodeError.MissingKey(key: "postIds")
		}

		return CreateTalkResponse(topic: topic, talk: talk, postIds: postIds)
	}
}

