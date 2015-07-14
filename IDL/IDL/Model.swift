//
//  Model.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/13.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation

// MARK: - REST API

public enum MessageDirection: String, JSONDecodable {
    case Backward = "backward"
    case Forward  = "forward"
}

public enum AttachmentType: String, JSONDecodable {
    case Small  = "small"
    case Medium = "medium"
    case Large  = "large"
}

public enum Scope: String, JSONDecodable {
    case my = "my"
    case topic_read = "topic.read"
    case topic_post = "topic.post"
    case topic_write = "topic.write"
    case topic_delete = "topic.delete"
}

// MARK: - REST API

public struct Account: JSONDecodable {
    public let id: AccountID
    public let name: String
    public let fullName: String
    public let suggestion: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate
}

public struct AccountWithOnlineStatus: JSONDecodable {
    public let account: Account
    public let online: Bool
}

public struct AccountWithMailAddress: JSONDecodable {
    public let account: Account
    public let mailAddress: String?
}

public struct Attachment: JSONDecodable {
    public let contentType: String = ""
    public let fileKey: String
    public let fileName: String
    public let fileSize: Int
}

public struct Bookmark: JSONDecodable {
    public let postId: PostID
    public let updatedAt: NSDate
}

public struct Embed: JSONDecodable {
    public let type: String
    public let version: Float
    public let providerName: String // JSON:"provider_name"
    public let providerURL: NSURL?  // JSON:"provider_url"
    public let title: String
    public let authorName: String   // JSON:"author_name"
    public let authorURL: NSURL?    // JSON:"author_url"
    public let html: String
    public let width: Int
    public let height: Int
}

public struct Invite: JSONDecodable {
    public let id: InviteID
    public let sender: Account?
    public let account: Account?
    public let message: String = ""
    public let createdAt: NSDate?
    public let updatedAt: NSDate?

    public let mailAddress: String?
    public let status: String = ""
    public let topic: Topic?

    public let team: Team?
    public let role: String?
}

public struct Like: JSONDecodable {
    public let id: LikeID
    public let postId: PostID
    public let topicId: TopicID
    public let comment: String?
    public let account: Account?
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
}

public struct Member: JSONDecodable {
    public let account: Account
    public let role: String
}

public struct Mention: JSONDecodable {
    public let id: MentionID
    public let readAt: NSDate?
    public let post: Post?
}

public struct Notifications: JSONDecodable {
    public let mentions: [Mention] = []
    public let invites: Invites

    public struct Invites: JSONDecodable {
        public let teams: [Invite] = []  // TeamInvite
        public let topics: [Invite] = [] // TopicInvite
    }
}

public struct NotificationStatus: JSONDecodable {
    public let mention: Mention?
    public let access: Access?
    public let invite: Invite?

    public struct Mention: JSONDecodable {
        public let unread: Int?
    }

    public struct Access: JSONDecodable {
        public let unopened: Int?
    }

    public struct Invite: JSONDecodable {
        public let team: PendingCount?
        public let topic: PendingCount?

        public struct PendingCount: JSONDecodable {
            public let pending: Int?
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
    public let mention: String?
    public let attachments: [URLAttachment] = []
    public let likes: [Like] = []
    public let talks: [Talk] = []
    public let links: [Link] = []
    public let createdAt: NSDate
    public let updatedAt: NSDate
}

public struct Talk: JSONDecodable {
    public let id: TalkID
    public let topicId: TopicID
    public let name: String
    public let suggestion: String
    public let createdAt: NSDate
    public let updatedAt: NSDate
}

public struct TalkMessages: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post] = []
    public let hasNext: Bool
}

public struct Team: JSONDecodable {
    public let id: TeamID
    public let name: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate
}

public struct TeamWithMembers: JSONDecodable {
    public let team: Team
    public let members: [Member] = []
}

public struct TeamWithCount: JSONDecodable {
    public let team: Team
    public let memberCount: Int
}

public struct Thumbnail: JSONDecodable {
    public let type: AttachmentType
    public let fileSize: Int
    public let width: Int
    public let height: Int
}

public struct Topic: JSONDecodable {
    public let id: TopicID
    public let name: String
    public let suggestion: String
    public let lastPostedAt: NSDate?
    public let createdAt: NSDate
    public let updatedAt: NSDate
}

public struct TopicWithAccounts: JSONDecodable {
    public let topic: Topic
    public let teams: [TeamWithMembers] = []
    public let accounts: [Account] = []
    public let invites: [Invite] = [] //[TopicInvite]
}

public struct TopicWithUserInfo: JSONDecodable {
    public let topic: Topic
    public let favorite: Bool
    public let unread: Unread?
}

public struct Unread: JSONDecodable {
    public let topicId: TopicID
    public let postId: PostID
    public let count: Int
}

public struct URLAttachment: JSONDecodable {
    public let attachment: Attachment
    public let webUrl: NSURL
    public let apiUrl: NSURL
    public let thumbnails: [Thumbnail] = []
}

// MARK: - REST API Response

public struct GetProfileResponse: JSONDecodable {
    public let account: Account
}

public struct GetTopicsResponse: JSONDecodable {
    public let topics: [TopicWithUserInfo]
}

public struct GetMessagesResponse: JSONDecodable {
    public let team: Team
    public let topic: Topic
    public let bookmark: Bookmark
    public let posts: [Post] = []
    public let hasNext: Bool
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

// MARK: - Event

public struct TalkPost: JSONDecodable {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID] = []
}

public struct PostLinksEvent: JSONDecodable {
    public let postId: PostID
    public let links: [Link] = []
}
