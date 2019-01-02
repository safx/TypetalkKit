//
//  Response.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/07/17.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation

public struct GetProfileResponse: Decodable {
    public let account: Account
    public let lang: String
    public let theme: String
    public let post: Post
    class Post: Decodable {
        public let let emojiSkinTone: String
        public let let useCtrl: Bool
    }
}

public struct GetOnlineStatusResponse: Decodable {
    let accounts: [AccountWithLoginStatus]
}

public struct GetTopicsResponse: Decodable {
    public let topics: [TopicWithUserInfo]
}

public struct GetDmTopicsResponse: Decodable {
    public let topics: [DirectMessageTopic]
}

public struct GetMessagesResponse: Decodable, ClassInit {
    public let mySpace: MySpace?
    public let myTopic: MyTopic?
    public let team: Team? = nil
    public let topic: Topic = Topic()
    public let bookmark: Bookmark = Bookmark()
    public let posts: [Post] = []
    public let hasNext: Bool = false
    public let exceedsAttachmentLimit: Bool = false
    public let onboarding: Bool?
    public let isPostEnabled: Bool
    public let favorite: Bool
}

public struct PostMessageResponse: Decodable {
    public let space: SpaceInfo
    public let topic: Topic
    public let post: Post
    public let directMessage: Post? // FIXME
    public let mentions: [Mention] = []
    public let exceedsAttachmentLimit: Bool? = nil
}

public struct GetTopicMembersResponse: Decodable {
    public let accounts: [AccountWithOnlineStatus]? = nil
    public let pendings: [AccountWithMailAddress]? = nil
}

public struct GetMessageResponse: Decodable {
    public let mySpace: MySpace?
    public let team: Team? = nil
    public let topic: Topic
    public let post: Post
    public let replies: [Post]? = nil
    public let isPostEnabled: Bool
    public let exceedsAttachmentLimit: Bool = false
}

struct SearchMessagesResponse: Decodable {
    let count: Int
    let posts: [Post]
    let isLimited: Bool
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

public struct GetDirectMessagesResponse: Decodable, ClassInit {
    public let topic: Topic
    public let mySpace: MySpace
    public let directMessage: AccountWithLoginStatus
    public let bookmark: Bookmark
    public let posts: [Post] = []
    public let hasNext: Bool?
}

public struct PostDirectMessageResponse: Decodable, ClassInit {
    public let topic: Topic
    public let space: SpaceInfo
    public let directMessage: AccountWithLoginStatus
    public let mentions: [Mention]
    public let post: Post
    public let exceedsAttachmentLimit: Bool
}

struct GetNotificationStatusResponse: Decodable, ClassInit {
    public let notificationSettings: NotificationSettings
    public let statuses: [NotificationStatus]
    
    struct NotificationSettings: Decodable {
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

public struct GetTalkResponse: Decodable, ClassInit {
    public let mySpace: MySpace?
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post]? = nil
    public let hasNext: Bool
}

public struct CreateTalkResponse: Decodable {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID]
}

public struct UpdateTalkResponse: Decodable {
    public let topic: Topic
    public let talk: Talk
}

struct GetReceivedLikesResponse: Decodable {
    public let likedPosts: [LikedPost]
}

struct GetGivenLikesResponse: Decodable {
    public let likedPosts: [MyLikedPost]
}

struct SaveReadLikesResponse: Decodable {
    public let like: LikeStatus
}

struct CreateTopicGroupResponse: Decodable {
    public let myTopicGroup: TopicGroup
    public let myTopics: MyTopics
    
    public struct MyTopics: Decodable {
        public let myTopic: MyTopic
    }
}

struct UpdateTopicGroupResponse: Decodable {
    public let myTopicGroup: TopicGroup
}

struct GetMyTopicsResponse: Decodable {
    public let pinnedTopics: [MyTopic]
    public let myTopicGroups: [MyTopicGroup]
    public let joinedTopics: [MyTopic]
    public let favoritesOnboarding: Bool

    public struct MyTopic: Decodable, ClassInit {
        public let topic: Topic
        public let unread: Unread
        public let exTopicGroupId: TopicGroupID?
        public let createdAt: Date = Date()
    }
    
    public struct MyTopicGroup: Decodable, ClassInit {
        public let myTopicGroup: TopicGroup
        public let myTopics: [MyTopic]
    }
}

struct AddTopicToGroupResponse: Decodable {
    public let myTopic: MyTopic
}

struct DeleteMyTopicResponse: Decodable {
    public let myTopic: MyTopic
}

struct PinTopicResponse: Decodable {
    public let pinnedTopics: [PinnedTopic]
    
    public struct PinnedTopic: Decodable {
        public let myTopic: MyTopic
    }
}
