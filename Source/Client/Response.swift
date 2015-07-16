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
    public typealias DeclineTeamInviteResponse     = Invite //TeamInvite
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



// MARK: ResponseClosure

    public typealias GetProfileCompletionClosure                =  ((GetProfileResponse?            , NSError?) -> Void)
    public typealias GetTopicsCompletionClosure                 =  ((GetTopicsResponse?             , NSError?) -> Void)
    public typealias GetMessagesCompletionClosure               =  ((GetMessagesResponse?           , NSError?) -> Void)
    public typealias PostMessageCompletionClosure               =  ((PostMessageResponse?           , NSError?) -> Void)
    public typealias UploadAttachmentCompletionClosure          =  ((UploadAttachmentResponse?      , NSError?) -> Void)
    public typealias GetTopicMembersCompletionClosure           =  ((GetTopicMembersResponse?       , NSError?) -> Void)
    public typealias GetMessageCompletionClosure                =  ((GetMessageResponse?            , NSError?) -> Void)
    public typealias DeleteMessageCompletionClosure             =  ((DeleteMessageResponse?         , NSError?) -> Void)
    public typealias LikeMessageCompletionClosure               =  ((LikeMessageResponse?           , NSError?) -> Void)
    public typealias UnlikeMessageCompletionClosure             =  ((UnlikeMessageResponse?         , NSError?) -> Void)
    public typealias FavoriteTopicCompletionClosure             =  ((FavoriteTopicResponse?         , NSError?) -> Void)
    public typealias UnfavoriteTopicCompletionClosure           =  ((UnfavoriteTopicResponse?       , NSError?) -> Void)
    public typealias GetNotificationsCompletionClosure          =  ((GetNotificationsResponse?      , NSError?) -> Void)
    public typealias GetNotificationStatusCompletionClosure     =  ((GetNotificationStatusResponse? , NSError?) -> Void)
    public typealias OpenNotificationCompletionClosure          =  ((OpenNotificationResponse?      , NSError?) -> Void)
    public typealias SaveReadTopicCompletionClosure             =  ((SaveReadTopicResponse?         , NSError?) -> Void)
    public typealias GetMentionsCompletionClosure               =  ((GetMentionsResponse?           , NSError?) -> Void)
    public typealias SaveReadMentionCompletionClosure           =  ((SaveReadMentionResponse?       , NSError?) -> Void)
    public typealias AcceptTeamInviteCompletionClosure          =  ((AcceptTeamInviteResponse?      , NSError?) -> Void)
    public typealias DeclineTeamInviteCompletionClosure         =  ((DeclineTeamInviteResponse?     , NSError?) -> Void)
    public typealias AcceptTopicInviteCompletionClosure         =  ((AcceptTopicInviteResponse?     , NSError?) -> Void)
    public typealias DeclineTopicInviteCompletionClosure        =  ((DeclineTopicInviteResponse?    , NSError?) -> Void)
    public typealias CreateTopicCompletionClosure               =  ((CreateTopicResponse?           , NSError?) -> Void)
    public typealias UpdateTopicCompletionClosure               =  ((UpdateTopicResponse?           , NSError?) -> Void)
    public typealias DeleteTopicCompletionClosure               =  ((DeleteTopicResponse?           , NSError?) -> Void)
    public typealias GetTopicDetailsCompletionClosure           =  ((GetTopicDetailsResponse?       , NSError?) -> Void)
    public typealias InviteTopicMemberCompletionClosure         =  ((InviteTopicMemberResponse?     , NSError?) -> Void)
    public typealias RemoveTopicMemberCompletionClosure         =  ((RemoveTopicMemberResponse?     , NSError?) -> Void)
    public typealias GetTeamsCompletionClosure                  =  ((GetTeamsResponse?              , NSError?) -> Void)
    public typealias GetFriendsCompletionClosure                =  ((GetFriendsResponse?            , NSError?) -> Void)
    public typealias SearchAccountsCompletionClosure            =  ((SearchAccountsResponse?        , NSError?) -> Void)
    public typealias GetTalksCompletionClosure                  =  ((GetTalksResponse?              , NSError?) -> Void)
    public typealias GetTalkCompletionClosure                   =  ((GetTalkResponse?               , NSError?) -> Void)
    public typealias CreateTalkCompletionClosure                =  ((CreateTalkResponse?            , NSError?) -> Void)
    public typealias DownloadAttachmentCompletionClosure        =  ((NSData?                        , NSError?) -> Void)
    public typealias DownloadAttachmentWithURLCompletionClosure =  ((NSData?                        , NSError?) -> Void)
}
