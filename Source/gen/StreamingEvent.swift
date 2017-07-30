// This file was auto-generated from StreamingEvent.swift with swift-idl.

import Foundation


public enum StreamingEvent {
	case connected
	case disconnected(NSError?)
	case addTalkPost(AddTalkPostEvent)
	case createTalk(CreateTalkEvent)
	case createTopic(CreateTopicEvent)
	case deleteTalk(DeleteTalkEvent)
	case deleteTopic(DeleteTopicEvent)
	case deleteMessage(DeleteMessageEvent)
	case favoriteTopic(FavoriteTopicEvent)
	case joinTopics(JoinTopicsEvent)
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

	static func parse(type: String, data: Data) throws -> StreamingEvent? {
		let decoder = JSONDecoder()
		if type == "addTalkPost" { return .addTalkPost(try decoder.decode(AddTalkPostEvent.self, from: data)) }
		if type == "createTalk" { return .createTalk(try decoder.decode(CreateTalkEvent.self, from: data)) }
		if type == "createTopic" { return .createTopic(try decoder.decode(CreateTopicEvent.self, from: data)) }
		if type == "deleteTalk" { return .deleteTalk(try decoder.decode(DeleteTalkEvent.self, from: data)) }
		if type == "deleteTopic" { return .deleteTopic(try decoder.decode(DeleteTopicEvent.self, from: data)) }
		if type == "deleteMessage" { return .deleteMessage(try decoder.decode(DeleteMessageEvent.self, from: data)) }
		if type == "favoriteTopic" { return .favoriteTopic(try decoder.decode(FavoriteTopicEvent.self, from: data)) }
		if type == "joinTopics" { return .joinTopics(try decoder.decode(JoinTopicsEvent.self, from: data)) }
		if type == "likeMessage" { return .likeMessage(try decoder.decode(LikeMessageEvent.self, from: data)) }
		if type == "notifyMention" { return .notifyMention(try decoder.decode(NotifyMentionEvent.self, from: data)) }
		if type == "postMessage" { return .postMessage(try decoder.decode(PostMessageEvent.self, from: data)) }
		if type == "postLinks" { return .postLinks(try decoder.decode(PostLinksEvent.self, from: data)) }
		if type == "readMention" { return .readMention(try decoder.decode(ReadMentionEvent.self, from: data)) }
		if type == "removeTalkPost" { return .removeTalkPost(try decoder.decode(RemoveTalkPostEvent.self, from: data)) }
		if type == "requestTeamInvite" { return .requestTeamInvite(try decoder.decode(RequestTeamInviteEvent.self, from: data)) }
		if type == "requestTopicInvite" { return .requestTopicInvite(try decoder.decode(RequestTopicInviteEvent.self, from: data)) }
		if type == "saveBookmark" { return .saveBookmark(try decoder.decode(SaveBookmarkEvent.self, from: data)) }
		if type == "updateNotificationAccess" { return .updateNotificationAccess(try decoder.decode(UpdateNotificationAccessEvent.self, from: data)) }
		if type == "unfavoriteTopic" { return .unfavoriteTopic(try decoder.decode(UnfavoriteTopicEvent.self, from: data)) }
		if type == "unlikeMessage" { return .unlikeMessage(try decoder.decode(UnlikeMessageEvent.self, from: data)) }
		if type == "updateTalk" { return .updateTalk(try decoder.decode(UpdateTalkEvent.self, from: data)) }
		if type == "updateTopic" { return .updateTopic(try decoder.decode(UpdateTopicEvent.self, from: data)) }
		return nil // FIXME
	}
}

