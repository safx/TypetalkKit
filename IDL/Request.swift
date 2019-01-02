//
//  Request.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/15.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

class GetProfile: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/profile"
}

class GetFriendProfile: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/accounts/profile/\(accountName)"
    typealias APIKitResponse = AccountWithLoginStatus
    let accountName: String // Account name
}

class GetOnlineStatus: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/accounts/status"
    let accountIds: [AccountID] // Account ID (topic member only)   // TODO: check type (string or number?)
}

class GetTopics: ClassInit, APIKitHelper, TypetalkRequest { // router:",v2/topics"
    let spaceKey: String // Space key
}

class GetDmTopics: ClassInit, APIKitHelper, TypetalkRequest { // router:",v2/messages"
    let spaceKey: String // Space key
}

class GetMessages: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)"
    let topicId: TopicID                   // Topic ID
    let count: Int? = nil                  // default value: 20, maximum: 200
    let from: PostID? = nil                // references Post ID
    let direction: MessageDirection? = nil // “backward” or “forward”
}

class PostMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics/\(topicId),form"
    let topicId: TopicID                  // Topic ID
    let message: String                   // your message, (max 4000 characters)
    let replyTo: PostID? = nil            // references Post ID
    let showLinkMeta: Bool? = nil         // show OGP data of URL included in message. default value: true
    let fileKeys: [FileKey] = []          // attachment file key (refer to Upload attachment file), maximum count: 5
    let talkIds: [TalkID] = []            // Talk IDs that you want to put the message in, maximum count: 5
    let attachments: [Attachment] = []
    class Attachment: ClassInit {
        let fileUrl: URL                  // Each message can have max. 5 file URLs (max. 10MB per file).
        let fileName: String              // Unless the parameter specifies otherwise, filenames are automatically generated from the file URL. (maximum count: 5)
    }
}

class UploadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics/\(topicId)/attachments"
    typealias APIKitResponse = Attachment
    let topicId: TopicID // Topic ID
    let file: Data       // max file size: 100 MB
}

class DownloadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
    typealias APIKitResponse = Data
    let topicId: TopicID            // Topic ID
    let postId: PostID              // Post ID
    let attachmentId: AttachmentID  // Attachment ID
    let filename: String            // Attached filename
    let type: AttachmentType? = nil // Thumbnail image type (Only supports one image file) value: small, medium, large
}

class GetTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)/members/status"
    let topicId: TopicID // Topic ID
}

class GetMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)/posts/\(postId)"
    let topicId: TopicID // Topic ID
    let postId: PostID   // Post ID
}

class UpdateMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v1/topics/\(topicId)/posts/\(postId)"
    typealias APIKitResponse = PostMessageResponse
    let topicId: TopicID  // Topic ID
    let postId: PostID    // Post ID
    let message: String   // your message, ( max 4000 characters )
}

class DeleteMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/topics/\(topicId)/posts/\(postId)"
    typealias APIKitResponse = Post
    let topicId: TopicID // Topic ID
    let postId: PostID   // Post ID
}

class SearchMessages: ClassInit, APIKitHelper, TypetalkRequest { // router:",v2/search/posts"
    let q: String                      // Keyword to search
    let spaceKey: SpaceKey             // Space key
    let topicIds: TopicID? = nil       // Topic ID
    let hasAttachments: Bool? = nil    // Search only posts with attachments. default value: false
    let accountIds: [AccountID]? = nil // Account ID
    let from: Date? = nil              // Start date for searching posts.
    let to: Date? = nil                // End date for searching posts.
}

class LikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics/\(topicId)/posts/\(postId)/like"
    let topicId: TopicID // Topic ID
    let postId: PostID   // Post ID
}

class UnlikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/topics/\(topicId)/posts/\(postId)/like"
    typealias APIKitResponse = LikeMessageResponse
    let topicId: TopicID // Topic ID
    let postId: PostID   // Post ID
}

class GetDirectMessages: ClassInit, APIKitHelper, TypetalkRequest { // router:",v2/spaces/\(spaceKey)/messages/@\(accountName)"
    let spaceKey: SpaceKey       // Space key
    let accountName: String      // Account name
    let count: Int? = nil        // default value: 20, maximum: 200
    let from: PostID? = nil      // references Post ID
    let direction: String? = nil // “backward” or “forward”
}

class PostDirectMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v2/spaces/\(spaceKey)/messages/@\(accountName)"
  	let spaceKey: SpaceKey                // Space key
    let accountName: String               // Account name
    let message: String                   // your message, (max 4000 characters)
    let replyTo: PostID? = nil            // references Post ID
    let showLinkMeta: Bool? = nil         // show OGP data of URL included in message. default value: true
    let fileKeys: [FileKey] = []          // attachment file key (refer to Upload attachment file), maximum count: 5
    let talkIds: [Int] = []               // Talk IDs that you want to put the message in, maximum count: 5
    let attachments: [Attachment] = []
    class Attachment: ClassInit {
        let fileUrl: URL                  // Each message can have max. 5 file URLs (max. 10MB per file).
        let fileName: String              // Unless the parameter specifies otherwise, filenames are automatically generated from the file URL. (maximum count: 5)
    }
}

class GetNotificationStatus: ClassInit, APIKitHelper, TypetalkRequest { // router:",v5/notifications/status"
}

class OpenNotification: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v3/notifications"
    typealias APIKitResponse = NotificationStatus
    let spaceKey: SpaceKey // Space key
}

class SaveReadTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v1/bookmarks"
    let topicId: TopicID      // Topic ID
    let postId: PostID? = nil // Post ID ( if no parameter, read all posts )
}

class GetMentions: ClassInit, APIKitHelper, TypetalkRequest { // router:",v2/mentions"
    let spaceKey: SpaceKey     // Space key
    let from: MentionID? = nil // Mention ID
    let unread: Bool? = nil    // true: only unread mentions, false: all mentions
}

class SaveReadMention: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v1/mentions/\(mentionId)"
    let mentionId: MentionID // Mention ID
}

class CreateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics"
    typealias APIKitResponse = TopicWithAccounts
    let name: String                    // Topic name (max 64 characters)
    let spaceKey: SpaceKey              // Organization key
    let addAccountIds: [AccountID] = [] // Account ID (organization member only)
    let addGroupIds: [GroupID] = []     // Group ID
}

class UpdateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v1/topics/\(topicId)"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID           // Topic ID
    let name: String               // Topic name ( max 64 characters )
    let description: String? = nil // Topic name ( max 1000 characters )
}

class DeleteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/topics/\(topicId)"
    let topicId: TopicID // Topic ID
}

class GetTopicDetails: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)/details"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID // Topic ID
}

class UpdateTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics/\(topicId)/members/update"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID                                 // Topic ID
    //let addAccountIds[0],: String                      // Account ID that you want to add (organization member only)
    //let addGroupIds[0],: String                        // Group ID that you want to add
    //let invitations[0].email,: String                  // Email address that you want to invite
    //let invitations[0].role,: String                   // Role that you want to invite
    //let removeAccounts[0].id,: Int                     // Account ID that you want to remove
    //let removeAccounts[0].cancelSpaceInvitation,: Bool // If this is true, the user invitation will be removed
    //let removeGroupIds[0],: Int                        // Group ID that you want to remove
}

class GetSpaces: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/spaces"
    let excludesGuest: Bool? = nil // If this is true, response excludes organizations that your role is guest in.
}

class GetSpaceMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/spaces/\(spaceKey)/members"
    let spaceKey: SpaceKey // Organization Key
}

class GetFriends: ClassInit, APIKitHelper, TypetalkRequest { // router:",v4/search/friends"
    let q: String          // query
    let spaceKey: SpaceKey // Space key
    let offset: Int? = nil // default value: 0
    let count: Int? = nil  // default value: 30, maximum: 100
}

class GetTalks: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)/talks"
    let topicId: TopicID // Topic ID
}

class GetTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/topics/\(topicId)/talks/\(talkId)/posts"
    let topicId: TopicID         // Topic ID
    let talkId: TalkID           // Talk ID
    let count: Int? = nil        // default value: 20, maximum: 200
    let from: PostID? = nil      // references Post ID
    let direction: MessageDirection? = nil // “backward” or “forward”
}

class CreateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics/\(topicId)/talks"
    let topicId: TopicID  // Topic ID
    let talkName: String  // Talk name ( max 64 characters )
    let postIds: [PostID] // Post IDs that you want to add to the talk
}

class UpdateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v1/topics/\(topicId)/talks/\(talkId)"
    let topicId: TopicID // Topic ID
    let talkId: TalkID   // Talk ID
    let talkName: String // Talk name ( max 64 characters )
}

class DeleteTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/topics/\(topicId)/talks/\(talkId)"
    typealias APIKitResponse = UpdateTalkResponse
    let topicId: TopicID // Topic ID
    let talkId: TalkID   // Talk ID
}

class AddMessageToTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/topics/\(topicId)/talks/\(talkId)/posts"
    typealias APIKitResponse = CreateTalkResponse
    let topicId: TopicID  // Topic ID
    let talkId: TalkID    // Talk ID
    let postIds: [PostID] // Post IDs that you want to add to the talk
}

class RemoveMessageFromTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/topics/\(topicId)/talks/\(talkId)/posts"
    typealias APIKitResponse = CreateTalkResponse
    let topicId: TopicID  // Topic ID
    let talkId: TalkID    // Talk ID
    let postIds: [PostID] // Post IDs that you want to remove from the talk
}

class GetReceivedLikes: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/spaces/\(spaceKey)/likes/receive"
    let spaceKey: SpaceKey  // Space key
    let from: LikeID? = nil // references Like ID
}

class GetGivenLikes: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/spaces/\(spaceKey)/likes/give"
    let spaceKey: SpaceKey  // Space key
    let from: LikeID? = nil // references Like ID
}

class DiscoverLikes: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/spaces/\(spaceKey)/likes/discover"
    typealias APIKitResponse = GetReceivedLikesResponse
    let spaceKey: SpaceKey  // Space key
    let from: LikeID? = nil // references Like ID
}

class SaveReadLikes: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v2/likes/receive/bookmark/save"
    let spaceKey: SpaceKey // Space key
    let likeId: LikeID     // references Like ID
}

class CreateTopicGroup: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/spaces/\(spaceKey)/myTopicGroups"
	let spaceKey: SpaceKey      // Space key
	let name: String            // Topic Group Name
	let topicId: TopicID? = nil // Topic ID
}

class UpdateTopicGroup: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,v1/spaces/\(spaceKey)/myTopicGroups/\(myTopicGroupId)"
	let spaceKey: SpaceKey      // Space key
	let myTopicGroupId: GroupID // My Topic Group ID
	let name: String            // Topic Group Name
	let sortType: SortType      // Sort type(“recent” or “alphanumerical”)
	let isMuted: Bool           // Mute setting
}

class DeleteTopicGroup: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/spaces/\(spaceKey)/myTopicGroups/\(myTopicGroupId)"
    typealias APIKitResponse = UpdateTopicGroupResponse
	let spaceKey: SpaceKey      // Space key
	let myTopicGroupId: GroupID // Topic Group ID
}

class GetMyTopics: ClassInit, APIKitHelper, TypetalkRequest { // router:",v1/spaces/\(spaceKey)/myTopics"
	let spaceKey: SpaceKey // Space key
}

class AddTopicToGroup: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/spaces/\(spaceKey)/myTopics/myTopicGroups/\(myTopicGroupId)/topics/\(topicId)/add"
	let spaceKey: SpaceKey      // Space key
	let myTopicGroupId: GroupID // Topic Group ID
	let topicId: TopicID        // Topic ID
}

class DeleteMyTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,v1/spaces/\(spaceKey)/myTopics/topics/\(topicId)"
	let spaceKey: SpaceKey // Space key
	let topicId: TopicID   // Topic ID
}

class PinTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,v1/spaces/\(spaceKey)/myTopics/pin"
	let spaceKey: SpaceKey // Space key
	let topicId: TopicID   // Topic ID
}
