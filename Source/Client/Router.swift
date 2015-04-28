//
//  Router.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire


public enum Router : URLRequestConvertible {
    private static let baseURLString = "https://typetalk.in/api/v1/"

    case GetProfile
    case GetTopics
    case GetMessages(TopicID, GetMessagesForm)
    case PostMessage(TopicID, PostMessageForm)
    case UploadAttachment(TopicID)
    case GetTopicMembers(TopicID)
    case GetMessage(TopicID, PostID)
    case DeleteMessage(TopicID, PostID)
    case LikeMessage(TopicID, PostID)
    case UnlikeMessage(TopicID, PostID)
    case FavoriteTopic(TopicID)
    case UnfavoriteTopic(TopicID)
    case GetNotifications
    case GetNotificationStatus
    case OpenNotification
    case SaveReadTopic(TopicID, PostID?)
    case GetMentions(MentionID?, Bool?)
    case SaveReadMention(MentionID)
    case AcceptTeamInvite(TeamID, InviteID)
    case DeclineTeamInvite(TeamID, InviteID)
    case AcceptTopicInvite(TopicID, InviteID)
    case DeclineTopicInvite(TopicID, InviteID)
    case CreateTopic(CreateTopicForm)
    case UpdateTopic(TopicID, TopicName?, TeamID?)
    case DeleteTopic(TopicID)
    case GetTopicDetails(TopicID)
    case InviteTopicMember(TopicID, [InviteName], Message)
    case RemoveTopicMember(TopicID, [InviteID], [AccountID])
    case GetTeams
    case GetFriends
    case SearchAccounts(String)
    case GetTalks(TopicID)
    case GetTalk(TopicID, TalkID, GetTalkForm)
    case DownloadAttachment(TopicID, PostID, AttachmentID, String, AttachmentType?)
    case DownloadAttachmentWithURL(NSURL, AttachmentType?)
    case Streaming


    private var methodAndPath: (Alamofire.Method, Scope, String) {
        switch self {
        case .GetProfile                                  : return (.GET   , .my          , "profile")
        case .GetTopics                                   : return (.GET   , .my          , "topics")
        case .GetMessages(let (topicId, _))               : return (.GET   , .topic_read  , "topics/\(topicId)")
        case .PostMessage(let (topicId, _))               : return (.POST  , .topic_post  , "topics/\(topicId)")
        case .UploadAttachment(let topicId)               : return (.POST  , .topic_post  , "topics/\(topicId)/attachments")
        case .GetTopicMembers(let topicId)                : return (.GET   , .topic_read  , "topics/\(topicId)/members/status")
        case .GetMessage(let (topicId, postId))           : return (.GET   , .topic_read  , "topics/\(topicId)/posts/\(postId)")
        case .DeleteMessage(let (topicId, postId) )       : return (.DELETE, .topic_post  , "topics/\(topicId)/posts/\(postId)")
        case .LikeMessage(let (topicId, postId))          : return (.POST  , .topic_post  , "topics/\(topicId)/posts/\(postId)/like")
        case .UnlikeMessage(let (topicId, postId))        : return (.DELETE, .topic_post  , "topics/\(topicId)/posts/\(postId)/like")
        case .FavoriteTopic(let topicId)                  : return (.POST  , .my          , "topics/\(topicId)/favorite")
        case .UnfavoriteTopic(let topicId)                : return (.DELETE, .my          , "topics/\(topicId)/favorite")
        case .GetNotifications                            : return (.GET   , .my          , "notifications")
        case .GetNotificationStatus                       : return (.GET   , .my          , "notifications/status")
        case .OpenNotification                            : return (.PUT   , .my          , "notifications")
        case .SaveReadTopic                               : return (.PUT   , .my          , "bookmarks")
        case .GetMentions                                 : return (.GET   , .my          , "mentions")
        case .SaveReadMention(let mentionId)              : return (.PUT   , .my          , "mentions/\(mentionId)")
        case .AcceptTeamInvite(let (teamId, inviteId))    : return (.POST  , .my          , "teams/\(teamId)/members/invite/\(inviteId)/accept")
        case .DeclineTeamInvite(let (teamId, inviteId))   : return (.POST  , .my          , "teams/\(teamId)/members/invite/\(inviteId)/decline")
        case .AcceptTopicInvite(let (topicId, inviteId))  : return (.POST  , .my          , "topics/\(topicId)/members/invite/\(inviteId)/accept")
        case .DeclineTopicInvite(let (topicId, inviteId)) : return (.POST  , .my          , "topics/\(topicId)/members/invite/\(inviteId)/decline")
        case .CreateTopic                                 : return (.POST  , .topic_write , "topics")
        case .UpdateTopic(let (topicId, _, _))            : return (.PUT   , .topic_write , "topics/\(topicId)")
        case .DeleteTopic(let topicId)                    : return (.DELETE, .topic_delete, "topics/\(topicId)")
        case .GetTopicDetails(let topicId)                : return (.GET   , .topic_read  , "topics/\(topicId)/details")
        case .InviteTopicMember(let (topicId, _, _))      : return (.POST  , .topic_write , "topics/\(topicId)/members/invite")
        case .RemoveTopicMember(let (topicId, _, _))      : return (.POST  , .topic_write , "topics/\(topicId)/members/remove")
        case .GetTeams                                    : return (.GET   , .my          , "teams")
        case .GetFriends                                  : return (.GET   , .my          , "search/friends")
        case .SearchAccounts                              : return (.GET   , .my          , "search/accounts")
        case .GetTalks(let topicId)                       : return (.GET   , .topic_read  , "topics/\(topicId)/talks")
        case .GetTalk(let (topicId, talkId, _))           : return (.GET   , .topic_read  , "topics/\(topicId)/talks/\(talkId)/posts")
        case .DownloadAttachment(let (topicId, postId, attachmentId, filename, _))
                                                          : return (.GET   , .topic_read  , "topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)")
        case .DownloadAttachmentWithURL(let (url, _)):
            let u = url.absoluteString!
            assert(u.hasPrefix(Router.baseURLString))
            let len = count(Router.baseURLString)
            let s = u.substringFromIndex(advance(u.startIndex, len))
            return (.GET, .topic_read, "\(s)")
        case .Streaming                                   : return (.GET   , .topic_read  , "streaming")
        }
    }

    private var parameters: [String: AnyObject] {
        switch self {
        case .GetMessages(let (_, form)):
            return form.toObject()
        case .PostMessage(let (_, form)):
            return form.toObject()
        case .SaveReadTopic(let (topicId, postId)):
            var p: [String: AnyObject] = [ "topicId": topicId ]
            postId.map { p["postId"] = $0 }
            return p
        case .GetMentions(let (from, unread)):
            var p: [String: AnyObject] = [:]
            from.map { p["from"] = $0 }
            unread.map { p["unread"] = $0 }
            return p
        case .CreateTopic(let form):
            return form.toObject()
        case .UpdateTopic(let (_, name, teamId)):
            var p: [String: AnyObject] = [ "teamId": teamId ?? ""]
            name.map { p["name"] = $0 }
            return p
        case InviteTopicMember(let (_, inviteNames, inviteMessage)):
            var p: [String: AnyObject] = [:]
            if count(inviteNames) > 0 { p["inviteMembers"] = inviteNames }
            if count(inviteMessage) > 0 { p["inviteMessage"] = inviteMessage }
            return p
        case .RemoveTopicMember(let (_, removeInviteIds, removeMemberIds)):
            var p: [String: AnyObject] = [:]
            if count(removeInviteIds) > 0 { p["removeInviteIds"] = removeInviteIds }
            if count(removeMemberIds) > 0 { p["removeMemberIds"] = removeMemberIds }
            return p
        case .SearchAccounts(let nameOrEmailAddress):
            return ["nameOrEmailAddress": nameOrEmailAddress]
        case .GetTalk(let (_, _, form)):
            return form.toObject()
        case .DownloadAttachment(let (_, _, _, _, type)):
            var p: [String: AnyObject] = [:]
            type.map { p["type"] = $0.rawValue }
            return p
        case .DownloadAttachmentWithURL(let (_, type)):
            var p: [String: AnyObject] = [:]
            type.map { p["type"] = $0.rawValue }
            return p
        default:
            return [:]
        }
    }

    private var method: Alamofire.Method {
        return methodAndPath.0
    }

    private var scope: Scope? {
        switch self {
        case .SearchAccounts:
            return nil // hack for compiler crushed on Scope?
        default:
            return methodAndPath.1
        }
    }

    private var path: String {
        return methodAndPath.2
    }

    public func checkScope(scopes: [Scope]) -> Bool {
        return scopes.filter{ $0 == self.scope }.count > 0
    }

    public var URLRequest: NSURLRequest {
        var request = NSMutableURLRequest(URL: (NSURL(string: Router.baseURLString + path))!)
        request.HTTPMethod = method.rawValue

        if parameters.isEmpty { return request }
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
    }

    public func URLRequest(OAuth2Token: String) -> NSURLRequest {
        var request = URLRequest.mutableCopy() as! NSMutableURLRequest
        request.setValue("Bearer \(OAuth2Token)", forHTTPHeaderField: "Authorization")
        return request
    }

    public func URLRequest(OAuth2Token: String, fileName: String, fileContent: NSData) -> NSURLRequest {
        func generateBoundary() -> String {
            let uuid = CFUUIDCreate(nil)
            let uuidString = CFUUIDCreateString(nil, uuid)
            return "Boundary-\(uuidString)"
        }

        let boundary = generateBoundary()
        let formData = NSMutableData()

        formData.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        formData.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        formData.appendData("Content-Type: application/octet-stream; charset=ISO-8859-1\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        formData.appendData("Content-Transfer-Encoding: binary\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        formData.appendData(fileContent)
        formData.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)

        var request = URLRequest(OAuth2Token).mutableCopy() as! NSMutableURLRequest
        assert(request.HTTPMethod == "POST")

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("\(formData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = formData

        return request
    }
}

public enum MessageDirection: String {
    case Backward = "backward"
    case Forward  = "forward"
}

public enum AttachmentType: String {
    case Small  = "small"
    case Medium = "medium"
    case Large  = "large"
}

public struct GetMessagesForm {
    let count: Int?
    let from: PostID?
    let direction: MessageDirection?

    public init(count: Int?, from: PostID?, direction: MessageDirection?) {
        self.count = count
        self.from = from
        self.direction = direction
    }
    private func toObject() -> [String: AnyObject] {
        var p = [String: AnyObject]()
        count.map { p["count"] = $0 }
        from.map { p["from"] = $0 }
        direction.map { p["direction"] = $0.rawValue }
        return p
    }
}
public typealias GetTalkForm = GetMessagesForm

public struct PostMessageForm {
    let message: String
    let replyTo: Int?
    let fileKeys: [String]
    let talkIds: [TalkID]

    public init(message: String, replyTo: PostID?, fileKeys: [String], talkIds: [TalkID]) {
        self.message = message
        self.replyTo = replyTo
        self.fileKeys = fileKeys
        self.talkIds = talkIds
    }
    private func toObject() -> [String: AnyObject] {
        var p: [String: AnyObject] = [ "message": message ]
        replyTo.map { p["replyTo"] = $0 }
        if count(fileKeys) > 0 { p["fileKeys"] = fileKeys }
        if count(talkIds) > 0 { p["talkIds"] = talkIds }
        return p
    }
}

public struct CreateTopicForm {
    let name: String
    let teamId: TeamID?
    let inviteMembers: [String]
    let inviteMessage: String

    public init(name: String, teamId: TeamID?, inviteMembers: [String], inviteMessage: String) {
        self.name = name
        self.teamId = teamId
        self.inviteMembers = inviteMembers
        self.inviteMessage = inviteMessage
    }
    private func toObject() -> [String: AnyObject] {
        var p: [String: AnyObject] = [ "name": name ]
        teamId.map { p["teamId"] = $0 }
        if count(inviteMembers) > 0 { p["inviteMembers"] = inviteMembers }
        if count(inviteMessage) > 0 { p["inviteMessage"] = inviteMessage }
        return p
    }
}
