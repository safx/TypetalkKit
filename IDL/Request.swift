//
//  Request.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/15.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

class GetProfile: ClassInit, APIKitHelper, TypetalkRequest { // router:",profile"
}

class GetFriendProfile: ClassInit, APIKitHelper, TypetalkRequest { // router:",accounts/profile/\(accountName)"
    typealias APIKitResponse = AccountWithLoginStatus
    let accountName: String
}

class GetOnlineStatus: ClassInit, APIKitHelper, TypetalkRequest { // router:",accounts/status"
    let accountIds: [AccountID]
}

class GetTopics:  ClassInit, APIKitHelper, TypetalkRequest { // router:",topics"
}

class GetDmTopics: ClassInit, APIKitHelper, TypetalkRequest { // router:",messages"
    typealias APIKitResponse = DirectMessageTopic
}

class GetMessages: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)"
    let topicId: TopicID
    let count: Int?                        // default value: 20, maximum: 200
    let from: PostID? = nil                // references Post ID
    let direction: MessageDirection? = nil
}

class PostMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId),form"
    let topicId: TopicID
    let message: String                   // your message,  (max 4000 characters)
    let replyTo: PostID? = nil            // references Post ID
    let showLinkMeta: Bool? = nil         // show OGP data of URL included in message. default value: true
    let fileKeys: [FileKey] = []          // attachment file key (refer to Upload attachment file ), maximum count: 5
    let talkIds: [TalkID] = []            // Talk IDs that you want to put the message in, maximum count: 5
    //let attachments[0].fileUrl: String  // Each message can have max. 5 file URLs (max. 10MB per file).
    //let attachments[0].fileName: String // Unless the parameter specifies otherwise, filenames are automatically generated from the file URL. (maximum count: 5)
}

class UploadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/attachments"
    typealias APIKitResponse = Attachment
    let topicId: TopicID
    open let name: String     // router:"-"
    open let contents: Data // router:"-"
}

class DownloadAttachment: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
    typealias APIKitResponse = Data
    let topicId: TopicID
    let postId: PostID
    let attachmentId: AttachmentID
    let filename: String            // Attached filename
    let type: AttachmentType? = nil // Thumbnail image type (Only supports one image file) value: small, medium, large
}

class GetTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/members/status"
    let topicId: TopicID
}

class GetMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/posts/\(postId)"
    let topicId: TopicID
    let postId: PostID
}

class UpdateMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)/posts/\(postId)"
    typealias APIKitResponse = PostMessageResponse
    let topicId: TopicID
    let postId: PostID
    let message: String   // your message,  ( max 4000 characters )
}

class DeleteMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/posts/\(postId)"
    typealias APIKitResponse = Post
    let topicId: TopicID
    let postId: PostID
}

class LikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/posts/\(postId)/like"
    let topicId: TopicID
    let postId: PostID
}

class UnlikeMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/posts/\(postId)/like"
    typealias APIKitResponse = LikeMessageResponse
    let topicId: TopicID
    let postId: PostID
}

class FavoriteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/favorite"
    let topicId: TopicID
}

class UnfavoriteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/favorite"
    typealias APIKitResponse = FavoriteTopicResponse
    let topicId: TopicID
}

class GetDirectMessages: ClassInit, APIKitHelper, TypetalkRequest { // router:",messages/@\(accountName)"
    let accountName: String                // Account name
    let count: Int? = nil                  // default value: 20, maximum: 200
    let from: PostID? = nil                // references Post ID
    let direction: MessageDirection? = nil // “backward” or “forward”
}

class PostDirectMessage: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,messages/@\(accountName)"
    let accountName: String               // Account name
    let message: String                   // your message,  (max 4000 characters)
    let replyTo: PostID? = nil            // references Post ID
    let showLinkMeta: Bool? = nil         // show OGP data of URL included in message. default value: true
    let fileKeys: [FileKey] = []          // attachment file key (refer to Upload attachment file ), maximum count: 5
    let talkIds: [TalkID] = []            // Talk IDs that you want to put the message in, maximum count: 5
    //let attachments[0].fileUrl: String  // Each message can have max. 5 file URLs (max. 10MB per file).
    //let attachments[0].fileName: String // Unless the parameter specifies otherwise, filenames are automatically generated from the file URL. (maximum count: 5)
}

class GetNotifications: ClassInit, APIKitHelper, TypetalkRequest { // router:",notifications"
    typealias APIKitResponse = Notifications
}

class GetNotificationStatus: ClassInit, APIKitHelper, TypetalkRequest { // router:",notifications/status"
    typealias APIKitResponse = NotificationStatus
}

class OpenNotification: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,notifications"
    typealias APIKitResponse = NotificationStatus
}

class SaveReadTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,bookmarks"
    let topicId: TopicID
    let postId: PostID? = nil          // Post ID ( if no parameter, read all posts )
}

class GetMentions: ClassInit, APIKitHelper, TypetalkRequest { // router:",mentions"
    let from: MentionID? = nil
    let unread: Bool? = nil            // true: only unread mentions, false: all mentions
}

class SaveReadMention: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,mentions/\(mentionId)"
    let mentionId: MentionID
}

class CreateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics"
    typealias APIKitResponse = TopicWithAccounts
    let name: String                          // Topic name  (max 64 characters)
    let spaceKey: SpaceKey
    let addAccountIds: [AccountID] = []       // Account ID (organization member only)
    let addGroupIds: [GroupID] = []
}

class UpdateTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
    let name: String? = nil        // Topic name         ( max 64 characters )
    let description: String? = nil // Topic description  ( max 1000 characters )
}

class DeleteTopic: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)"
    typealias APIKitResponse = Topic
    let topicId: TopicID
}

class GetTopicDetails: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/details"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
}

class UpdateTopicMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/members/update"
    typealias APIKitResponse = TopicWithAccounts
    let topicId: TopicID
    let addAccountIds: [AccountID] = []                  // Account ID that you want to add (organization member only)
    let addGroupIds: [GroupID] = []                      // Group ID that you want to add
    //let invitations[0].email,: String                  // Email address that you want to invite
    //let invitations[0].role,: String                   // Role that you want to invite
    //let removeAccounts[0].id,: Int                     // Account ID that you want to remove
    //let removeAccounts[0].cancelSpaceInvitation,: Bool // If this is true, the user invitation will be removed
    let removeGroupIds: [GroupID] = []                   // Group ID that you want to remove
}

class GetSpaces: ClassInit, APIKitHelper, TypetalkRequest { // router:",spaces"
    let excludesGuest: Bool = false          // If this is true, response excludes organizations that your role is guest in.
}

class GetSpaceMembers: ClassInit, APIKitHelper, TypetalkRequest { // router:",spaces/\(spaceKey)/members"
    let spaceKey: SpaceKey
}

class GetFriends: ClassInit, APIKitHelper, TypetalkRequest { // router:",search/friends"
    // TODO
}

class SearchAccounts: ClassInit, APIKitHelper, TypetalkRequest { // router:",search/accounts"
    typealias APIKitResponse = Account
    let nameOrEmailAddress: String
}

class GetTalks: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/talks"
    let topicId: TopicID
}

class GetTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:",topics/\(topicId)/talks/\(talkId)/posts"
    //typealias APIKitResponse = TalkMessages
    let topicId: TopicID
    let talkId: TalkID
    let count: Int?                 // default value: 20, maximum: 200
    let from: PostID? = nil         // references Post ID
    let direction: MessageDirection? = nil
}

class CreateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/talks"
    let topicId: TopicID
    let talkName: String        // Talk name ( max 64 characters )
    let postIds: [PostID] = []  // Post IDs that you want to add to the talk
}

class UpdateTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"PUT,topics/\(topicId)/talks/\(talkId)"
    let topicId: TopicID
    let talkId: TalkID
    let talkName: String        // Talk name ( max 64 characters )
}

class DeleteTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/talks/\(talkId)"
    typealias APIKitResponse = UpdateTalkResponse
    let topicId: TopicID
    let talkId: TalkID
}

class AddMessageToTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"POST,topics/\(topicId)/talks/\(talkId)/posts"
    typealias APIKitResponse = CreateTalkResponse
    let topicId: TopicID
    let talkId: TalkID
    let postIds: [PostID] = []  // Post IDs that you want to add to the talk
}

class RemoveMessageFromTalk: ClassInit, APIKitHelper, TypetalkRequest { // router:"DELETE,topics/\(topicId)/talks/\(talkId)/posts"
    typealias APIKitResponse = CreateTalkResponse
    let topicId: TopicID
    let talkId: TalkID
    let postIds: [PostID] = []  // Post IDs that you want to add to the talk
}
