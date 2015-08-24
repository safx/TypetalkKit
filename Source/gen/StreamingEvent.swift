// This file was auto-generated from StreamingEvent.swift with swift-idl.

import Foundation


public enum StreamingEvent {
	case Connected
	case Disconnected(NSError?)
	case AcceptTeamInvite(AcceptTeamInviteEvent)
	case AcceptTopicInvite(AcceptTopicInviteEvent)
	case AddTalkPost(AddTalkPostEvent)
	case CancelTopicInvite(CancelTopicInviteEvent)
	case CreateTalk(CreateTalkEvent)
	case CreateTopic(CreateTopicEvent)
	case DeclineTeamInvite(DeclineTeamInviteEvent)
	case DeclineTopicInvite(DeclineTopicInviteEvent)
	case DeleteTalk(DeleteTalkEvent)
	case DeleteTopic(DeleteTopicEvent)
	case DeleteMessage(DeleteMessageEvent)
	case FavoriteTopic(FavoriteTopicEvent)
	case JoinTopics(JoinTopicsEvent)
	case LeaveTopics(LeaveTopicsEvent)
	case LikeMessage(LikeMessageEvent)
	case NotifyMention(NotifyMentionEvent)
	case PostMessage(PostMessageEvent)
	case PostLinks(PostLinksEvent)
	case ReadMention(ReadMentionEvent)
	case RemoveTalkPost(RemoveTalkPostEvent)
	case RequestTeamInvite(RequestTeamInviteEvent)
	case RequestTopicInvite(RequestTopicInviteEvent)
	case SaveBookmark(SaveBookmarkEvent)
	case UpdateNotificationAccess(UpdateNotificationAccessEvent)
	case UnfavoriteTopic(UnfavoriteTopicEvent)
	case UnlikeMessage(UnlikeMessageEvent)
	case UpdateTalk(UpdateTalkEvent)
	case UpdateTopic(UpdateTopicEvent)
	case Unknown(String, String: [AnyObject])

	static func parse(type: String, data:[String:AnyObject]) throws -> StreamingEvent? {
		if type == "acceptTeamInvite" { return .AcceptTeamInvite(try AcceptTeamInviteEvent.parseJSON(data)) }
		if type == "acceptTopicInvite" { return .AcceptTopicInvite(try AcceptTopicInviteEvent.parseJSON(data)) }
		if type == "addTalkPost" { return .AddTalkPost(try AddTalkPostEvent.parseJSON(data)) }
		if type == "cancelTopicInvite" { return .CancelTopicInvite(try CancelTopicInviteEvent.parseJSON(data)) }
		if type == "createTalk" { return .CreateTalk(try CreateTalkEvent.parseJSON(data)) }
		if type == "createTopic" { return .CreateTopic(try CreateTopicEvent.parseJSON(data)) }
		if type == "declineTeamInvite" { return .DeclineTeamInvite(try DeclineTeamInviteEvent.parseJSON(data)) }
		if type == "declineTopicInvite" { return .DeclineTopicInvite(try DeclineTopicInviteEvent.parseJSON(data)) }
		if type == "deleteTalk" { return .DeleteTalk(try DeleteTalkEvent.parseJSON(data)) }
		if type == "deleteTopic" { return .DeleteTopic(try DeleteTopicEvent.parseJSON(data)) }
		if type == "deleteMessage" { return .DeleteMessage(try DeleteMessageEvent.parseJSON(data)) }
		if type == "favoriteTopic" { return .FavoriteTopic(try FavoriteTopicEvent.parseJSON(data)) }
		if type == "joinTopics" { return .JoinTopics(try JoinTopicsEvent.parseJSON(data)) }
		if type == "leaveTopics" { return .LeaveTopics(try LeaveTopicsEvent.parseJSON(data)) }
		if type == "likeMessage" { return .LikeMessage(try LikeMessageEvent.parseJSON(data)) }
		if type == "notifyMention" { return .NotifyMention(try NotifyMentionEvent.parseJSON(data)) }
		if type == "postMessage" { return .PostMessage(try PostMessageEvent.parseJSON(data)) }
		if type == "postLinks" { return .PostLinks(try PostLinksEvent.parseJSON(data)) }
		if type == "readMention" { return .ReadMention(try ReadMentionEvent.parseJSON(data)) }
		if type == "removeTalkPost" { return .RemoveTalkPost(try RemoveTalkPostEvent.parseJSON(data)) }
		if type == "requestTeamInvite" { return .RequestTeamInvite(try RequestTeamInviteEvent.parseJSON(data)) }
		if type == "requestTopicInvite" { return .RequestTopicInvite(try RequestTopicInviteEvent.parseJSON(data)) }
		if type == "saveBookmark" { return .SaveBookmark(try SaveBookmarkEvent.parseJSON(data)) }
		if type == "updateNotificationAccess" { return .UpdateNotificationAccess(try UpdateNotificationAccessEvent.parseJSON(data)) }
		if type == "unfavoriteTopic" { return .UnfavoriteTopic(try UnfavoriteTopicEvent.parseJSON(data)) }
		if type == "unlikeMessage" { return .UnlikeMessage(try UnlikeMessageEvent.parseJSON(data)) }
		if type == "updateTalk" { return .UpdateTalk(try UpdateTalkEvent.parseJSON(data)) }
		if type == "updateTopic" { return .UpdateTopic(try UpdateTopicEvent.parseJSON(data)) }
		return nil // FIXME
	}
}

