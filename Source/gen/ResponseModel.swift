// This file was auto-generated from ResponseModel.swift with swift-idl.

import Foundation


public struct GetProfileResponse: Decodable {
	public let account: Account

}

public struct GetOnlineStatusResponse: Decodable {
	public let accounts: [AccountWithLoginStatus]

}

public struct GetTopicsResponse: Decodable {
	public let topics: [TopicWithUserInfo]

}

public struct GetDmTopicsResponse: Decodable {
	public let topics: [DirectMessageTopic]

}

public struct GetMessagesResponse: Decodable {
	public let mySpace: MySpace?
	public let team: Team?
	public let topic: Topic
	public let bookmark: Bookmark
	public let posts: [Post]
	public let hasNext: Bool
	public let exceedsAttachmentLimit: Bool


	public init(mySpace: MySpace? = nil, team: Team? = nil, topic: Topic = Topic(), bookmark: Bookmark = Bookmark(), posts: [Post] = [], hasNext: Bool = false, exceedsAttachmentLimit: Bool = false) {
		self.mySpace = mySpace
		self.team = team
		self.topic = topic
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
		self.exceedsAttachmentLimit = exceedsAttachmentLimit
	}
}

public struct PostMessageResponse: Decodable {
	public let topic: Topic?
	public let post: Post?
	public let mentions: [Mention]?
	public let exceedsAttachmentLimit: Bool?

}

public struct GetTopicMembersResponse: Decodable {
	public let accounts: [AccountWithOnlineStatus]?
	public let pendings: [AccountWithMailAddress]?

}

public struct GetMessageResponse: Decodable {
	public let mySpace: MySpace?
	public let team: Team?
	public let topic: Topic
	public let post: Post
	public let replies: [Post]?
	public let exceedsAttachmentLimit: Bool

}

public struct SearchMessagesResponse: Decodable {
	public let count: Int
	public let posts: [Post]
	public let isLimited: Bool

}

public struct LikeMessageResponse: Decodable {
	public let like: Like
	public let topic: Topic?
	public let directMessage: DirectMessageTopic?
	public let post: Post?

}

public struct FavoriteTopicResponse: Decodable {
	public let topic: Topic
	public let favorite: Bool

}

public struct GetDirectMessagesResponse: Decodable {
	public let topic: Topic?
	public let directMessage: AccountWithLoginStatus
	public let bookmark: Bookmark?
	public let posts: [Post]?
	public let hasNext: Bool?


	public init(topic: Topic? = nil, directMessage: AccountWithLoginStatus, bookmark: Bookmark? = nil, posts: [Post]? = nil, hasNext: Bool? = nil) {
		self.topic = topic
		self.directMessage = directMessage
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
	}
}

public struct PostDirectMessageResponse: Decodable {
	public let topic: Topic
	public let directMessage: AccountWithLoginStatus
	public let mentions: [Mention]
	public let post: Post
	public let exceedsAttachmentLimit: Bool


	public init(topic: Topic, directMessage: AccountWithLoginStatus, mentions: [Mention], post: Post, exceedsAttachmentLimit: Bool) {
		self.topic = topic
		self.directMessage = directMessage
		self.mentions = mentions
		self.post = post
		self.exceedsAttachmentLimit = exceedsAttachmentLimit
	}
}

public struct GetNotificationStatusResponse: Decodable {
	public let doNotDisturb: DoNotDisturb
	public let statuses: [NotificationStatus]


	public init(doNotDisturb: DoNotDisturb, statuses: [NotificationStatus]) {
		self.doNotDisturb = doNotDisturb
		self.statuses = statuses
	}
}

public struct SaveReadTopicResponse: Decodable {
	public let unread: Unread

}

public struct GetMentionsResponse: Decodable {
	public let mentions: [Mention]

}

public struct SaveReadMentionResponse: Decodable {
	public let mention: Mention

}

public struct GetSpacesResponse: Decodable {
	public let mySpaces: [MySpace]

}

public struct GetSpaceMembersResponse: Decodable {
	public let accounts: [Account]
	public let groups: [GroupWithCount]

}

public struct GetTeamsResponse: Decodable {
	public let teams: [TeamWithCount]

}

public struct GetFriendsResponse: Decodable {
	public let accounts: [Account]

}

public struct GetTalksResponse: Decodable {
	public let talks: [Talk]

}

public struct GetTalkResponse: Decodable {
	public let mySpace: MySpace?
	public let topic: Topic
	public let talk: Talk
	public let posts: [Post]?
	public let hasNext: Bool


	public init(mySpace: MySpace? = nil, topic: Topic, talk: Talk, posts: [Post]? = nil, hasNext: Bool) {
		self.mySpace = mySpace
		self.topic = topic
		self.talk = talk
		self.posts = posts
		self.hasNext = hasNext
	}
}

public struct CreateTalkResponse: Decodable {
	public let topic: Topic
	public let talk: Talk
	public let postIds: [Int]

}

public struct UpdateTalkResponse: Decodable {
	public let topic: Topic
	public let talk: Talk

}

public struct GetReceivedLikesResponse: Decodable {
	public let likedPosts: [LikedPost]

}

public struct GetGivenLikesResponse: Decodable {
	public let likedPosts: [MyLikedPost]

}

public struct SaveReadLikesResponse: Decodable {
	public let like: LikeStatus

}

public struct CreateTopicGroupResponse: Decodable {
	public let myTopicGroup: TopicGroup
	public let myTopics: [MyTopic]

}

public struct UpdateTopicGroupResponse: Decodable {
	public let myTopicGroup: TopicGroup

}

public struct GetMyTopicsResponse: Decodable {
	public let pinnedTopics: [PinnedTopic]
	public let favoritesOnboarding: Bool
	public let myTopicGroups: [TopicGroup]
	public let joinedTopics: [Topic]

}

public struct AddTopicToGroupResponse: Decodable {
	public let myTopic: MyTopic

}

public struct DeleteMyTopicResponse: Decodable {
	public let myTopic: MyTopic

}

public struct PinTopicResponse: Decodable {
	public let pinnedTopics: [MyTopic]

}

