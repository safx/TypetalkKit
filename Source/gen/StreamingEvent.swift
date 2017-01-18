// This file was auto-generated from StreamingEvent.swift with swift-idl.

import Foundation


public enum StreamingEvent {
	case connected
	case disconnected(NSError?)
	case acceptTeamInvite(AcceptTeamInviteEvent)
	case acceptTopicInvite(AcceptTopicInviteEvent)
	case addTalkPost(AddTalkPostEvent)
	case cancelTopicInvite(CancelTopicInviteEvent)
	case createTalk(CreateTalkEvent)
	case createTopic(CreateTopicEvent)
	case declineTeamInvite(DeclineTeamInviteEvent)
	case declineTopicInvite(DeclineTopicInviteEvent)
	case deleteTalk(DeleteTalkEvent)
	case deleteTopic(DeleteTopicEvent)
	case deleteMessage(DeleteMessageEvent)
	case favoriteTopic(FavoriteTopicEvent)
	case joinTopics(JoinTopicsEvent)
	case leaveTopics(LeaveTopicsEvent)
	case likeMessage(LikeMessageEvent)
	case notifyMention(NotifyMentionEvent)
	case postMessage(PostMessageEvent)
	case postLinks(PostLinksEvent)
	case readMention(ReadMentionEvent)
	case removeTalkPost(RemoveTalkPostEvent)
	case requestTeamInvite(RequestTeamInviteEvent)
	case requestTopicInvite(RequestTopicInviteEvent)
	case saveBookmark(SaveBookmarkEvent)
	case updateNotificationAccess(UpdateNotificationAccessEvent)
	case unfavoriteTopic(UnfavoriteTopicEvent)
	case unlikeMessage(UnlikeMessageEvent)
	case updateTalk(UpdateTalkEvent)
	case updateTopic(UpdateTopicEvent)
	case unknown(String, String: [AnyObject])

	static func parse(type: String, data: [String:AnyObject]) throws -> StreamingEvent? {
		if type == "acceptTeamInvite" { return .acceptTeamInvite(try AcceptTeamInviteEvent.parse(with: data)) }
		if type == "acceptTopicInvite" { return .acceptTopicInvite(try AcceptTopicInviteEvent.parse(with: data)) }
		if type == "addTalkPost" { return .addTalkPost(try AddTalkPostEvent.parse(with: data)) }
		if type == "cancelTopicInvite" { return .cancelTopicInvite(try CancelTopicInviteEvent.parse(with: data)) }
		if type == "createTalk" { return .createTalk(try CreateTalkEvent.parse(with: data)) }
		if type == "createTopic" { return .createTopic(try CreateTopicEvent.parse(with: data)) }
		if type == "declineTeamInvite" { return .declineTeamInvite(try DeclineTeamInviteEvent.parse(with: data)) }
		if type == "declineTopicInvite" { return .declineTopicInvite(try DeclineTopicInviteEvent.parse(with: data)) }
		if type == "deleteTalk" { return .deleteTalk(try DeleteTalkEvent.parse(with: data)) }
		if type == "deleteTopic" { return .deleteTopic(try DeleteTopicEvent.parse(with: data)) }
		if type == "deleteMessage" { return .deleteMessage(try DeleteMessageEvent.parse(with: data)) }
		if type == "favoriteTopic" { return .favoriteTopic(try FavoriteTopicEvent.parse(with: data)) }
		if type == "joinTopics" { return .joinTopics(try JoinTopicsEvent.parse(with: data)) }
		if type == "leaveTopics" { return .leaveTopics(try LeaveTopicsEvent.parse(with: data)) }
		if type == "likeMessage" { return .likeMessage(try LikeMessageEvent.parse(with: data)) }
		if type == "notifyMention" { return .notifyMention(try NotifyMentionEvent.parse(with: data)) }
		if type == "postMessage" { return .postMessage(try PostMessageEvent.parse(with: data)) }
		if type == "postLinks" { return .postLinks(try PostLinksEvent.parse(with: data)) }
		if type == "readMention" { return .readMention(try ReadMentionEvent.parse(with: data)) }
		if type == "removeTalkPost" { return .removeTalkPost(try RemoveTalkPostEvent.parse(with: data)) }
		if type == "requestTeamInvite" { return .requestTeamInvite(try RequestTeamInviteEvent.parse(with: data)) }
		if type == "requestTopicInvite" { return .requestTopicInvite(try RequestTopicInviteEvent.parse(with: data)) }
		if type == "saveBookmark" { return .saveBookmark(try SaveBookmarkEvent.parse(with: data)) }
		if type == "updateNotificationAccess" { return .updateNotificationAccess(try UpdateNotificationAccessEvent.parse(with: data)) }
		if type == "unfavoriteTopic" { return .unfavoriteTopic(try UnfavoriteTopicEvent.parse(with: data)) }
		if type == "unlikeMessage" { return .unlikeMessage(try UnlikeMessageEvent.parse(with: data)) }
		if type == "updateTalk" { return .updateTalk(try UpdateTalkEvent.parse(with: data)) }
		if type == "updateTopic" { return .updateTopic(try UpdateTopicEvent.parse(with: data)) }
		return nil // FIXME
	}
}

