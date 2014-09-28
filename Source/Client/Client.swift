//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/18.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Alamofire


public class Client {
    public typealias GetProfileCompletionBlock = ((Account?, NSError?) -> Void)
    public typealias GetTopicsCompletionBlock = (([TopicWithUserInfo]?, NSError?) -> Void)
    public typealias GetMessagesCompletionBlock = ((Messages?, NSError?) -> Void)
    public typealias PostMessagesCompletionBlock = (((Topic, Post)?, NSError?) -> Void)
    public typealias UploadAttachmentCompletionBlock = ((Attachment?, NSError?) -> Void)
    public typealias GetTopicMembersCompletionBlock = ((([Account], [Account])?, NSError?) -> Void)
    public typealias GetMessageCompletionBlock = ((DetailedMessage?, NSError?) -> Void)
    public typealias DeleteMessageCompletionBlock = ((Post?, NSError?) -> Void)
    public typealias LikeMessageCompletionBlock = ((Like?, NSError?) -> Void)
    public typealias UnlikeMessageCompletionBlock = ((Like?, NSError?) -> Void)
    public typealias FavoriteTopicCompletionBlock = (((Topic, Bool)?, NSError?) -> Void)
    public typealias UnfavoriteTopicCompletionBlock = (((Topic, Bool)?, NSError?) -> Void)
    public typealias GetNotificationsCompletionBlock = ((Notifications?, NSError?) -> Void)
    public typealias GetNotificationStatusCompletionBlock = ((NotificationStatus?, NSError?) -> Void)
    public typealias OpenNotificationCompletionBlock = ((NotificationStatus?, NSError?) -> Void)
    public typealias SaveReadTopicCompletionBlock = ((Unread?, NSError?) -> Void)
    public typealias GetMentionsCompletionBlock = (([Mention]?, NSError?) -> Void)
    public typealias SaveReadMentionCompletionBlock = ((Mention?, NSError?) -> Void)
    public typealias AcceptTeamInviteCompletionBlock = ((([Topic], TeamInvite)?, NSError?) -> Void)
    public typealias DeclineTeamInviteCompletionBlock = ((TeamInvite?, NSError?) -> Void)
    public typealias AcceptTopicInviteCompletionBlock = ((TopicInvite?, NSError?) -> Void)
    public typealias DeclineTopicInviteCompletionBlock = ((TopicInvite?, NSError?) -> Void)
    public typealias CreateTopicCompletionBlock = ((TopicWithAccounts?, NSError?) -> Void)
    public typealias UpdateTopicCompletionBlock = ((TopicWithAccounts?, NSError?) -> Void)
    public typealias DeleteTopicCompletionBlock = ((Topic?, NSError?) -> Void)
    public typealias GetTopicDetailsCompletionBlock = ((TopicWithAccounts?, NSError?) -> Void)
    public typealias InviteTopicMemberCompletionBlock = ((TopicWithAccounts?, NSError?) -> Void)
    public typealias RemoveTopicMemberCompletionBlock = ((TopicWithAccounts?, NSError?) -> Void)
    public typealias GetTeamsCompletionBlock = (([(Team, Int)]?, NSError?) -> Void)
    public typealias GetFriendsCompletionBlock = (([Account]?, NSError?) -> Void)
    public typealias SearchAccountsCompletionBlock = ((Account?, NSError?) -> Void)
    public typealias GetTalksCompletionBlock = (([Talk]?, NSError?) -> Void)
    public typealias GetTalkCompletionBlock = ((TalkMessages?, NSError?) -> Void)
    
    public class var sharedClient : Client {
        struct Static {
            static let instance : Client = Client()
        }
        return Static.instance
    }
    
    // MARK: OAuth2
    
    private var oauth2 = OAuth2Client()
    public var isInitialized: Bool {
        return oauth2.isInitialized
    }
    public var isSignedIn: Bool {
        return oauth2.isSignedIn
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

    // MARK: Typetalk API
    
    typealias APICompletionBlock = (([String: AnyObject]?, NSError?) -> Void)

    private func _request(router: Router, completion: APICompletionBlock) -> Bool {
        switch oauth2.state {
        case .SignedIn(let (credential)):
            Alamofire.request(router.URLRequest(credential.accessToken))
                .responseJSON { (request, response, json, error) -> Void in completion(json as [String: AnyObject]?, error) }
            return true
        default:
            // TODO: send error to completion block
            return false
        }
    }

    private func _upload(router: Router, fileName: String, fileContent: NSData, completion: APICompletionBlock) -> Bool {
        switch oauth2.state {
        case .SignedIn(let (credential)):
            Alamofire.request(router.URLRequest(credential.accessToken, fileName: fileName, fileContent: fileContent))
                .responseJSON { (request, response, json, error) -> Void in completion(json as [String: AnyObject]?, error) }
            return true
        default:
            // TODO: send error to completion block
            return false
        }
    }
}

// MARK: APIs

extension Client {

    public func getProfile(completion: GetProfileCompletionBlock) {
        _request(Router.GetProfile) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetProfile(json!), nil)
        }
    }

    public func getTopics(completion: GetTopicsCompletionBlock) {
        _request(Router.GetTopics) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetTopics(json!), nil)
        }
    }

    public func getMessages(topicId: TopicID, completion: GetMessagesCompletionBlock) {
        _request(Router.GetMessages(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetMessages(json!), nil)
        }
    }

    public func postMessages(topicId: TopicID, message: String, replyTo: PostID?, fileKeys: [String], talkIds: [TalkID], completion: PostMessagesCompletionBlock) {
        let form = PostMessageForm(message: message, replyTo: replyTo, fileKeys: fileKeys, talkIds: talkIds)
        _request(Router.PostMessage(topicId, form)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parsePostMessage(json!), nil)
        }
    }
    
    public func uploadAttachment(topicId: TopicID, fileName: String, fileContent: NSData, completion: UploadAttachmentCompletionBlock) {
        _upload(Router.UploadAttachment(topicId), fileName: fileName, fileContent: fileContent) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseUploadAttachment(json!), nil)
        }
    }

    public func getTopicMembers(topicId: TopicID, completion: GetTopicMembersCompletionBlock) {
        _request(Router.GetTopicMembers(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetTopicMembers(json!), nil)
        }
    }

    public func getMessage(topicId: TopicID, postId: PostID, completion: GetMessageCompletionBlock) {
        _request(Router.GetMessage(topicId, postId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetMessage(json!), nil)
        }
    }

    public func deleteMessage(topicId: TopicID, postId: PostID, completion: DeleteMessageCompletionBlock) {
        _request(Router.DeleteMessage(topicId, postId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseDeleteMessage(json!), nil)
        }
    }

    public func likeMessage(topicId: TopicID, postId: PostID, completion: LikeMessageCompletionBlock) {
        _request(Router.LikeMessage(topicId, postId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseLikeMessage(json!), nil)
        }
    }

    public func unlikeMessage(topicId: TopicID, postId: PostID, completion: UnlikeMessageCompletionBlock) {
        _request(Router.UnlikeMessage(topicId, postId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseUnlikeMessage(json!), nil)
        }
    }

    public func favoriteTopic(topicId: TopicID, completion: FavoriteTopicCompletionBlock) {
        _request(Router.FavoriteTopic(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseFavoriteTopic(json!), nil)
        }
    }

    public func unfavoriteTopic(topicId: TopicID, completion: UnfavoriteTopicCompletionBlock) {
        _request(Router.UnfavoriteTopic(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseUnfavoriteTopic(json!), nil)
        }
    }

    public func getNotifications(completion: GetNotificationsCompletionBlock) {
        _request(Router.GetNotifications) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetNotifications(json!), nil)
        }
    }
    
    public func getNotificationStatus(completion: GetNotificationStatusCompletionBlock) {
        _request(Router.GetNotificationStatus) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetNotificationStatus(json!), nil)
        }
    }
    
    public func openNotification(completion: OpenNotificationCompletionBlock) {
        _request(Router.OpenNotification) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseOpenNotification(json!), nil)
        }
    }
    
    public func saveReadTopic(topicId: TopicID, postId: PostID?, completion: SaveReadTopicCompletionBlock) {
        _request(Router.SaveReadTopic(topicId, postId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseSaveReadTopic(json!), nil)
        }
    }
    
    public func getMentions(from: MentionID?, unread: Bool?, completion: GetMentionsCompletionBlock) {
        _request(Router.GetMentions(from, unread)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetMentions(json!), nil)
        }
    }

    public func saveReadMention(mentionId: MentionID, completion: SaveReadMentionCompletionBlock) {
        _request(Router.SaveReadMention(mentionId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseSaveReadMention(json!), nil)
        }
    }
    
    public func acceptTeamInvite(teamId: TeamID, inviteId: InviteID, completion: AcceptTeamInviteCompletionBlock) {
        _request(Router.AcceptTeamInvite(teamId, inviteId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseAcceptTeamInvite(json!), nil)
        }
    }

    public func declineTeamInvite(teamId: TeamID, inviteId: InviteID, completion: DeclineTeamInviteCompletionBlock) {
        _request(Router.DeclineTeamInvite(teamId, inviteId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseDeclineTeamInvite(json!), nil)
        }
    }

    public func acceptTopicInvite(teamId: TopicID, inviteId: InviteID, completion: AcceptTopicInviteCompletionBlock) {
        _request(Router.AcceptTopicInvite(teamId, inviteId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseAcceptTopicInvite(json!), nil)
        }
    }
    
    public func declineTopicInvite(teamId: TopicID, inviteId: InviteID, completion: DeclineTopicInviteCompletionBlock) {
        _request(Router.DeclineTopicInvite(teamId, inviteId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseDeclineTopicInvite(json!), nil)
        }
    }
    
    public func createTopic(name: String, teamId: TeamID?, inviteMembers: [String], inviteMessage: String, completion: CreateTopicCompletionBlock) {
        let form = CreateTopicForm(name: name, teamId: teamId, inviteMembers: inviteMembers, inviteMessage: inviteMessage)
        _request(Router.CreateTopic(form)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseCreateTopic(json!), nil)
        }
    }

    public func updateTopic(topicId: TopicID, name: String, teamId: TeamID?, completion: UpdateTopicCompletionBlock) {
        _request(Router.UpdateTopic(topicId, name, teamId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseUpdateTopic(json!), nil)
        }
    }

    public func deleteTopic(topicId: TopicID, completion: DeleteTopicCompletionBlock) {
        _request(Router.DeleteTopic(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseDeleteTopic(json!), nil)
        }
    }

    public func getTopicDetails(topicId: TopicID, completion: GetTopicDetailsCompletionBlock) {
        _request(Router.GetTopicDetails(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetTopicDetails(json!), nil)
        }
    }

    public func inviteTopicMember(topicId: TopicID, inviteName: [String], inviteMessage: String, completion: InviteTopicMemberCompletionBlock) {
        _request(Router.InviteTopicMember(topicId, inviteName, inviteMessage)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseInviteTopicMember(json!), nil)
        }
    }

    public func removeTopicMember(topicId: TopicID, removeInviteIds: [InviteID], removeMemberIds: [AccountID], completion: RemoveTopicMemberCompletionBlock) {
        _request(Router.RemoveTopicMember(topicId, removeInviteIds, removeMemberIds)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseRemoveTopicMember(json!), nil)
        }
    }

    public func getTeams(completion: GetTeamsCompletionBlock) {
        _request(Router.GetTeams) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetTeams(json!), nil)
        }
    }

    public func getFriends(completion: GetFriendsCompletionBlock) {
        _request(Router.GetFriends) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetFriends(json!), nil)
        }
    }

    public func searchAccounts(nameOrEmailAddress: String, completion: SearchAccountsCompletionBlock) {
        _request(Router.SearchAccounts(nameOrEmailAddress)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseSearchAccounts(json!), nil)
        }
    }

    public func getTalks(topicId: TopicID, completion: GetTalksCompletionBlock) {
        _request(Router.GetTalks(topicId)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetTalks(json!), nil)
        }
    }

    public func getTalk(topicId: TopicID, talkId: TalkID, count: Int?, from: PostID?, direction: String?, completion: GetTalkCompletionBlock) {
        let form = GetTalkForm(count: count, from: from, direction: direction)
        _request(Router.GetTalk(topicId, talkId, form)) { (json, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            completion(self._parseGetTalk(json!), nil)
        }
    }
}

// MARK: API parser

extension Client {

    // public access for tests
    public func _parseGetProfile(json: [String:AnyObject]) -> Account {
        var err: NSError? = nil
        let dic = json["account"] as NSDictionary
        return Account(dictionary: dic, error: &err)
    }

    public func _parseGetTopics(json: [String:AnyObject]) -> [TopicWithUserInfo] {
        var err: NSError? = nil
        let arr = json["topics"] as NSArray
        
        var topics: [TopicWithUserInfo] = []
        for i in arr as [NSDictionary] {
            let t = TopicWithUserInfo(dictionary: i, error: &err)
            if err != nil { break }
            topics.append(t)
        }
        return topics
    }

    public func _parseGetMessages(json: [String:AnyObject]) -> Messages {
        var err: NSError? = nil
        return Messages(dictionary: json, error: &err)
    }

    public func _parsePostMessage(json: [String:AnyObject]) -> (Topic, Post) {
        var err: NSError? = nil
        let topic = Topic(dictionary: json["topic"] as NSDictionary, error: &err)
        let post = Post(dictionary: json["post"] as NSDictionary, error: &err)
        
        return (topic, post)
    }
    
    public func _parseUploadAttachment(json: [String:AnyObject]) -> Attachment {
        var err: NSError? = nil
        let dic = json as NSDictionary
        return Attachment(dictionary: dic, error: &err)
    }

    public func _parseGetTopicMembers(json: [String:AnyObject]) -> ([Account], [Account]) {
        var err: NSError? = nil
        let arr1 = json["accounts"] as NSArray
        let arr2 = json["pendings"] as NSArray
        
        var accounts: [Account] = []
        var pendings: [Account] = []
        for i in arr1 as [NSDictionary] {
            let t = Account(dictionary: i["account"] as NSDictionary, error: &err)
            if err != nil { break }
            accounts.append(t)
        }
        for i in arr2 as [NSDictionary] {
            let t = Account(dictionary: i["account"] as NSDictionary, error: &err)
            if err != nil { break }
            pendings.append(t)
        }
        return (accounts, pendings)
    }
    
    public func _parseGetMessage(json: [String:AnyObject]) -> DetailedMessage {
        var err: NSError? = nil
        return DetailedMessage(dictionary: json, error: &err)
    }

    public func _parseDeleteMessage(json: [String:AnyObject]) -> Post {
        var err: NSError? = nil
        return Post(dictionary: json, error: &err)
    }

    public func _parseLikeMessage(json: [String:AnyObject]) -> Like {
        var err: NSError? = nil
        return Like(dictionary: json["like"] as NSDictionary, error: &err)
    }

    public func _parseUnlikeMessage(json: [String:AnyObject]) -> Like {
        var err: NSError? = nil
        return Like(dictionary: json["like"] as NSDictionary, error: &err)
    }

    public func _parseFavoriteTopic(json: [String:AnyObject]) -> (Topic, Bool) {
        var err: NSError? = nil
        let topic = Topic(dictionary: json["topic"] as NSDictionary, error: &err)
        let favorite = (json["favorite"] as NSNumber).boolValue
        return (topic, favorite)
    }

    public func _parseUnfavoriteTopic(json: [String:AnyObject]) -> (Topic, Bool) {
        var err: NSError? = nil
        let topic = Topic(dictionary: json["topic"] as NSDictionary, error: &err)
        let favorite = (json["favorite"] as NSNumber).boolValue
        return (topic, favorite)
    }

    public func _parseGetNotifications(json: [String:AnyObject]) -> Notifications {
        var err: NSError? = nil
        return Notifications(dictionary: json, error: &err)
    }

    public func _parseGetNotificationStatus(json: [String:AnyObject]) -> NotificationStatus {
        var err: NSError? = nil
        return NotificationStatus(dictionary: json, error: &err)
    }

    public func _parseOpenNotification(json: [String:AnyObject]) -> NotificationStatus {
        var err: NSError? = nil
        return NotificationStatus(dictionary: json, error: &err)
    }
    
    public func _parseSaveReadTopic(json: [String:AnyObject]) -> Unread {
        var err: NSError? = nil
        return Unread(dictionary: json["unread"] as NSDictionary, error: &err)
    }
    
    public func _parseGetMentions(json: [String:AnyObject]) -> [Mention] {
        var err: NSError? = nil
        let arr = json["mentions"] as NSArray
        
        var mentions: [Mention] = []
        for i in arr as [NSDictionary] {
            let mention = Mention(dictionary: i, error: &err)
            if err != nil { break }
            mentions.append(mention)
        }
        return mentions
    }

    public func _parseSaveReadMention(json: [String:AnyObject]) -> Mention {
        var err: NSError? = nil
        return Mention(dictionary: json["mention"] as NSDictionary, error: &err)
    }
    
    public func _parseAcceptTeamInvite(json: [String:AnyObject]) -> ([Topic], TeamInvite) {
        var err: NSError? = nil
        let arr = json["topics"] as NSArray
        let invite = TeamInvite(dictionary: json["invite"] as NSDictionary, error: &err)
        
        var topics: [Topic] = []
        for i in arr as [NSDictionary] {
            let t = Topic(dictionary: i as NSDictionary, error: &err)
            if err != nil { break }
            topics.append(t)
        }
        return (topics, invite)
    }

    public func _parseDeclineTeamInvite(json: [String:AnyObject]) -> TeamInvite {
        var err: NSError? = nil
        return TeamInvite(dictionary: json as NSDictionary, error: &err)
    }

    public func _parseAcceptTopicInvite(json: [String:AnyObject]) -> TopicInvite {
        var err: NSError? = nil
        return TopicInvite(dictionary: json["invite"] as NSDictionary, error: &err)
    }

    public func _parseDeclineTopicInvite(json: [String:AnyObject]) -> TopicInvite {
        var err: NSError? = nil
        return TopicInvite(dictionary: json["invite"] as NSDictionary, error: &err)
    }
    
    public func _parseCreateTopic(json: [String:AnyObject]) -> TopicWithAccounts {
        var err: NSError? = nil
        return TopicWithAccounts(dictionary: json, error: &err)
    }

    public func _parseUpdateTopic(json: [String:AnyObject]) -> TopicWithAccounts {
        var err: NSError? = nil
        return TopicWithAccounts(dictionary: json, error: &err)
    }

    public func _parseDeleteTopic(json: [String:AnyObject]) -> Topic {
        var err: NSError? = nil
        return Topic(dictionary: json, error: &err)
    }

    public func _parseGetTopicDetails(json: [String:AnyObject]) -> TopicWithAccounts {
        var err: NSError? = nil
        return TopicWithAccounts(dictionary: json, error: &err)
    }

    public func _parseInviteTopicMember(json: [String:AnyObject]) -> TopicWithAccounts {
        var err: NSError? = nil
        return TopicWithAccounts(dictionary: json, error: &err)
    }

    public func _parseRemoveTopicMember(json: [String:AnyObject]) -> TopicWithAccounts {
        var err: NSError? = nil
        return TopicWithAccounts(dictionary: json, error: &err)
    }

    public func _parseGetTeams(json: [String:AnyObject]) -> [(Team, Int)] {
        var err: NSError? = nil
        let arr = json["teams"] as NSArray
        
        var teams: [(Team, Int)] = []
        for i in arr as [NSDictionary] {
            let team = Team(dictionary: i["team"] as NSDictionary, error: &err)
            let count = i["memberCount"] as Int
            if err != nil { break }
            teams.append((team,count))
        }
        return teams
    }

    public func _parseGetFriends(json: [String:AnyObject]) -> [Account] {
        var err: NSError? = nil
        let arr = json["accounts"] as NSArray
        
        var accounts: [Account] = []
        for i in arr as [NSDictionary] {
            let a = Account(dictionary: i, error: &err)
            if err != nil { break }
            accounts.append(a)
        }
        return accounts
    }

    public func _parseSearchAccounts(json: [String:AnyObject]) -> Account {
        var err: NSError? = nil
        return Account(dictionary: json, error: &err)
    }

    public func _parseGetTalks(json: [String:AnyObject]) -> [Talk] {
        var err: NSError? = nil
        let arr = json["talks"] as NSArray
        
        var talks: [Talk] = []
        for i in arr as [NSDictionary] {
            let t = Talk(dictionary: i, error: &err)
            if err != nil { break }
            talks.append(t)
        }
        return talks
    }

    public func _parseGetTalk(json: [String:AnyObject]) -> TalkMessages {
        var err: NSError? = nil
        return TalkMessages(dictionary: json, error: &err)
    }
}
