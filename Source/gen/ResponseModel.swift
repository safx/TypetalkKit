// This file was auto-generated from ResponseModel.swift with swift-idl.

import Foundation


public struct GetProfileResponse: Decodable {
	public let account: Account
	public let lang: String
	public let theme: String
	public let post: GetProfileResponse.Post


	public class Post: Decodable {
		public let emojiSkinTone: String
		public let useCtrl: Bool

	}
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
	public let myTopic: MyTopic?
	public let team: Team?
	public let topic: Topic
	public let bookmark: Bookmark
	public let posts: [Post]
	public let hasNext: Bool
	public let exceedsAttachmentLimit: Bool
	public let onboarding: Bool?
	public let isPostEnabled: Bool
	public let favorite: Bool


	public init(mySpace: MySpace? = nil, myTopic: MyTopic? = nil, team: Team? = nil, topic: Topic = Topic(), bookmark: Bookmark = Bookmark(), posts: [Post] = [], hasNext: Bool = false, exceedsAttachmentLimit: Bool = false, onboarding: Bool? = nil, isPostEnabled: Bool, favorite: Bool) {
		self.mySpace = mySpace
		self.myTopic = myTopic
		self.team = team
		self.topic = topic
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
		self.exceedsAttachmentLimit = exceedsAttachmentLimit
		self.onboarding = onboarding
		self.isPostEnabled = isPostEnabled
		self.favorite = favorite
	}
}

public struct PostMessageResponse: Decodable {
	public let space: SpaceInfo
	public let topic: Topic
	public let post: Post
	public let directMessage: Post?
	public let mentions: [Mention]
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
	public let isPostEnabled: Bool
	public let exceedsAttachmentLimit: Bool

}

public struct SearchMessagesResponse: Decodable {
	public let count: Int
	public let posts: [Post]
	public let isLimited: Bool

}

public struct LikeMessageResponse: Decodable {
	public let space: SpaceInfo
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
	public let topic: Topic
	public let mySpace: MySpace
	public let directMessage: AccountWithLoginStatus
	public let bookmark: Bookmark
	public let posts: [Post]
	public let hasNext: Bool?


	public init(topic: Topic, mySpace: MySpace, directMessage: AccountWithLoginStatus, bookmark: Bookmark, posts: [Post] = [], hasNext: Bool? = nil) {
		self.topic = topic
		self.mySpace = mySpace
		self.directMessage = directMessage
		self.bookmark = bookmark
		self.posts = posts
		self.hasNext = hasNext
	}
}

public struct PostDirectMessageResponse: Decodable {
	public let topic: Topic
	public let space: SpaceInfo
	public let directMessage: AccountWithLoginStatus
	public let mentions: [Mention]
	public let post: Post
	public let exceedsAttachmentLimit: Bool


	public init(topic: Topic, space: SpaceInfo, directMessage: AccountWithLoginStatus, mentions: [Mention], post: Post, exceedsAttachmentLimit: Bool) {
		self.topic = topic
		self.space = space
		self.directMessage = directMessage
		self.mentions = mentions
		self.post = post
		self.exceedsAttachmentLimit = exceedsAttachmentLimit
	}
}

public struct GetNotificationStatusResponse: Decodable {
	public let notificationSettings: GetNotificationStatusResponse.NotificationSettings
	public let statuses: [NotificationStatus]


	public init(notificationSettings: GetNotificationStatusResponse.NotificationSettings, statuses: [NotificationStatus]) {
		self.notificationSettings = notificationSettings
		self.statuses = statuses
	}

	public struct NotificationSettings: Decodable {
		public let doNotDisturb: DoNotDisturb
		public let favoriteTopicMobile: Bool

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

public struct DeleteTopicResponse: Decodable {
	public let myTopic: MyTopic

}

public struct GetSpacesResponse: Decodable {
	public let mySpaces: [MySpace]

}

public struct GetSpaceMembersResponse: Decodable {
	public let accounts: [Account]
	public let groups: [GroupWithCount]

}

public struct GetFriendsResponse: Decodable {
	public let accounts: [AccountWithLoginStatus]
	public let count: Int

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
	public let myTopics: CreateTopicGroupResponse.MyTopics


	public struct MyTopics: Decodable {
		public let myTopic: MyTopic

	}
}

public struct UpdateTopicGroupResponse: Decodable {
	public let myTopicGroup: TopicGroup

}

public struct GetMyTopicsResponse: Decodable {
	public let pinnedTopics: [GetMyTopicsResponse.MyTopic]
	public let myTopicGroups: [GetMyTopicsResponse.MyTopicGroup]
	public let joinedTopics: [GetMyTopicsResponse.MyTopic]
	public let favoritesOnboarding: Bool


	public struct MyTopic: Decodable {
		public let topic: Topic
		public let unread: Unread
		public let exTopicGroupId: Int?
		public let createdAt: Date


		public init(topic: Topic, unread: Unread, exTopicGroupId: Int? = nil, createdAt: Date = Date()) {
			self.topic = topic
			self.unread = unread
			self.exTopicGroupId = exTopicGroupId
			self.createdAt = createdAt
		}
	}

	public struct MyTopicGroup: Decodable {
		public let myTopicGroup: TopicGroup
		public let myTopics: [GetMyTopicsResponse.MyTopic]


		public init(myTopicGroup: TopicGroup, myTopics: [GetMyTopicsResponse.MyTopic]) {
			self.myTopicGroup = myTopicGroup
			self.myTopics = myTopics
		}
	}
}

public struct AddTopicToGroupResponse: Decodable {
	public let myTopic: MyTopic

}

public struct DeleteMyTopicResponse: Decodable {
	public let myTopic: MyTopic

}

public struct PinTopicResponse: Decodable {
	public let pinnedTopics: [PinTopicResponse.PinnedTopic]


	public struct PinnedTopic: Decodable {
		public let myTopic: MyTopic

	}
}

