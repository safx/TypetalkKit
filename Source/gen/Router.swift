// This file was auto-generated from Router.swift with swift-idl.

import Foundation

public enum Router: CustomStringConvertible {
    case GetProfile
    case GetTopics
    case GetMessages(topicId: TopicID, count: Int?, from: PostID?, direction: MessageDirection?)
    case PostMessage(topicId: TopicID, message: String, replyTo: Int?, fileKeys: [String], talkIds: [TalkID])
    case UploadAttachment(topicId: TopicID)
    case GetTopicMembers(topicId: TopicID)
    case GetMessage(topicId: TopicID, postId: PostID)
    case DeleteMessage(topicId: TopicID, postId: PostID)
    case LikeMessage(topicId: TopicID, postId: PostID)
    case UnlikeMessage(topicId: TopicID, postId: PostID)
    case FavoriteTopic(topicId: TopicID)
    case UnfavoriteTopic(topicId: TopicID)
    case GetNotifications
    case GetNotificationStatus
    case OpenNotification
    case SaveReadTopic(topicId: TopicID, postId: PostID?)
    case GetMentions(from: MentionID?, unread: Bool?)
    case SaveReadMention(mentionId: MentionID)
    case AcceptTeamInvite(teamId: TeamID, inviteId: InviteID)
    case DeclineTeamInvite(teamId: TeamID, inviteId: InviteID)
    case AcceptTopicInvite(topicId: TopicID, inviteId: InviteID)
    case DeclineTopicInvite(topicId: TopicID, inviteId: InviteID)
    case CreateTopic(name: String, teamId: TeamID?, inviteMembers: [String], inviteMessage: String)
    case UpdateTopic(topicId: TopicID, name: String?, teamId: TeamID?)
    case DeleteTopic(topicId: TopicID)
    case GetTopicDetails(topicId: TopicID)
    case InviteTopicMember(topicId: TopicID, inviteMembers: [String], inviteMessage: String?)
    case RemoveTopicMember(topicId: TopicID, removeInviteIds: [InviteID], removeMemberIds: [AccountID])
    case GetTeams
    case GetFriends
    case SearchAccounts(nameOrEmailAddress: String)
    case GetTalks(topicId: TopicID)
    case GetTalk(topicId: TopicID, talkId: TalkID, count: Int?, from: PostID?, direction: MessageDirection?)
    case CreateTalk(topicId: TopicID, talkName: String, postIds: [Int])
    case DownloadAttachment(topicId: TopicID, postId: PostID, attachmentId: AttachmentID, filename: String, type: AttachmentType?)
    case Streaming

    public var method: String {
        switch self {
        case .GetProfile: return "GET"
        case .GetTopics: return "GET"
        case .GetMessages: return "GET"
        case .PostMessage: return "POST"
        case .UploadAttachment: return "POST"
        case .GetTopicMembers: return "GET"
        case .GetMessage: return "GET"
        case .DeleteMessage: return "DELETE"
        case .LikeMessage: return "POST"
        case .UnlikeMessage: return "DELETE"
        case .FavoriteTopic: return "POST"
        case .UnfavoriteTopic: return "DELETE"
        case .GetNotifications: return "GET"
        case .GetNotificationStatus: return "GET"
        case .OpenNotification: return "PUT"
        case .SaveReadTopic: return "PUT"
        case .GetMentions: return "GET"
        case .SaveReadMention: return "PUT"
        case .AcceptTeamInvite: return "POST"
        case .DeclineTeamInvite: return "POST"
        case .AcceptTopicInvite: return "POST"
        case .DeclineTopicInvite: return "POST"
        case .CreateTopic: return "POST"
        case .UpdateTopic: return "PUT"
        case .DeleteTopic: return "DELETE"
        case .GetTopicDetails: return "GET"
        case .InviteTopicMember: return "POST"
        case .RemoveTopicMember: return "POST"
        case .GetTeams: return "GET"
        case .GetFriends: return "GET"
        case .SearchAccounts: return "GET"
        case .GetTalks: return "GET"
        case .GetTalk: return "GET"
        case .CreateTalk: return "POST"
        case .DownloadAttachment: return "GET"
        case .Streaming: return "GET"
        }
    }
    public var path: String {
        switch self {
        case .GetProfile: return "profile"
        case .GetTopics: return "topics"
        case .GetMessages(let (topicId, _, _, _)): return "topics/\(topicId)"
        case .PostMessage(let (topicId, _, _, _, _)): return "topics/\(topicId)"
        case .UploadAttachment(let (topicId)): return "topics/\(topicId)/attachments"
        case .GetTopicMembers(let (topicId)): return "topics/\(topicId)/members/status"
        case .GetMessage(let (topicId, postId)): return "topics/\(topicId)/posts/\(postId)"
        case .DeleteMessage(let (topicId, postId)): return "topics/\(topicId)/posts/\(postId)"
        case .LikeMessage(let (topicId, postId)): return "topics/\(topicId)/posts/\(postId)/like"
        case .UnlikeMessage(let (topicId, postId)): return "topics/\(topicId)/posts/\(postId)/like"
        case .FavoriteTopic(let (topicId)): return "topics/\(topicId)/favorite"
        case .UnfavoriteTopic(let (topicId)): return "topics/\(topicId)/favorite"
        case .GetNotifications: return "notifications"
        case .GetNotificationStatus: return "notifications/status"
        case .OpenNotification: return "notifications"
        case .SaveReadTopic: return "bookmarks"
        case .GetMentions: return "mentions"
        case .SaveReadMention(let (mentionId)): return "mentions/\(mentionId)"
        case .AcceptTeamInvite(let (teamId, inviteId)): return "teams/\(teamId)/members/invite/\(inviteId)/accept"
        case .DeclineTeamInvite(let (teamId, inviteId)): return "teams/\(teamId)/members/invite/\(inviteId)/decline"
        case .AcceptTopicInvite(let (topicId, inviteId)): return "topics/\(topicId)/members/invite/\(inviteId)/accept"
        case .DeclineTopicInvite(let (topicId, inviteId)): return "topics/\(topicId)/members/invite/\(inviteId)/decline"
        case .CreateTopic: return "topics"
        case .UpdateTopic(let (topicId, _, _)): return "topics/\(topicId)"
        case .DeleteTopic(let (topicId)): return "topics/\(topicId)"
        case .GetTopicDetails(let (topicId)): return "topics/\(topicId)/details"
        case .InviteTopicMember(let (topicId, _, _)): return "topics/\(topicId)/members/invite"
        case .RemoveTopicMember(let (topicId, _, _)): return "topics/\(topicId)/members/remove"
        case .GetTeams: return "teams"
        case .GetFriends: return "search/friends"
        case .SearchAccounts: return "search/accounts"
        case .GetTalks(let (topicId)): return "topics/\(topicId)/talks"
        case .GetTalk(let (topicId, talkId, _, _, _)): return "topics/\(topicId)/talks/\(talkId)/posts"
        case .CreateTalk(let (topicId, _, _)): return "topics/\(topicId)/talks"
        case .DownloadAttachment(let (topicId, postId, attachmentId, filename, _)): return "topics/\(topicId)/posts/\(postId)/attachments/\(attachmentId)/\(filename)"
        case .Streaming: return "streaming"
        }
    }
    public var params: [String: AnyObject] {
        switch self {
        case .GetProfile:
            return [:]
        case .GetTopics:
            return [:]
        case .GetMessages(let (_, count, from, direction)):
            var p: [String: AnyObject] = [:]
            count.map { p["count"] = $0.toJSON() }
            from.map { p["from"] = $0.toJSON() }
            direction.map { p["direction"] = $0.toJSON() }
            return p
        case .PostMessage(let (_, message, replyTo, fileKeys, talkIds)):
            var p: [String: AnyObject] = ["message": message.toJSON(), "fileKeys": fileKeys.map { $0.toJSON() }, "talkIds": talkIds.map { $0.toJSON() }]
            replyTo.map { p["replyTo"] = $0.toJSON() }
            return p
        case .UploadAttachment:
            return [:]
        case .GetTopicMembers:
            return [:]
        case .GetMessage:
            return [:]
        case .DeleteMessage:
            return [:]
        case .LikeMessage:
            return [:]
        case .UnlikeMessage:
            return [:]
        case .FavoriteTopic:
            return [:]
        case .UnfavoriteTopic:
            return [:]
        case .GetNotifications:
            return [:]
        case .GetNotificationStatus:
            return [:]
        case .OpenNotification:
            return [:]
        case .SaveReadTopic(let (topicId, postId)):
            var p: [String: AnyObject] = ["topicId": topicId.toJSON()]
            postId.map { p["postId"] = $0.toJSON() }
            return p
        case .GetMentions(let (from, unread)):
            var p: [String: AnyObject] = [:]
            from.map { p["from"] = $0.toJSON() }
            unread.map { p["unread"] = $0.toJSON() }
            return p
        case .SaveReadMention:
            return [:]
        case .AcceptTeamInvite:
            return [:]
        case .DeclineTeamInvite:
            return [:]
        case .AcceptTopicInvite:
            return [:]
        case .DeclineTopicInvite:
            return [:]
        case .CreateTopic(let (name, teamId, inviteMembers, inviteMessage)):
            var p: [String: AnyObject] = ["name": name.toJSON(), "inviteMembers": inviteMembers.map { $0.toJSON() }, "inviteMessage": inviteMessage.toJSON()]
            teamId.map { p["teamId"] = $0.toJSON() }
            return p
        case .UpdateTopic(let (_, name, teamId)):
            var p: [String: AnyObject] = [:]
            name.map { p["name"] = $0.toJSON() }
            teamId.map { p["teamId"] = $0.toJSON() }
            return p
        case .DeleteTopic:
            return [:]
        case .GetTopicDetails:
            return [:]
        case .InviteTopicMember(let (_, inviteMembers, inviteMessage)):
            var p: [String: AnyObject] = ["inviteMembers": inviteMembers.map { $0.toJSON() }]
            inviteMessage.map { p["inviteMessage"] = $0.toJSON() }
            return p
        case .RemoveTopicMember(let (_, removeInviteIds, removeMemberIds)):
            return ["removeInviteIds": removeInviteIds.map { $0.toJSON() }, "removeMemberIds": removeMemberIds.map { $0.toJSON() }]
        case .GetTeams:
            return [:]
        case .GetFriends:
            return [:]
        case .SearchAccounts(let (nameOrEmailAddress)):
            return ["nameOrEmailAddress": nameOrEmailAddress.toJSON()]
        case .GetTalks:
            return [:]
        case .GetTalk(let (_, _, count, from, direction)):
            var p: [String: AnyObject] = [:]
            count.map { p["count"] = $0.toJSON() }
            from.map { p["from"] = $0.toJSON() }
            direction.map { p["direction"] = $0.toJSON() }
            return p
        case .CreateTalk(let (_, talkName, postIds)):
            return ["talkName": talkName.toJSON(), "postIds": postIds.map { $0.toJSON() }]
        case .DownloadAttachment(let (_, _, _, _, type)):
            var p: [String: AnyObject] = [:]
            type.map { p["type"] = $0.toJSON() }
            return p
        case .Streaming:
            return [:]
        }
    }

    public var description: String {
        switch self {
        case .GetProfile: return "GetProfile"
        case .GetTopics: return "GetTopics"
        case .GetMessages(let v): return "GetMessages(topicId=\(v.0), count=\(v.1), from=\(v.2), direction=\(v.3))"
        case .PostMessage(let v): return "PostMessage(topicId=\(v.0), message=\(v.1), replyTo=\(v.2), fileKeys=\(v.3), talkIds=\(v.4))"
        case .UploadAttachment(let v): return "UploadAttachment(topicId=\(v))"
        case .GetTopicMembers(let v): return "GetTopicMembers(topicId=\(v))"
        case .GetMessage(let v): return "GetMessage(topicId=\(v.0), postId=\(v.1))"
        case .DeleteMessage(let v): return "DeleteMessage(topicId=\(v.0), postId=\(v.1))"
        case .LikeMessage(let v): return "LikeMessage(topicId=\(v.0), postId=\(v.1))"
        case .UnlikeMessage(let v): return "UnlikeMessage(topicId=\(v.0), postId=\(v.1))"
        case .FavoriteTopic(let v): return "FavoriteTopic(topicId=\(v))"
        case .UnfavoriteTopic(let v): return "UnfavoriteTopic(topicId=\(v))"
        case .GetNotifications: return "GetNotifications"
        case .GetNotificationStatus: return "GetNotificationStatus"
        case .OpenNotification: return "OpenNotification"
        case .SaveReadTopic(let v): return "SaveReadTopic(topicId=\(v.0), postId=\(v.1))"
        case .GetMentions(let v): return "GetMentions(from=\(v.0), unread=\(v.1))"
        case .SaveReadMention(let v): return "SaveReadMention(mentionId=\(v))"
        case .AcceptTeamInvite(let v): return "AcceptTeamInvite(teamId=\(v.0), inviteId=\(v.1))"
        case .DeclineTeamInvite(let v): return "DeclineTeamInvite(teamId=\(v.0), inviteId=\(v.1))"
        case .AcceptTopicInvite(let v): return "AcceptTopicInvite(topicId=\(v.0), inviteId=\(v.1))"
        case .DeclineTopicInvite(let v): return "DeclineTopicInvite(topicId=\(v.0), inviteId=\(v.1))"
        case .CreateTopic(let v): return "CreateTopic(name=\(v.0), teamId=\(v.1), inviteMembers=\(v.2), inviteMessage=\(v.3))"
        case .UpdateTopic(let v): return "UpdateTopic(topicId=\(v.0), name=\(v.1), teamId=\(v.2))"
        case .DeleteTopic(let v): return "DeleteTopic(topicId=\(v))"
        case .GetTopicDetails(let v): return "GetTopicDetails(topicId=\(v))"
        case .InviteTopicMember(let v): return "InviteTopicMember(topicId=\(v.0), inviteMembers=\(v.1), inviteMessage=\(v.2))"
        case .RemoveTopicMember(let v): return "RemoveTopicMember(topicId=\(v.0), removeInviteIds=\(v.1), removeMemberIds=\(v.2))"
        case .GetTeams: return "GetTeams"
        case .GetFriends: return "GetFriends"
        case .SearchAccounts(let v): return "SearchAccounts(nameOrEmailAddress=\(v))"
        case .GetTalks(let v): return "GetTalks(topicId=\(v))"
        case .GetTalk(let v): return "GetTalk(topicId=\(v.0), talkId=\(v.1), count=\(v.2), from=\(v.3), direction=\(v.4))"
        case .CreateTalk(let v): return "CreateTalk(topicId=\(v.0), talkName=\(v.1), postIds=\(v.2))"
        case .DownloadAttachment(let v): return "DownloadAttachment(topicId=\(v.0), postId=\(v.1), attachmentId=\(v.2), filename=\(v.3), type=\(v.4))"
        case .Streaming: return "Streaming"
        }
    }
}


