//
//  Model.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/13.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation

// MARK: - REST API

public enum MessageDirection: String, JSONDecodable, JSONEncodable {
    case Backward = "backward"
    case Forward  = "forward"
}

public enum AttachmentType: String, JSONDecodable, JSONEncodable {
    case Small  = "small"
    case Medium = "medium"
    case Large  = "large"
}

public enum Scope: String, JSONDecodable, JSONEncodable {
    case my = "my"
    case topic_read = "topic.read"
    case topic_post = "topic.post"
    case topic_write = "topic.write"
    case topic_delete = "topic.delete"
}

// MARK: - REST API

public struct Account: JSONDecodable, ClassInit {
    public let id: AccountID = 0
    public let name: String = ""
    public let fullName: String = ""
    public let suggestion: String = ""
    public let imageUrl: URL = URL(string: "INVALID")!
    public let imageUpdatedAt: Date?
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
    public let isBot: Bool?
    public let mailAddress: String?
}

public struct AccountWithLoginStatus: JSONDecodable, ClassInit {
    public let status: LoginStatus?
    public let account: Account
}

public struct AccountWithOnlineStatus: JSONDecodable, ClassInit {
    public let account: Account
    public let online: Bool
}

public struct AccountWithMailAddress: JSONDecodable, ClassInit {
    public let account: Account
    public let mailAddress: String?
}

public struct Attachment: JSONDecodable, ClassInit {
    public let contentType: String = ""
    public let fileKey: FileKey
    public let fileName: String
    public let fileSize: Int
}

public struct Bookmark: JSONDecodable, ClassInit {
    public let postId: PostID = 0
    public let updatedAt: Date = Date()
}

struct DirectMessageTopic: JSONDecodable, ClassInit {
    let topic: Topic
    let unread: Unread
    let directMessage: AccountWithLoginStatus
}

public struct Embed: JSONDecodable, ClassInit {
    public let type: String
    public let version: Int
    public let providerName: String // JSON:"provider_name"
    public let providerUrl: URL?    // JSON:"provider_url"
    public let title: String
    public let authorName: String   // JSON:"author_name"
    public let authorUrl: URL?      // JSON:"author_url"
    public let html: String
    public let width: Int
    public let height: Int
}

public struct Group: JSONDecodable, ClassInit {
    public let id: GroupID
    public let key: GroupKey = ""
    public let name: String = ""
    public let suggestion: String = ""
    public let imageUrl: URL = URL(string: "INVALID")!
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
}

public struct GroupWithCount: JSONDecodable, ClassInit {
    public let group: Group
    public let memberCount: Int
}

public struct Like: JSONDecodable, ClassInit {
    public let id: LikeID
    public let postId: PostID
    public let topicId: TopicID
    public let comment: String?
    public let account: Account?
    public let createdAt: Date?
}

public struct Link: JSONDecodable, ClassInit {
    public let id: LinkID
    public let url: URL
    public let contentType: String
    public let title: String
    public let description: String
    public let imageUrl: URL
    public let createdAt: Date
    public let updatedAt: Date
    public let embed: Embed?
}

public struct LoginStatus: JSONDecodable, ClassInit {
    public let mobile: String?
    public let web: String?
    public let presence: String
}

public struct Member: JSONDecodable, ClassInit {
    public let account: Account
    public let role: String
}

public struct Mention: JSONDecodable, ClassInit {
    public let id: MentionID = 0
    public let readAt: Date? = nil
    public let post: Post?
}

public struct Notifications: JSONDecodable, ClassInit {
    public let mentions: [Mention] = []
    public let invites: Invites

    public struct Invites: JSONDecodable, ClassInit {
        public let teams: [TeamInvite] = []
        public let topics: [TopicInvite] = []
    }
}

public struct NotificationStatus: JSONDecodable, ClassInit {
    public let mention: Mention?
    public let access: Access?
    public let invite: Invite?
    public let like: Like?
    public let directMessage: DirectMessage?

    public struct Mention: JSONDecodable, ClassInit {
        public let unread: Int?
    }
    public struct Access: JSONDecodable, ClassInit {
        public let unopened: Int?
    }
    public struct Invite: JSONDecodable, ClassInit {
        public let team: PendingCount?
        public let topic: PendingCount?

        public struct PendingCount: JSONDecodable, ClassInit {
            public let pending: Int?
        }
    }
    public struct Like: JSONDecodable, ClassInit {
        public let receive: Int?
    }
    public struct DirectMessage: JSONDecodable, ClassInit {
        public let unreadTopics: Int?
    }
}

// Using `class` allows us to use recursive value `Mention`
open class Post: JSONDecodable, ClassInit {
    open let id: PostID = 0
    open let topicId: TopicID = 0
    open let topic: Topic?    // Non-nil from Mention
    open let replyTo: PostID?
    open let message: String = ""
    open let account: Account = Account()
    open let mention: Mention? = nil
    open let attachments: [URLAttachment] = []
    open let likes: [Like] = []
    open let talks: [Talk] = []
    open let links: [Link] = []
    open let createdAt: Date = Date()
    open let updatedAt: Date = Date()
}

public struct Talk: JSONDecodable, ClassInit {
    public let id: TalkID
    public let topicId: TopicID
    public let name: String
    public let suggestion: String
    public let createdAt: Date
    public let updatedAt: Date
    public let backlog: String?
}

/*public struct TalkMessages: JSONDecodable, ClassInit {
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post] = []
    public let hasNext: Bool
}*/

public struct Team: JSONDecodable, ClassInit {
    public let id: TeamID = 0
    public let name: String = ""
    public let imageUrl: URL = URL(string: "INVALID")!
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
}

public struct TeamWithMembers: JSONDecodable, ClassInit {
    public let team: Team
    public let members: [Member] = []
}

public struct TeamWithCount: JSONDecodable, ClassInit {
    public let team: Team
    public let memberCount: Int
}

public struct TeamInvite: JSONDecodable, ClassInit {
    public let id: InviteID
    public let sender: Account?
    public let account: Account?
    public let message: String = ""
    public let createdAt: Date?
    public let updatedAt: Date?
    
    public let mailAddress: String?
    public let status: String = ""
    
    public let team: Team
    public let role: String?
}

public struct Thumbnail: JSONDecodable, ClassInit {
    public let type: AttachmentType
    public let fileSize: Int
    public let width: Int
    public let height: Int
}

public struct Topic: JSONDecodable, ClassInit {
    public let id: TopicID = 0
    public let name: String = ""
    public let description: String = ""
    public let suggestion: String = ""
    public let lastPostedAt: Date? = nil
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
    public let isDirectMessage: Bool?
}

public struct TopicWithAccounts: JSONDecodable, ClassInit {
    public let topic: Topic
    public let mySpace: Space?
    public let teams: [TeamWithMembers] = []
    public let groups: [GroupWithCount] = []
    public let accounts: [Account] = []
    public let invitingAccounts: [Account] = []
    public let invites: [TopicInvite] = []
    public let accountsForApi: [Account] = []
    public let integrations: [Account] = []
    public let remainingInvitations: Bool? // FIXME
}

public struct TopicWithUserInfo: JSONDecodable, ClassInit {
    public let topic: Topic
    public let favorite: Bool
    public let unread: Unread?
}

public struct TopicInvite: JSONDecodable, ClassInit {
    public let id: InviteID
    public let sender: Account?
    public let account: Account?
    public let message: String = ""
    public let createdAt: Date?
    public let updatedAt: Date?
    
    public let mailAddress: String?
    public let topic: Topic?
}

public struct PaymentPlan: JSONDecodable, ClassInit {
    public let plan: PlanInfo
    public let enabled: Bool
    public let trial: TrialInfo?
    public let numberOfUsers: Int
    public let totalAttachmentSize: Int
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
}

public struct PlanInfo: JSONDecodable, ClassInit {
    public let key: String
    public let name: String
    public let limitNumberOfUsers: Int
    public let limitTotalAttachmentSize: Int
}

public struct Space: JSONDecodable, ClassInit {
    public let space: SpaceInfo
    public let myRole: String
    public let isPaymentAdmin: Bool
    public let myPlan: PaymentPlan
}

public struct SpaceInfo: JSONDecodable, ClassInit {
    public let key: SpaceKey
    public let name: String
    public let enabled: Bool
    public let imageUrl: URL
}

public struct TrialInfo: JSONDecodable, ClassInit {
    public let endDate: String
    public let daysLeft: Int
}

public struct Unread: JSONDecodable, ClassInit {
    public let topicId: TopicID
    public let postId: PostID
    public let count: Int
}

public struct URLAttachment: JSONDecodable, ClassInit {
    public let attachment: Attachment
    public let webUrl: URL
    public let apiUrl: URL
    public let thumbnails: [Thumbnail] = []
}

// MARK: - Event

public struct TalkPost: JSONDecodable, ClassInit {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID] = []
}

public struct PostLinksEvent: JSONDecodable, ClassInit {
    public let postId: PostID
    public let links: [Link] = []
}
