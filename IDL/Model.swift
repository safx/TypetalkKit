//
//  Model.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/13.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation

// MARK: - REST API

public enum MessageDirection: String, Decodable, Encodable {
    case backward = "backward"
    case forward  = "forward"
}

public enum AttachmentType: String, Decodable, Encodable {
    case small  = "small"
    case medium = "medium"
    case large  = "large"
}

public enum Scope: String, Decodable, Encodable {
    case my = "my"
    case topicRead = "topic.read"
    case topicPost = "topic.post"
    case topicWrite = "topic.write"
    case topicDelete = "topic.delete"
}

// MARK: - REST API

public struct Account: Decodable, ClassInit {
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

public struct AccountWithLoginStatus: Decodable, ClassInit {
    public let status: LoginStatus?
    public let account: Account
}

public struct AccountWithOnlineStatus: Decodable, ClassInit {
    public let account: Account
    public let online: Bool
}

public struct AccountWithMailAddress: Decodable, ClassInit {
    public let account: Account
    public let mailAddress: String?
}

public struct Attachment: Decodable, ClassInit {
    public let contentType: String? = nil
    public let fileKey: FileKey
    public let fileName: String
    public let fileSize: Int
}

public struct Bookmark: Decodable, ClassInit {
    public let postId: PostID = 0
    public let updatedAt: Date = Date()
}

struct DirectMessageTopic: Decodable, ClassInit {
    let topic: Topic
    let unread: Unread
    let directMessage: AccountWithLoginStatus
}

public struct Group: Decodable, ClassInit {
    public let id: GroupID
    public let key: GroupKey = ""
    public let name: String = ""
    public let suggestion: String = ""
    public let imageUrl: URL = URL(string: "INVALID")!
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
}

public struct GroupWithCount: Decodable, ClassInit {
    public let group: Group
    public let memberCount: Int
}

public struct Like: Decodable, ClassInit {
    public let id: LikeID
    public let postId: PostID
    public let topicId: TopicID
    public let comment: String?
    public let account: Account?
    public let createdAt: Date?
}

public struct Link: Decodable, ClassInit {
    public let id: LinkID
    public let url: URL
    public let contentType: String
    public let title: String
    public let description: String
    public let imageUrl: URL?
    public let createdAt: Date
    public let updatedAt: Date
    public let embed: JSON? = nil
}

public struct LoginStatus: Decodable, ClassInit {
    public let mobile: String?
    public let web: String?
    public let presence: String
}

public struct Member: Decodable, ClassInit {
    public let account: Account
    public let role: String
}

public struct Mention: Decodable, ClassInit {
    public let id: MentionID = 0
    public let readAt: Date? = nil
    public let post: Post?
}

public struct Notifications: Decodable, ClassInit {
    public let mentions: [Mention]? = nil
    public let invites: Invites

    public struct Invites: Decodable, ClassInit {
        public let teams: [TeamInvite]? = nil
        public let topics: [TopicInvite]? = nil
    }
}

public struct NotificationStatus: Decodable, ClassInit {
    public let mention: Mention?
    public let access: Access?
    public let invite: Invite?
    public let like: Like?
    public let directMessage: DirectMessage?

    public struct Mention: Decodable, ClassInit {
        public let unread: Int?
    }
    public struct Access: Decodable, ClassInit {
        public let unopened: Int?
    }
    public struct Invite: Decodable, ClassInit {
        public let team: PendingCount?
        public let topic: PendingCount?

        public struct PendingCount: Decodable, ClassInit {
            public let pending: Int?
        }
    }
    public struct Like: Decodable, ClassInit {
        public let receive: Int?
    }
    public struct DirectMessage: Decodable, ClassInit {
        public let unreadTopics: Int?
    }
}

// Using `class` allows us to use recursive value `Mention`
open class Post: Decodable, ClassInit {
    open let id: PostID = 0
    open let topicId: TopicID = 0
    open let topic: Topic?    // Non-nil from Mention
    open let replyTo: PostID?
    open let message: String = ""
    open let account: Account = Account()
    open let mention: Mention? = nil
    open let attachments: [URLAttachment]? = nil
    open let likes: [Like]? = nil
    open let talks: [Talk]? = nil
    open let links: [Link]? = nil
    open let createdAt: Date = Date()
    open let updatedAt: Date = Date()
}

public struct Talk: Decodable, ClassInit {
    public let id: TalkID
    public let topicId: TopicID
    public let name: String
    public let suggestion: String
    public let createdAt: Date
    public let updatedAt: Date
    public let backlog: String?
}

/*public struct TalkMessages: Decodable, ClassInit {
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post]? = nil
    public let hasNext: Bool
}*/

public struct Team: Decodable, ClassInit {
    public let id: TeamID = 0
    public let name: String = ""
    public let imageUrl: URL = URL(string: "INVALID")!
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
}

public struct TeamWithMembers: Decodable, ClassInit {
    public let team: Team
    public let members: [Member]? = nil
}

public struct TeamWithCount: Decodable, ClassInit {
    public let team: Team
    public let memberCount: Int
}

public struct TeamInvite: Decodable, ClassInit {
    public let id: InviteID
    public let sender: Account?
    public let account: Account?
    public let message: String = ""
    public let createdAt: Date?
    public let updatedAt: Date?

    public let mailAddress: String?
    public let status: String? = nil

    public let team: Team
    public let role: String?
}

public struct Thumbnail: Decodable, ClassInit {
    public let type: AttachmentType
    public let fileSize: Int
    public let width: Int
    public let height: Int
}

public struct Topic: Decodable, ClassInit {
    public let id: TopicID = 0
    public let name: String = ""
    public let description: String? = nil
    public let suggestion: String = ""
    public let lastPostedAt: Date? = nil
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
    public let isDirectMessage: Bool?
}

public struct TopicWithAccounts: Decodable, ClassInit {
    public let topic: Topic
    public let mySpace: Space?
    public let teams: [TeamWithMembers]? = nil
    public let groups: [GroupWithCount]? = nil
    public let accounts: [Account]? = nil
    public let invitingAccounts: [Account]? = nil
    public let invites: [TopicInvite]? = nil
    public let accountsForApi: [Account]? = nil
    public let integrations: [Account]? = nil
    public let remainingInvitations: Bool? // FIXME
}

public struct TopicWithUserInfo: Decodable, ClassInit {
    public let topic: Topic
    public let favorite: Bool
    public let unread: Unread?
}

public struct TopicInvite: Decodable, ClassInit {
    public let id: InviteID
    public let sender: Account?
    public let account: Account?
    public let message: String = ""
    public let createdAt: Date?
    public let updatedAt: Date?

    public let mailAddress: String?
    public let topic: Topic?
}

public struct PaymentPlan: Decodable, ClassInit {
    public let plan: PlanInfo
    public let enabled: Bool
    public let trial: TrialInfo?
    public let numberOfUsers: Int
    public let totalAttachmentSize: Int
    public let createdAt: Date = Date()
    public let updatedAt: Date = Date()
}

public struct PlanInfo: Decodable, ClassInit {
    public let key: String
    public let name: String
    public let limitNumberOfUsers: Int
    public let limitTotalAttachmentSize: Int
}

public struct Space: Decodable, ClassInit {
    public let space: SpaceInfo
    public let myRole: String
    public let isPaymentAdmin: Bool
    public let myPlan: PaymentPlan
}

public struct SpaceInfo: Decodable, ClassInit {
    public let key: SpaceKey
    public let name: String
    public let enabled: Bool
    public let imageUrl: URL
}

public struct TrialInfo: Decodable, ClassInit {
    public let endDate: String
    public let daysLeft: Int
}

public struct Unread: Decodable, ClassInit {
    public let topicId: TopicID
    public let postId: PostID
    public let count: Int
}

public struct URLAttachment: Decodable, ClassInit {
    public let attachment: Attachment
    public let webUrl: URL
    public let apiUrl: URL
    public let thumbnails: [Thumbnail]? = nil
}

// MARK: - Event

public struct TalkPost: Decodable, ClassInit {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID]? = nil
}

public struct PostLinksEvent: Decodable, ClassInit {
    public let postId: PostID
    public let links: [Link]? = nil
}
