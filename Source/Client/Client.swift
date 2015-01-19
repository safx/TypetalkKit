//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/18.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Alamofire

public class Client {
    
    public class var sharedClient : Client {
        struct Static {
            static let instance = Client()
        }
        return Static.instance
    }

    private init() {}

    public typealias RequestModifier = ((Router) -> NSURLRequest)
    public init(requestModifierForTests: RequestModifier) {
        self.requestModifierForTests = requestModifierForTests
    }
    let requestModifierForTests: RequestModifier? = nil
    

    // MARK: OAuth2
    
    private var oauth2 = OAuth2Client()
    public var isInitialized: Bool {
        return oauth2.isInitialized
    }
    public var isSignedIn: Bool {
        return oauth2.isSignedIn
    }
    public var accessToken: String? {
        return oauth2.accessToken
    }
    public func setDeveloperSettings(#clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) -> Bool {
        return oauth2.setDeveloperSettings(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI, scopes: scopes)
    }
    public func restoreTokenFromAccountStore() -> Bool {
        return oauth2.restoreTokenFromAccountStore()
    }
    public func authorize(completion: OAuth2Client.CompletionBlock) {
        oauth2.authorize(completion)
    }
    public func isRedirectURL(url: NSURL) -> Bool {
        return oauth2.isRedirectURL(url)
    }
    public func authorizationDone(URL url: NSURL) -> Bool {
        return oauth2.authorizationDone(URL: url)
    }
    public func requestRefreshToken(completion: OAuth2Client.CompletionBlock) -> Bool {
        return oauth2.requestRefreshToken(completion)
    }
    
    // MARK: Alamofire
    
    private func _request(router: Router) -> Request? {
        if let mod = requestModifierForTests? {
            return Alamofire.request(mod(router))
        }
        
        switch oauth2.state {
        case .SignedIn(let (credential)):
            return Alamofire.request(router.URLRequest(credential.accessToken))
        default:
            return nil
        }
    }

    private func _upload(router: Router, fileName: String, fileContent: NSData) -> Request? {
        if let mod = requestModifierForTests? {
            return Alamofire.request(mod(router))
        }

        switch oauth2.state {
        case .SignedIn(let (credential)):
            return Alamofire.request(router.URLRequest(credential.accessToken, fileName: fileName, fileContent: fileContent))
        default:
            return nil
        }
    }
}

// MARK: Typetalk API

extension Client {
    public func getProfile(completion: GetProfileCompletionBlock) {
        _request(Router.GetProfile)?
            .responseObject(_do(completion))
    }

    public func getTopics(completion: GetTopicsCompletionBlock) {
        _request(Router.GetTopics)?
            .responseObject(_do(completion))
    }

    public func getMessages(topicId: TopicID, count: Int?, from: PostID?, direction: MessageDirection?, completion: GetMessagesCompletionBlock) {
        let form = GetMessagesForm(count: count, from: from, direction: direction)
        _request(Router.GetMessages(topicId, form))?
            .responseObject(_do(completion))
    }
    
    public func postMessage(topicId: TopicID, message: String, replyTo: PostID?, fileKeys: [String], talkIds: [TalkID], completion: PostMessagesCompletionBlock) {
        let form = PostMessageForm(message: message, replyTo: replyTo, fileKeys: fileKeys, talkIds: talkIds)
        _request(Router.PostMessage(topicId, form))?
            .responseObject(_do(completion))
    }

    public func uploadAttachment(topicId: TopicID, fileName: String, fileContent: NSData, completion: UploadAttachmentCompletionBlock) {
        _upload(Router.UploadAttachment(topicId), fileName: fileName, fileContent: fileContent)?
            .responseObject(_do(completion))
    }
    
    public func getTopicMembers(topicId: TopicID, completion: GetTopicMembersCompletionBlock) {
        _request(Router.GetTopicMembers(topicId))?
            .responseObject(_do(completion))
    }
    
    public func getMessage(topicId: TopicID, postId: PostID, completion: GetMessageCompletionBlock) {
        _request(Router.GetMessage(topicId, postId))?
            .responseObject(_do(completion))
    }

    public func deleteMessage(topicId: TopicID, postId: PostID, completion: DeleteMessageCompletionBlock) {
        _request(Router.DeleteMessage(topicId, postId))?
            .responseObject(_do(completion))
    }
    
    public func likeMessage(topicId: TopicID, postId: PostID, completion: LikeMessageCompletionBlock) {
        _request(Router.LikeMessage(topicId, postId))?
            .responseObject(_do(completion))
    }
    
    public func unlikeMessage(topicId: TopicID, postId: PostID, completion: UnlikeMessageCompletionBlock) {
        _request(Router.UnlikeMessage(topicId, postId))?
            .responseObject(_do(completion))
    }
    
    public func favoriteTopic(topicId: TopicID, completion: FavoriteTopicCompletionBlock) {
        _request(Router.FavoriteTopic(topicId))?
            .responseObject(_do(completion))
    }
    
    public func unfavoriteTopic(topicId: TopicID, completion: UnfavoriteTopicCompletionBlock) {
        _request(Router.UnfavoriteTopic(topicId))?
            .responseObject(_do(completion))
    }

    public func getNotifications(completion: GetNotificationsCompletionBlock) {
        _request(Router.GetNotifications)?
            .responseObject(_do(completion))
    }

    public func getNotificationStatus(completion: GetNotificationStatusCompletionBlock) {
        _request(Router.GetNotificationStatus)?
            .responseObject(_do(completion))
    }

    public func openNotification(completion: OpenNotificationCompletionBlock) {
        _request(Router.OpenNotification)?
            .responseObject(_do(completion))
    }

    public func saveReadTopic(topicId: TopicID, postId: PostID?, completion: SaveReadTopicCompletionBlock) {
        _request(Router.SaveReadTopic(topicId, postId))?
            .responseObject(_do(completion))
    }
    
    public func getMentions(from: MentionID?, unread: Bool?, completion: GetMentionsCompletionBlock) {
        _request(Router.GetMentions(from, unread))?
            .responseObject(_do(completion))
    }

    public func saveReadMention(mentionId: MentionID, completion: SaveReadMentionCompletionBlock) {
        _request(Router.SaveReadMention(mentionId))?
            .responseObject(_do(completion))
    }
    
    public func acceptTeamInvite(teamId: TeamID, inviteId: InviteID, completion: AcceptTeamInviteCompletionBlock) {
        _request(Router.AcceptTeamInvite(teamId, inviteId))?
            .responseObject(_do(completion))
    }

    public func declineTeamInvite(teamId: TeamID, inviteId: InviteID, completion: DeclineTeamInviteCompletionBlock) {
        _request(Router.DeclineTeamInvite(teamId, inviteId))?
            .responseObject(_do(completion))
    }
    
    public func acceptTopicInvite(teamId: TopicID, inviteId: InviteID, completion: AcceptTopicInviteCompletionBlock) {
        _request(Router.AcceptTopicInvite(teamId, inviteId))?
            .responseObject(_do(completion))
    }
    
    public func declineTopicInvite(teamId: TopicID, inviteId: InviteID, completion: DeclineTopicInviteCompletionBlock) {
        _request(Router.DeclineTopicInvite(teamId, inviteId))?
            .responseObject(_do(completion))
    }
    
    public func createTopic(name: String, teamId: TeamID?, inviteMembers: [String], inviteMessage: String, completion: CreateTopicCompletionBlock) {
        let form = CreateTopicForm(name: name, teamId: teamId, inviteMembers: inviteMembers, inviteMessage: inviteMessage)
        _request(Router.CreateTopic(form))?
            .responseObject(_do(completion))
    }
    
    public func updateTopic(topicId: TopicID, name: String, teamId: TeamID?, completion: UpdateTopicCompletionBlock) {
        _request(Router.UpdateTopic(topicId, name, teamId))?
            .responseObject(_do(completion))
    }

    public func deleteTopic(topicId: TopicID, completion: DeleteTopicCompletionBlock) {
        _request(Router.DeleteTopic(topicId))?
            .responseObject(_do(completion))
    }

    public func getTopicDetails(topicId: TopicID, completion: GetTopicDetailsCompletionBlock) {
        _request(Router.GetTopicDetails(topicId))?
            .responseObject(_do(completion))
    }
    
    public func inviteTopicMember(topicId: TopicID, inviteName: [String], inviteMessage: String, completion: InviteTopicMemberCompletionBlock) {
        _request(Router.InviteTopicMember(topicId, inviteName, inviteMessage))?
            .responseObject(_do(completion))
    }

    public func removeTopicMember(topicId: TopicID, removeInviteIds: [InviteID], removeMemberIds: [AccountID], completion: RemoveTopicMemberCompletionBlock) {
        _request(Router.RemoveTopicMember(topicId, removeInviteIds, removeMemberIds))?
            .responseObject(_do(completion))
    }

    public func getTeams(completion: GetTeamsCompletionBlock) {
        _request(Router.GetTeams)?
            .responseObject(_do(completion))
    }

    public func getFriends(completion: GetFriendsCompletionBlock) {
        _request(Router.GetFriends)?
            .responseObject(_do(completion))
    }

    public func searchAccounts(nameOrEmailAddress: String, completion: SearchAccountsCompletionBlock) {
        _request(Router.SearchAccounts(nameOrEmailAddress))?
            .responseObject(_do(completion))
    }
    
    public func getTalks(topicId: TopicID, completion: GetTalksCompletionBlock) {
        _request(Router.GetTalks(topicId))?
            .responseObject(_do(completion))
    }

    public func getTalk(topicId: TopicID, talkId: TalkID, count: Int?, from: PostID?, direction: MessageDirection?, completion: GetTalkCompletionBlock) {
        let form = GetTalkForm(count: count, from: from, direction: direction)
        _request(Router.GetTalk(topicId, talkId, form))?
            .responseObject(_do(completion))
    }

    public func downloadAttachment(topicId: TopicID, postId: PostID, attachmentId: AttachmentID, filename: String, type: AttachmentType?, completion: DownloadAttachmentCompletionBlock) {
        _request(Router.DownloadAttachment(topicId, postId, attachmentId, filename, type))?
            .response { (_, _, data, error) in
                completion(data as? NSData, error)
        }
    }

    public func downloadAttachmentWithURL(url: NSURL, type: AttachmentType?, completion: DownloadAttachmentWithURLCompletionBlock) {
        _request(Router.DownloadAttachmentWithURL(url, type))?
            .response { (_, _, data, error) in
                completion(data as? NSData, error)
            }
    }

    private func _do<T>(comp: (T?, NSError?) -> Void) -> ((NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) {
        return { (_, _, t, e) in comp(t, e) }
    }
}

