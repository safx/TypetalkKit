// This file was auto-generated from Model.swift with swift-idl.

import Foundation


public enum MessageDirection: String, Encodable, Decodable {
	case backward = "backward"
	case forward = "forward"
}

public enum AttachmentType: String, Encodable, Decodable {
	case small = "small"
	case medium = "medium"
	case large = "large"
}

public enum Scope: String, Encodable, Decodable {
	case my = "my"
	case topicRead = "topic.read"
	case topicPost = "topic.post"
	case topicWrite = "topic.write"
	case topicDelete = "topic.delete"
}

public struct Account: Decodable {
	public let id: Int
	public let name: String
	public let fullName: String
	public let suggestion: String
	public let imageUrl: URL
	public let imageUpdatedAt: Date?
	public let createdAt: Date
	public let updatedAt: Date
	public let isBot: Bool?
	public let mailAddress: String?


	public init(id: Int = 0, name: String = "", fullName: String = "", suggestion: String = "", imageUrl: URL = URL(string: "INVALID")!, imageUpdatedAt: Date? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), isBot: Bool? = nil, mailAddress: String? = nil) {
		self.id = id
		self.name = name
		self.fullName = fullName
		self.suggestion = suggestion
		self.imageUrl = imageUrl
		self.imageUpdatedAt = imageUpdatedAt
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.isBot = isBot
		self.mailAddress = mailAddress
	}
}

public struct AccountWithLoginStatus: Decodable {
	public let status: LoginStatus?
	public let account: Account


	public init(status: LoginStatus? = nil, account: Account) {
		self.status = status
		self.account = account
	}
}

public struct AccountWithOnlineStatus: Decodable {
	public let account: Account
	public let online: Bool


	public init(account: Account, online: Bool) {
		self.account = account
		self.online = online
	}
}

public struct AccountWithMailAddress: Decodable {
	public let account: Account
	public let mailAddress: String?


	public init(account: Account, mailAddress: String? = nil) {
		self.account = account
		self.mailAddress = mailAddress
	}
}

public struct Attachment: Decodable {
	public let contentType: String
	public let fileKey: String
	public let fileName: String
	public let fileSize: Int


	public init(contentType: String = "", fileKey: String, fileName: String, fileSize: Int) {
		self.contentType = contentType
		self.fileKey = fileKey
		self.fileName = fileName
		self.fileSize = fileSize
	}
}

public struct Bookmark: Decodable {
	public let postId: Int
	public let updatedAt: Date


	public init(postId: Int = 0, updatedAt: Date = Date()) {
		self.postId = postId
		self.updatedAt = updatedAt
	}
}

public struct DirectMessageTopic: Decodable {
	public let topic: Topic
	public let unread: Unread
	public let directMessage: AccountWithLoginStatus


	public init(topic: Topic, unread: Unread, directMessage: AccountWithLoginStatus) {
		self.topic = topic
		self.unread = unread
		self.directMessage = directMessage
	}
}

public struct Embed: Decodable {
	public let type: String
	public let version: Int
	public let providerName: String // json:"provider_name"
	public let providerUrl: URL? // json:"provider_url"
	public let title: String
	public let authorName: String // json:"author_name"
	public let authorUrl: URL? // json:"author_url"
	public let html: String
	public let width: Int
	public let height: Int

	private enum CodingKeys: String, CodingKey {
		case type
		case version
		case providerName = "provider_name"
		case providerUrl = "provider_url"
		case title
		case authorName = "author_name"
		case authorUrl = "author_url"
		case html
		case width
		case height
	}

	public init(type: String, version: Int, providerName: String, providerUrl: URL? = nil, title: String, authorName: String, authorUrl: URL? = nil, html: String, width: Int, height: Int) {
		self.type = type
		self.version = version
		self.providerName = providerName
		self.providerUrl = providerUrl
		self.title = title
		self.authorName = authorName
		self.authorUrl = authorUrl
		self.html = html
		self.width = width
		self.height = height
	}
}

public struct Group: Decodable {
	public let id: Int
	public let key: String
	public let name: String
	public let suggestion: String
	public let imageUrl: URL
	public let createdAt: Date
	public let updatedAt: Date


	public init(id: Int, key: String = "", name: String = "", suggestion: String = "", imageUrl: URL = URL(string: "INVALID")!, createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.id = id
		self.key = key
		self.name = name
		self.suggestion = suggestion
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct GroupWithCount: Decodable {
	public let group: Group
	public let memberCount: Int


	public init(group: Group, memberCount: Int) {
		self.group = group
		self.memberCount = memberCount
	}
}

public struct Like: Decodable {
	public let id: Int
	public let postId: Int
	public let topicId: Int
	public let comment: String?
	public let account: Account?
	public let createdAt: Date?


	public init(id: Int, postId: Int, topicId: Int, comment: String? = nil, account: Account? = nil, createdAt: Date? = nil) {
		self.id = id
		self.postId = postId
		self.topicId = topicId
		self.comment = comment
		self.account = account
		self.createdAt = createdAt
	}
}

public struct Link: Decodable {
	public let id: Int
	public let url: URL
	public let contentType: String
	public let title: String
	public let description: String
	public let imageUrl: URL
	public let createdAt: Date
	public let updatedAt: Date
	public let embed: Embed?


	public init(id: Int, url: URL, contentType: String, title: String, description: String, imageUrl: URL, createdAt: Date, updatedAt: Date, embed: Embed? = nil) {
		self.id = id
		self.url = url
		self.contentType = contentType
		self.title = title
		self.description = description
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.embed = embed
	}
}

public struct LoginStatus: Decodable {
	public let mobile: String?
	public let web: String?
	public let presence: String


	public init(mobile: String? = nil, web: String? = nil, presence: String) {
		self.mobile = mobile
		self.web = web
		self.presence = presence
	}
}

public struct Member: Decodable {
	public let account: Account
	public let role: String


	public init(account: Account, role: String) {
		self.account = account
		self.role = role
	}
}

public struct Mention: Decodable {
	public let id: Int
	public let readAt: Date?
	public let post: Post?


	public init(id: Int = 0, readAt: Date? = nil, post: Post? = nil) {
		self.id = id
		self.readAt = readAt
		self.post = post
	}
}

public struct Notifications: Decodable {
	public let mentions: [Mention]
	public let invites: Notifications.Invites


	public init(mentions: [Mention] = [], invites: Notifications.Invites) {
		self.mentions = mentions
		self.invites = invites
	}

	public struct Invites: Decodable {
		public let teams: [TeamInvite]
		public let topics: [TopicInvite]


		public init(teams: [TeamInvite] = [], topics: [TopicInvite] = []) {
			self.teams = teams
			self.topics = topics
		}
	}
}

public struct NotificationStatus: Decodable {
	public let mention: NotificationStatus.Mention?
	public let access: NotificationStatus.Access?
	public let invite: NotificationStatus.Invite?
	public let like: NotificationStatus.Like?
	public let directMessage: NotificationStatus.DirectMessage?


	public init(mention: NotificationStatus.Mention? = nil, access: NotificationStatus.Access? = nil, invite: NotificationStatus.Invite? = nil, like: NotificationStatus.Like? = nil, directMessage: NotificationStatus.DirectMessage? = nil) {
		self.mention = mention
		self.access = access
		self.invite = invite
		self.like = like
		self.directMessage = directMessage
	}

	public struct Mention: Decodable {
		public let unread: Int?


		public init(unread: Int? = nil) {
			self.unread = unread
		}
	}

	public struct Access: Decodable {
		public let unopened: Int?


		public init(unopened: Int? = nil) {
			self.unopened = unopened
		}
	}

	public struct Invite: Decodable {
		public let team: NotificationStatus.Invite.PendingCount?
		public let topic: NotificationStatus.Invite.PendingCount?


		public init(team: NotificationStatus.Invite.PendingCount? = nil, topic: NotificationStatus.Invite.PendingCount? = nil) {
			self.team = team
			self.topic = topic
		}

		public struct PendingCount: Decodable {
			public let pending: Int?


			public init(pending: Int? = nil) {
				self.pending = pending
			}
		}
	}

	public struct Like: Decodable {
		public let receive: Int?


		public init(receive: Int? = nil) {
			self.receive = receive
		}
	}

	public struct DirectMessage: Decodable {
		public let unreadTopics: Int?


		public init(unreadTopics: Int? = nil) {
			self.unreadTopics = unreadTopics
		}
	}
}

public class Post: Decodable {
	public let id: Int
	public let topicId: Int
	public let topic: Topic?
	public let replyTo: Int?
	public let message: String
	public let account: Account
	public let mention: Mention?
	public let attachments: [URLAttachment]
	public let likes: [Like]
	public let talks: [Talk]
	public let links: [Link]
	public let createdAt: Date
	public let updatedAt: Date


	public init(id: Int = 0, topicId: Int = 0, topic: Topic? = nil, replyTo: Int? = nil, message: String = "", account: Account = Account(), mention: Mention? = nil, attachments: [URLAttachment] = [], likes: [Like] = [], talks: [Talk] = [], links: [Link] = [], createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.id = id
		self.topicId = topicId
		self.topic = topic
		self.replyTo = replyTo
		self.message = message
		self.account = account
		self.mention = mention
		self.attachments = attachments
		self.likes = likes
		self.talks = talks
		self.links = links
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct Talk: Decodable {
	public let id: Int
	public let topicId: Int
	public let name: String
	public let suggestion: String
	public let createdAt: Date
	public let updatedAt: Date
	public let backlog: String?


	public init(id: Int, topicId: Int, name: String, suggestion: String, createdAt: Date, updatedAt: Date, backlog: String? = nil) {
		self.id = id
		self.topicId = topicId
		self.name = name
		self.suggestion = suggestion
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.backlog = backlog
	}
}

public struct Team: Decodable {
	public let id: Int
	public let name: String
	public let imageUrl: URL
	public let createdAt: Date
	public let updatedAt: Date


	public init(id: Int = 0, name: String = "", imageUrl: URL = URL(string: "INVALID")!, createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.id = id
		self.name = name
		self.imageUrl = imageUrl
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct TeamWithMembers: Decodable {
	public let team: Team
	public let members: [Member]


	public init(team: Team, members: [Member] = []) {
		self.team = team
		self.members = members
	}
}

public struct TeamWithCount: Decodable {
	public let team: Team
	public let memberCount: Int


	public init(team: Team, memberCount: Int) {
		self.team = team
		self.memberCount = memberCount
	}
}

public struct TeamInvite: Decodable {
	public let id: Int
	public let sender: Account?
	public let account: Account?
	public let message: String
	public let createdAt: Date?
	public let updatedAt: Date?
	public let mailAddress: String?
	public let status: String
	public let team: Team
	public let role: String?


	public init(id: Int, sender: Account? = nil, account: Account? = nil, message: String = "", createdAt: Date? = nil, updatedAt: Date? = nil, mailAddress: String? = nil, status: String = "", team: Team, role: String? = nil) {
		self.id = id
		self.sender = sender
		self.account = account
		self.message = message
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.mailAddress = mailAddress
		self.status = status
		self.team = team
		self.role = role
	}
}

public struct Thumbnail: Decodable {
	public let type: AttachmentType
	public let fileSize: Int
	public let width: Int
	public let height: Int


	public init(type: AttachmentType, fileSize: Int, width: Int, height: Int) {
		self.type = type
		self.fileSize = fileSize
		self.width = width
		self.height = height
	}
}

public struct Topic: Decodable {
	public let id: Int
	public let name: String
	public let description: String
	public let suggestion: String
	public let lastPostedAt: Date?
	public let createdAt: Date
	public let updatedAt: Date
	public let isDirectMessage: Bool?


	public init(id: Int = 0, name: String = "", description: String = "", suggestion: String = "", lastPostedAt: Date? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), isDirectMessage: Bool? = nil) {
		self.id = id
		self.name = name
		self.description = description
		self.suggestion = suggestion
		self.lastPostedAt = lastPostedAt
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.isDirectMessage = isDirectMessage
	}
}

public struct TopicWithAccounts: Decodable {
	public let topic: Topic
	public let mySpace: Space?
	public let teams: [TeamWithMembers]
	public let groups: [GroupWithCount]
	public let accounts: [Account]
	public let invitingAccounts: [Account]
	public let invites: [TopicInvite]
	public let accountsForApi: [Account]
	public let integrations: [Account]
	public let remainingInvitations: Bool?


	public init(topic: Topic, mySpace: Space? = nil, teams: [TeamWithMembers] = [], groups: [GroupWithCount] = [], accounts: [Account] = [], invitingAccounts: [Account] = [], invites: [TopicInvite] = [], accountsForApi: [Account] = [], integrations: [Account] = [], remainingInvitations: Bool? = nil) {
		self.topic = topic
		self.mySpace = mySpace
		self.teams = teams
		self.groups = groups
		self.accounts = accounts
		self.invitingAccounts = invitingAccounts
		self.invites = invites
		self.accountsForApi = accountsForApi
		self.integrations = integrations
		self.remainingInvitations = remainingInvitations
	}
}

public struct TopicWithUserInfo: Decodable {
	public let topic: Topic
	public let favorite: Bool
	public let unread: Unread?


	public init(topic: Topic, favorite: Bool, unread: Unread? = nil) {
		self.topic = topic
		self.favorite = favorite
		self.unread = unread
	}
}

public struct TopicInvite: Decodable {
	public let id: Int
	public let sender: Account?
	public let account: Account?
	public let message: String
	public let createdAt: Date?
	public let updatedAt: Date?
	public let mailAddress: String?
	public let topic: Topic?


	public init(id: Int, sender: Account? = nil, account: Account? = nil, message: String = "", createdAt: Date? = nil, updatedAt: Date? = nil, mailAddress: String? = nil, topic: Topic? = nil) {
		self.id = id
		self.sender = sender
		self.account = account
		self.message = message
		self.createdAt = createdAt
		self.updatedAt = updatedAt
		self.mailAddress = mailAddress
		self.topic = topic
	}
}

public struct PaymentPlan: Decodable {
	public let plan: PlanInfo
	public let enabled: Bool
	public let trial: TrialInfo?
	public let numberOfUsers: Int
	public let totalAttachmentSize: Int
	public let createdAt: Date
	public let updatedAt: Date


	public init(plan: PlanInfo, enabled: Bool, trial: TrialInfo? = nil, numberOfUsers: Int, totalAttachmentSize: Int, createdAt: Date = Date(), updatedAt: Date = Date()) {
		self.plan = plan
		self.enabled = enabled
		self.trial = trial
		self.numberOfUsers = numberOfUsers
		self.totalAttachmentSize = totalAttachmentSize
		self.createdAt = createdAt
		self.updatedAt = updatedAt
	}
}

public struct PlanInfo: Decodable {
	public let key: String
	public let name: String
	public let limitNumberOfUsers: Int
	public let limitTotalAttachmentSize: Int


	public init(key: String, name: String, limitNumberOfUsers: Int, limitTotalAttachmentSize: Int) {
		self.key = key
		self.name = name
		self.limitNumberOfUsers = limitNumberOfUsers
		self.limitTotalAttachmentSize = limitTotalAttachmentSize
	}
}

public struct Space: Decodable {
	public let space: SpaceInfo
	public let myRole: String
	public let isPaymentAdmin: Bool
	public let myPlan: PaymentPlan


	public init(space: SpaceInfo, myRole: String, isPaymentAdmin: Bool, myPlan: PaymentPlan) {
		self.space = space
		self.myRole = myRole
		self.isPaymentAdmin = isPaymentAdmin
		self.myPlan = myPlan
	}
}

public struct SpaceInfo: Decodable {
	public let key: String
	public let name: String
	public let enabled: Bool
	public let imageUrl: URL


	public init(key: String, name: String, enabled: Bool, imageUrl: URL) {
		self.key = key
		self.name = name
		self.enabled = enabled
		self.imageUrl = imageUrl
	}
}

public struct TrialInfo: Decodable {
	public let endDate: String
	public let daysLeft: Int


	public init(endDate: String, daysLeft: Int) {
		self.endDate = endDate
		self.daysLeft = daysLeft
	}
}

public struct Unread: Decodable {
	public let topicId: Int
	public let postId: Int
	public let count: Int


	public init(topicId: Int, postId: Int, count: Int) {
		self.topicId = topicId
		self.postId = postId
		self.count = count
	}
}

public struct URLAttachment: Decodable {
	public let attachment: Attachment
	public let webUrl: URL
	public let apiUrl: URL
	public let thumbnails: [Thumbnail]


	public init(attachment: Attachment, webUrl: URL, apiUrl: URL, thumbnails: [Thumbnail] = []) {
		self.attachment = attachment
		self.webUrl = webUrl
		self.apiUrl = apiUrl
		self.thumbnails = thumbnails
	}
}

public struct TalkPost: Decodable {
	public let topic: Topic
	public let talk: Talk
	public let postIds: [Int]


	public init(topic: Topic, talk: Talk, postIds: [Int] = []) {
		self.topic = topic
		self.talk = talk
		self.postIds = postIds
	}
}

public struct PostLinksEvent: Decodable {
	public let postId: Int
	public let links: [Link]


	public init(postId: Int, links: [Link] = []) {
		self.postId = postId
		self.links = links
	}
}

