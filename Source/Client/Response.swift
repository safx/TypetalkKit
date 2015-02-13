//
//  Response.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/08.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

extension Client {

// MARK: ResponseObject

  //public typealias GetProfileResponse            = Account
  //public typealias GetTopicsResponse             = [TopicWithUserInfo]
  //public typealias GetMessagesResponse           = (Team, Topic, Bookmark, Post, hasNext)
  //public typealias PostMessageResponse           = (Topic, Post)
    public typealias UploadAttachmentResponse      = Attachment
  //public typealias GetTopicMembersResponse       = ([Account], [Account])
  //public typealias GetMessageResponse            = (Team, Topic, Post, [Post])
    public typealias DeleteMessageResponse         = Post
  //public typealias LikeMessageResponse           = Like
    public typealias UnlikeMessageResponse         = LikeMessageResponse
    public typealias FavoriteTopicResponse         = TopicWithUserInfo
    public typealias UnfavoriteTopicResponse       = TopicWithUserInfo
    public typealias GetNotificationsResponse      = Notifications
    public typealias GetNotificationStatusResponse = NotificationStatus
    public typealias OpenNotificationResponse      = NotificationStatus
  //public typealias SaveReadTopicResponse         = Unread
  //public typealias GetMentionsResponse           = [Mention]
  //public typealias SaveReadMentionResponse       = Mention
  //public typealias AcceptTeamInviteResponse      = ([Topic], TeamInvite)
    public typealias DeclineTeamInviteResponse     = TeamInvite
  //public typealias AcceptTopicInviteResponse     = TopicInvite
    public typealias DeclineTopicInviteResponse    = AcceptTopicInviteResponse
    public typealias CreateTopicResponse           = TopicWithAccounts
    public typealias UpdateTopicResponse           = TopicWithAccounts
    public typealias DeleteTopicResponse           = Topic
    public typealias GetTopicDetailsResponse       = TopicWithAccounts
    public typealias InviteTopicMemberResponse     = TopicWithAccounts
    public typealias RemoveTopicMemberResponse     = TopicWithAccounts
  //public typealias GetTeamsResponse              = [TeamWithCount]
  //public typealias GetFriendsResponse            = [Account]
    public typealias SearchAccountsResponse        = Account
  //public typealias GetTalksResponse              = [Talk]
    public typealias GetTalkResponse               = TalkMessages

    
    
// MARK: ResponseBlock

    public typealias GetProfileCompletionBlock            =  ((GetProfileResponse?            , NSError?) -> Void)
    public typealias GetTopicsCompletionBlock             =  ((GetTopicsResponse?             , NSError?) -> Void)
    public typealias GetMessagesCompletionBlock           =  ((GetMessagesResponse?           , NSError?) -> Void)
    public typealias PostMessagesCompletionBlock          =  ((PostMessageResponse?           , NSError?) -> Void)
    public typealias UploadAttachmentCompletionBlock      =  ((UploadAttachmentResponse?      , NSError?) -> Void)
    public typealias GetTopicMembersCompletionBlock       =  ((GetTopicMembersResponse?       , NSError?) -> Void)
    public typealias GetMessageCompletionBlock            =  ((GetMessageResponse?            , NSError?) -> Void)
    public typealias DeleteMessageCompletionBlock         =  ((DeleteMessageResponse?         , NSError?) -> Void)
    public typealias LikeMessageCompletionBlock           =  ((LikeMessageResponse?           , NSError?) -> Void)
    public typealias UnlikeMessageCompletionBlock         =  ((UnlikeMessageResponse?         , NSError?) -> Void)
    public typealias FavoriteTopicCompletionBlock         =  ((FavoriteTopicResponse?         , NSError?) -> Void)
    public typealias UnfavoriteTopicCompletionBlock       =  ((UnfavoriteTopicResponse?       , NSError?) -> Void)
    public typealias GetNotificationsCompletionBlock      =  ((GetNotificationsResponse?      , NSError?) -> Void)
    public typealias GetNotificationStatusCompletionBlock =  ((GetNotificationStatusResponse? , NSError?) -> Void)
    public typealias OpenNotificationCompletionBlock      =  ((OpenNotificationResponse?      , NSError?) -> Void)
    public typealias SaveReadTopicCompletionBlock         =  ((SaveReadTopicResponse?         , NSError?) -> Void)
    public typealias GetMentionsCompletionBlock           =  ((GetMentionsResponse?           , NSError?) -> Void)
    public typealias SaveReadMentionCompletionBlock       =  ((SaveReadMentionResponse?       , NSError?) -> Void)
    public typealias AcceptTeamInviteCompletionBlock      =  ((AcceptTeamInviteResponse?      , NSError?) -> Void)
    public typealias DeclineTeamInviteCompletionBlock     =  ((DeclineTeamInviteResponse?     , NSError?) -> Void)
    public typealias AcceptTopicInviteCompletionBlock     =  ((AcceptTopicInviteResponse?     , NSError?) -> Void)
    public typealias DeclineTopicInviteCompletionBlock    =  ((DeclineTopicInviteResponse?    , NSError?) -> Void)
    public typealias CreateTopicCompletionBlock           =  ((CreateTopicResponse?           , NSError?) -> Void)
    public typealias UpdateTopicCompletionBlock           =  ((UpdateTopicResponse?           , NSError?) -> Void)
    public typealias DeleteTopicCompletionBlock           =  ((DeleteTopicResponse?           , NSError?) -> Void)
    public typealias GetTopicDetailsCompletionBlock       =  ((GetTopicDetailsResponse?       , NSError?) -> Void)
    public typealias InviteTopicMemberCompletionBlock     =  ((InviteTopicMemberResponse?     , NSError?) -> Void)
    public typealias RemoveTopicMemberCompletionBlock     =  ((RemoveTopicMemberResponse?     , NSError?) -> Void)
    public typealias GetTeamsCompletionBlock              =  ((GetTeamsResponse?              , NSError?) -> Void)
    public typealias GetFriendsCompletionBlock            =  ((GetFriendsResponse?            , NSError?) -> Void)
    public typealias SearchAccountsCompletionBlock        =  ((SearchAccountsResponse?        , NSError?) -> Void)
    public typealias GetTalksCompletionBlock              =  ((GetTalksResponse?              , NSError?) -> Void)
    public typealias GetTalkCompletionBlock               =  ((GetTalkResponse?               , NSError?) -> Void)
    public typealias DownloadAttachmentCompletionBlock    =  ((NSData?                        , NSError?) -> Void)
    public typealias DownloadAttachmentWithURLCompletionBlock =  ((NSData?                        , NSError?) -> Void)
}
