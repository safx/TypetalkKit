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

public struct GetTopicsResponse: JSONDecodable {
    public let topics: [TopicWithUserInfo]
}

public struct GetMessagesResponse: JSONDecodable, ClassInit {
    public let team: Team = Team()
    public let topic: Topic = Topic()
    public let bookmark: Bookmark = Bookmark()
    public let posts: [Post] = []
    public let hasNext: Bool = false
    public let exceedsAttachmentLimit: Bool = false
}

public struct PostMessageResponse: JSONDecodable {
    public let topic: Topic?
    public let post: Post?
}

public struct GetTopicMembersResponse: JSONDecodable {
    public let accounts: [AccountWithOnlineStatus] = []
    public let pendings: [AccountWithMailAddress] = []
}

public struct GetMessageResponse: JSONDecodable {
    public let team: Team
    public let topic: Topic
    public let post: Post
    public let replies: [Post] = []
}

public struct LikeMessageResponse: JSONDecodable {
    public let like: Like
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

public struct AcceptTeamInviteResponse: JSONDecodable {
    public let topics: [Topic] = []
    public let invite: Invite? //TeamInvite?
}

public struct DeclineTeamInviteResponse: JSONDecodable {
    public let invite: Invite? //TeamInvite?
}

public struct AcceptTopicInviteResponse: JSONDecodable {
    public let invite: Invite //TopicInvite
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

public struct CreateTalkResponse: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID]
}

public struct UpdateTalkResponse: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
}
