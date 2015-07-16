//
//  Router.swift
//  IDL
//
//  Created by Safx Developer on 2015/07/15.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation

enum Router: URLRequestHelper, Printable {
    case GetProfile                                                                          // router:",profile"
    case GetTopics                                                                           // router:",topics"
    case GetMessages(topicId: TopicID,                                                       // router:",topics/\(topicId)"
                     count: Int?, from: PostID?, direction: MessageDirection?)
    case PostMessage(topicId: TopicID,                                                       // router:"POST,topics/\(topicId)"
                     message: String, replyTo: Int?, fileKeys: [String], talkIds: [TalkID])
                    // TODO: attachments[0].fileUrl, attachments[0].fileName
    case UploadAttachment(topicId: TopicID)                                                  // router:"POST,topics/\(topicId)/attachments"
    case GetTopicMembers(topicId: TopicID)                                                   // router:",topics/\(topicId)/members/status"
    case GetMessage(topicId: TopicID, postId: PostID)                                        // router:",topics/\(topicId)/posts/\(postId)"
    case DeleteMessage(topicId: TopicID, postId: PostID)                                     // router:"DELETE,topics/\(topicId)/posts/\(postId)"
    case LikeMessage(topicId: TopicID, postId: PostID)                                       // router:"POST,topics/\(topicId)/posts/\(postId)/like"
    case UnlikeMessage(topicId: TopicID, postId: PostID)                                     // router:"DELETE,topics/\(topicId)/posts/\(postId)/like"
    case FavoriteTopic(topicId: TopicID)                                                     // router:"POST,topics/\(topicId)/favorite"
    case UnfavoriteTopic(topicId: TopicID)                                                   // router:"DELETE,topics/\(topicId)/favorite"
    case GetNotifications                                                                    // router:",notifications"
    case GetNotificationStatus                                                               // router:",notifications/status"
    case OpenNotification                                                                    // router:"PUT,notifications"
    case SaveReadTopic(topicId: TopicID, postId: PostID?)                                    // router:"PUT,bookmarks"
    case GetMentions(from: MentionID?, unread: Bool?)                                        // router:",mentions"
    case SaveReadMention(mentionId: MentionID)                                               // router:"PUT,mentions/\(mentionId)"
    case AcceptTeamInvite(teamId: TeamID, inviteId: InviteID)                                // router:"POST,teams/\(teamId)/members/invite/\(inviteId)/accept"
    case DeclineTeamInvite(teamId: TeamID, inviteId: InviteID)                               // router:"POST,teams/\(teamId)/members/invite/\(inviteId)/decline"
    case AcceptTopicInvite(topicId: TopicID, inviteId: InviteID)                             // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/accept"
    case DeclineTopicInvite(topicId: TopicID, inviteId: InviteID)                            // router:"POST,topics/\(topicId)/members/invite/\(inviteId)/decline"
    case CreateTopic(name: String, teamId: TeamID?,                                          // router:"POST,topics"
                     inviteMembers: [String], inviteMessage: String)
    case UpdateTopic(topicId: TopicID, name: String?, teamId: TeamID?)                       // router:"PUT,topics/\(topicId)"
    case DeleteTopic(topicId: TopicID)                                                       // router:"DELETE,topics/\(topicId)"
    case GetTopicDetails(topicId: TopicID)                                                   // router:",topics/\(topicId)/details"
    case InviteTopicMember(topicId: TopicID,                                                 // router:"POST,topics/\(topicId)/members/invite"
                           inviteMembers: [String], inviteMessage: String?)
    case RemoveTopicMember(topicId: TopicID,                                                 // router:"POST,topics/\(topicId)/members/remove"
                           removeInviteIds: [InviteID], removeMemberIds: [AccountID])
    case GetTeams                                                                            // router:",teams"
    case GetFriends                                                                          // router:",search/friends"
    case SearchAccounts(nameOrEmailAddress: String)                                          // router:",search/accounts"
    case GetTalks(topicId: TopicID)                                                          // router:",topics/\(topicId)/talks"
    case GetTalk(topicId: TopicID, talkId: TalkID,                                           // router:",topics/\(topicId)/talks/\(talkId)/posts"
                 count: Int?, from: PostID?, direction: MessageDirection?)
    case CreateTalk(topicId: TopicID, talkName: String, postIds: [Int]                       // router:"POST,topics/\(topicId)/talks"
    case DownloadAttachment(topicId: TopicID, postId: PostID, attachmentId: AttachmentID,    // router:",topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
                            filename: String, type: AttachmentType?)
    case Streaming                                                                           // router:",streaming"

    //case DownloadAttachmentWithURL(url: NSURL, type: AttachmentType?)
}
