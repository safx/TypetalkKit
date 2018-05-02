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

	fileprivate struct WSEventTypeChecker: Decodable {
		let type: String
	}

	fileprivate struct WSEvent<T: Decodable>: Decodable {
		let type: String
		let data: T
	}

	static func parse(data: Data) throws -> StreamingEvent? {
		let decoder = JSONDecoder()
		if #available(OSX 10.12, iOS 10.0, *) {
			decoder.dateDecodingStrategy = .iso8601
		} else {
			fatalError("Please use newer macOS")
		}
		if let eventType = try? decoder.decode(WSEventTypeChecker.self, from: data) {
			let type = eventType.type
			if type == "addTalkPost" { let ev = try decoder.decode(WSEvent<AddTalkPostEvent>.self, from: data); return .addTalkPost(ev.data) }
			if type == "createTalk" { let ev = try decoder.decode(WSEvent<CreateTalkEvent>.self, from: data); return .createTalk(ev.data) }
			if type == "createTopic" { let ev = try decoder.decode(WSEvent<CreateTopicEvent>.self, from: data); return .createTopic(ev.data) }
			if type == "deleteTalk" { let ev = try decoder.decode(WSEvent<DeleteTalkEvent>.self, from: data); return .deleteTalk(ev.data) }
			if type == "deleteTopic" { let ev = try decoder.decode(WSEvent<DeleteTopicEvent>.self, from: data); return .deleteTopic(ev.data) }
			if type == "deleteMessage" { let ev = try decoder.decode(WSEvent<DeleteMessageEvent>.self, from: data); return .deleteMessage(ev.data) }
			if type == "favoriteTopic" { let ev = try decoder.decode(WSEvent<FavoriteTopicEvent>.self, from: data); return .favoriteTopic(ev.data) }
			if type == "joinTopics" { let ev = try decoder.decode(WSEvent<JoinTopicsEvent>.self, from: data); return .joinTopics(ev.data) }
			if type == "likeMessage" { let ev = try decoder.decode(WSEvent<LikeMessageEvent>.self, from: data); return .likeMessage(ev.data) }
			if type == "notifyMention" { let ev = try decoder.decode(WSEvent<NotifyMentionEvent>.self, from: data); return .notifyMention(ev.data) }
			if type == "postMessage" { let ev = try decoder.decode(WSEvent<PostMessageEvent>.self, from: data); return .postMessage(ev.data) }
			if type == "postLinks" { let ev = try decoder.decode(WSEvent<PostLinksEvent>.self, from: data); return .postLinks(ev.data) }
			if type == "readMention" { let ev = try decoder.decode(WSEvent<ReadMentionEvent>.self, from: data); return .readMention(ev.data) }
			if type == "removeTalkPost" { let ev = try decoder.decode(WSEvent<RemoveTalkPostEvent>.self, from: data); return .removeTalkPost(ev.data) }
			if type == "requestTeamInvite" { let ev = try decoder.decode(WSEvent<RequestTeamInviteEvent>.self, from: data); return .requestTeamInvite(ev.data) }
			if type == "requestTopicInvite" { let ev = try decoder.decode(WSEvent<RequestTopicInviteEvent>.self, from: data); return .requestTopicInvite(ev.data) }
			if type == "saveBookmark" { let ev = try decoder.decode(WSEvent<SaveBookmarkEvent>.self, from: data); return .saveBookmark(ev.data) }
			if type == "updateNotificationAccess" { let ev = try decoder.decode(WSEvent<UpdateNotificationAccessEvent>.self, from: data); return .updateNotificationAccess(ev.data) }
			if type == "unfavoriteTopic" { let ev = try decoder.decode(WSEvent<UnfavoriteTopicEvent>.self, from: data); return .unfavoriteTopic(ev.data) }
			if type == "unlikeMessage" { let ev = try decoder.decode(WSEvent<UnlikeMessageEvent>.self, from: data); return .unlikeMessage(ev.data) }
			if type == "updateTalk" { let ev = try decoder.decode(WSEvent<UpdateTalkEvent>.self, from: data); return .updateTalk(ev.data) }
			if type == "updateTopic" { let ev = try decoder.decode(WSEvent<UpdateTopicEvent>.self, from: data); return .updateTopic(ev.data) }
		}
		return nil // FIXME
	}
}

