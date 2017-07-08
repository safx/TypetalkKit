//
//  Response.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/07/17.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation

public struct GetProfileResponse: JSONDecodable {
    public let account: Account
}

public struct GetOnlineStatusResponse: JSONDecodable {
    let accounts: [AccountWithLoginStatus]
}

public struct GetTopicsResponse: JSONDecodable {
    public let topics: [TopicWithUserInfo]
}

public struct GetMessagesResponse: JSONDecodable, ClassInit {
    public let mySpace: Space?
    public let team: Team? = nil
    public let topic: Topic = Topic()
    public let bookmark: Bookmark = Bookmark()
    public let posts: [Post] = []
    public let hasNext: Bool = false
    public let exceedsAttachmentLimit: Bool = false
}

public struct PostMessageResponse: JSONDecodable {
    public let topic: Topic?
    public let post: Post?
    public let mentions: [Mention] = []
    public let exceedsAttachmentLimit: Bool = false
}

public struct GetTopicMembersResponse: JSONDecodable {
    public let accounts: [AccountWithOnlineStatus] = []
    public let pendings: [AccountWithMailAddress] = []
}

public struct GetMessageResponse: JSONDecodable {
    public let mySpace: Space?
    public let team: Team? = nil
    public let topic: Topic
    public let post: Post
    public let replies: [Post] = []
    public let exceedsAttachmentLimit: Bool = false
}

public struct LikeMessageResponse: JSONDecodable {
    public let like: Like
    public let topic: Topic?
    public let directMessage: DirectMessageTopic?
    public let post: Post?
}

public struct FavoriteTopicResponse: JSONDecodable {
    public let topic: Topic
    public let favorite: Bool
}

public struct GetDirectMessagesResponse: JSONDecodable, ClassInit {
    public let topic: Topic
    public let directMessage: AccountWithLoginStatus
    public let bookmark: Bookmark
    public let postsk: [Post] = []
    public let hasNext: Bool
}

public struct PostDirectMessageResponse: JSONDecodable, ClassInit {
    public let topic: Topic
    public let directMessage: AccountWithLoginStatus
    public let mentions: [Mention]
    public let post: Post
    public let exceedsAttachmentLimit: Bool
}

public struct SaveReadTopicResponse: JSONDecodable {
    public let unread: Unread
}

public struct GetMentionsResponse: JSONDecodable {
    public let mentions: [Mention]
}

public struct SaveReadMentionResponse: JSONDecodable {
    public let mention: Mention
}

public struct GetSpacesResponse: JSONDecodable {
    public let mySpaces: [Space]
}

public struct GetSpaceMembersResponse: JSONDecodable {
    public let accounts: [Account]
    public let groups: [GroupWithCount]
}

public struct GetTeamsResponse: JSONDecodable {
    public let teams: [TeamWithCount]
}

public struct GetFriendsResponse: JSONDecodable {
    public let accounts: [Account]
}

public struct GetTalksResponse: JSONDecodable {
    public let talks: [Talk]
}

public struct GetTalkResponse: JSONDecodable, ClassInit {
    public let mySpace: Space?
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post] = []
    public let hasNext: Bool
}

public struct CreateTalkResponse: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID]
}

public struct UpdateTalkResponse: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
}
