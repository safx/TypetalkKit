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

    private init() {
        self.requestModifierForTests = nil
    }

    public typealias RequestModifier = ((Router) -> NSURLRequest)
    public init(requestModifierForTests: RequestModifier) {
        self.requestModifierForTests = requestModifierForTests
    }
    let requestModifierForTests: RequestModifier?

    var streamingClosure : (StreamingEvent -> ())?

    // MARK: OAuth2

    internal var oauth2 = OAuth2Client()
    public var isInitialized: Bool {
        return oauth2.isInitialized
    }
    public var isSignedIn: Bool {
        return oauth2.isSignedIn
    }
    public var accessToken: String? {
        return oauth2.accessToken
    }
    public func setDeveloperSettings(clientId clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) -> Bool {
        return oauth2.setDeveloperSettings(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI, scopes: scopes)
    }
    public func restoreTokenFromAccountStore() -> Bool {
        return oauth2.restoreTokenFromAccountStore()
    }
    public func authorize(completion: OAuth2Client.CompletionClosure) {
        oauth2.authorize(completion)
    }
    public func isRedirectURL(url: NSURL) -> Bool {
        return oauth2.isRedirectURL(url)
    }
    public func authorizationDone(URL url: NSURL) -> Bool {
        return oauth2.authorizationDone(URL: url)
    }
    public func requestRefreshToken(completion: OAuth2Client.CompletionClosure) -> Bool {
        return oauth2.requestRefreshToken(completion)
    }

    // MARK: Alamofire

    private func _request(router: Router) -> Request? {
        if let mod = requestModifierForTests {
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
        if let mod = requestModifierForTests {
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
    public func getProfile(completion: GetProfileCompletionClosure) {
        _request(Router.GetProfile)?
            .responseObject(nil as GetProfileResponse?, completion)
    }

    public func getTopics(completion: GetTopicsCompletionClosure) {
        _request(Router.GetTopics)?
            .responseObject(nil as GetTopicsResponse?, completion)
    }

    public func getMessages(topicId: TopicID, count: Int?, from: PostID?, direction: MessageDirection?, completion: GetMessagesCompletionClosure) {
        _request(Router.GetMessages(topicId: topicId, count: count, from: from, direction: direction))?
            .responseObject(nil as GetMessagesResponse?, completion)
    }

    public func postMessage(topicId: TopicID, message: String, replyTo: PostID?, fileKeys: [String], talkIds: [TalkID], completion: PostMessageCompletionClosure) {
        _request(Router.PostMessage(topicId: topicId, message: message, replyTo: replyTo, fileKeys: fileKeys, talkIds: talkIds))?
            .responseObject(nil as PostMessageResponse?, completion)
    }

    public func uploadAttachment(topicId: TopicID, fileName: String, fileContent: NSData, completion: UploadAttachmentCompletionClosure) {
        _upload(Router.UploadAttachment(topicId: topicId), fileName: fileName, fileContent: fileContent)?
            .responseObject(nil as UploadAttachmentResponse?, completion)
    }

    public func getTopicMembers(topicId: TopicID, completion: GetTopicMembersCompletionClosure) {
        _request(Router.GetTopicMembers(topicId: topicId))?
            .responseObject(nil as GetTopicMembersResponse?, completion)
    }

    public func getMessage(topicId: TopicID, postId: PostID, completion: GetMessageCompletionClosure) {
        _request(Router.GetMessage(topicId: topicId, postId: postId))?
            .responseObject(nil as GetMessageResponse?, completion)
    }

    public func deleteMessage(topicId: TopicID, postId: PostID, completion: DeleteMessageCompletionClosure) {
        _request(Router.DeleteMessage(topicId: topicId, postId: postId))?
            .responseObject(nil as DeleteMessageResponse?, completion)
    }

    public func likeMessage(topicId: TopicID, postId: PostID, completion: LikeMessageCompletionClosure) {
        _request(Router.LikeMessage(topicId: topicId, postId: postId))?
            .responseObject(nil as LikeMessageResponse?, completion)
    }

    public func unlikeMessage(topicId: TopicID, postId: PostID, completion: UnlikeMessageCompletionClosure) {
        _request(Router.UnlikeMessage(topicId: topicId, postId: postId))?
            .responseObject(nil as UnlikeMessageResponse?, completion)
    }

    public func favoriteTopic(topicId: TopicID, completion: FavoriteTopicCompletionClosure) {
        _request(Router.FavoriteTopic(topicId: topicId))?
            .responseObject(nil as FavoriteTopicResponse?, completion)
    }

    public func unfavoriteTopic(topicId: TopicID, completion: UnfavoriteTopicCompletionClosure) {
        _request(Router.UnfavoriteTopic(topicId: topicId))?
            .responseObject(nil as UnfavoriteTopicResponse?, completion)
    }

    public func getNotifications(completion: GetNotificationsCompletionClosure) {
        _request(Router.GetNotifications)?
            .responseObject(nil as GetNotificationsResponse?, completion)
    }

    public func getNotificationStatus(completion: GetNotificationStatusCompletionClosure) {
        _request(Router.GetNotificationStatus)?
            .responseObject(nil as GetNotificationStatusResponse?, completion)
    }

    public func openNotification(completion: OpenNotificationCompletionClosure) {
        _request(Router.OpenNotification)?
            .responseObject(nil as OpenNotificationResponse?, completion)
    }

    public func saveReadTopic(topicId: TopicID, postId: PostID?, completion: SaveReadTopicCompletionClosure) {
        _request(Router.SaveReadTopic(topicId: topicId, postId: postId))?
            .responseObject(nil as SaveReadTopicResponse?, completion)
    }

    public func getMentions(from: MentionID?, unread: Bool?, completion: GetMentionsCompletionClosure) {
        _request(Router.GetMentions(from: from, unread: unread))?
            .responseObject(nil as GetMentionsResponse?, completion)
    }

    public func saveReadMention(mentionId: MentionID, completion: SaveReadMentionCompletionClosure) {
        _request(Router.SaveReadMention(mentionId: mentionId))?
            .responseObject(nil as SaveReadMentionResponse?, completion)
    }

    public func acceptTeamInvite(teamId: TeamID, inviteId: InviteID, completion: AcceptTeamInviteCompletionClosure) {
        _request(Router.AcceptTeamInvite(teamId: teamId, inviteId: inviteId))?
            .responseObject(nil as AcceptTeamInviteResponse?, completion)
    }

    public func declineTeamInvite(teamId: TeamID, inviteId: InviteID, completion: DeclineTeamInviteCompletionClosure) {
        _request(Router.DeclineTeamInvite(teamId: teamId, inviteId: inviteId))?
            .responseObject(nil as DeclineTeamInviteResponse?, completion)
    }

    public func acceptTopicInvite(topicId: TopicID, inviteId: InviteID, completion: AcceptTopicInviteCompletionClosure) {
        _request(Router.AcceptTopicInvite(topicId: topicId, inviteId: inviteId))?
            .responseObject(nil as AcceptTopicInviteResponse?, completion)
    }

    public func declineTopicInvite(topicId: TopicID, inviteId: InviteID, completion: DeclineTopicInviteCompletionClosure) {
        _request(Router.DeclineTopicInvite(topicId: topicId, inviteId: inviteId))?
            .responseObject(nil as DeclineTopicInviteResponse?, completion)
    }

    public func createTopic(name: String, teamId: TeamID?, inviteMembers: [String], inviteMessage: String, completion: CreateTopicCompletionClosure) {
        _request(Router.CreateTopic(name: name, teamId: teamId, inviteMembers: inviteMembers, inviteMessage: inviteMessage))?
            .responseObject(nil as CreateTopicResponse?, completion)
    }

    public func updateTopic(topicId: TopicID, name: String, teamId: TeamID?, completion: UpdateTopicCompletionClosure) {
        _request(Router.UpdateTopic(topicId: topicId, name: name, teamId: teamId))?
            .responseObject(nil as UpdateTopicResponse?, completion)
    }

    public func deleteTopic(topicId: TopicID, completion: DeleteTopicCompletionClosure) {
        _request(Router.DeleteTopic(topicId: topicId))?
            .responseObject(nil as DeleteTopicResponse?, completion)
    }

    public func getTopicDetails(topicId: TopicID, completion: GetTopicDetailsCompletionClosure) {
        _request(Router.GetTopicDetails(topicId: topicId))?
            .responseObject(nil as GetTopicDetailsResponse?, completion)
    }

    public func inviteTopicMember(topicId: TopicID, inviteNames: [String], inviteMessage: String, completion: InviteTopicMemberCompletionClosure) {
        _request(Router.InviteTopicMember(topicId: topicId, inviteMembers: inviteNames, inviteMessage: inviteMessage))?
            .responseObject(nil as InviteTopicMemberResponse?, completion)
    }

    public func removeTopicMember(topicId: TopicID, removeInviteIds: [InviteID], removeMemberIds: [AccountID], completion: RemoveTopicMemberCompletionClosure) {
        _request(Router.RemoveTopicMember(topicId: topicId, removeInviteIds: removeInviteIds, removeMemberIds: removeMemberIds))?
            .responseObject(nil as RemoveTopicMemberResponse?, completion)
    }

    public func getTeams(completion: GetTeamsCompletionClosure) {
        _request(Router.GetTeams)?
            .responseObject(nil as GetTeamsResponse?, completion)
    }

    public func getFriends(completion: GetFriendsCompletionClosure) {
        _request(Router.GetFriends)?
            .responseObject(nil as GetFriendsResponse?, completion)
    }

    public func searchAccounts(nameOrEmailAddress: String, completion: SearchAccountsCompletionClosure) {
        _request(Router.SearchAccounts(nameOrEmailAddress: nameOrEmailAddress))?
            .responseObject(nil as SearchAccountsResponse?, completion)
    }

    public func getTalks(topicId: TopicID, completion: GetTalksCompletionClosure) {
        _request(Router.GetTalks(topicId: topicId))?
            .responseObject(nil as GetTalksResponse?, completion)
    }

    public func getTalk(topicId: TopicID, talkId: TalkID, count: Int?, from: PostID?, direction: MessageDirection?, completion: GetTalkCompletionClosure) {
        _request(Router.GetTalk(topicId: topicId, talkId: talkId, count: count, from: from, direction: direction))?
            .responseObject(nil as GetTalkResponse?, completion)
    }

    public func createTalk(topicId: TopicID, talkName: String, postIds: [Int], completion: CreateTalkCompletionClosure) {
        _request(Router.CreateTalk(topicId: topicId, talkName: talkName, postIds: postIds))?
            .responseObject(nil as CreateTalkResponse?, completion)
    }



    public func downloadAttachment(topicId: TopicID, postId: PostID, attachmentId: AttachmentID, filename: String, type: AttachmentType?, completion: DownloadAttachmentCompletionClosure) {
        _request(Router.DownloadAttachment(topicId: topicId, postId: postId, attachmentId: attachmentId, filename: filename, type: type))?
            .response { (_, _, data, error) in
                completion(data as? NSData, error)
        }
    }

    public func downloadAttachmentWithURL(url: NSURL, type: AttachmentType?, completion: DownloadAttachmentWithURLCompletionClosure) {
        guard let route = Router.makeDownloadAttachment(url, attachmentType: type) else { return }
        _request(route)?
            .response { (_, _, data, error) in
                completion(data as? NSData, error)
            }
    }
}
