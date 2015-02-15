//
//  Client+StreamingTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/15.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest
import Alamofire
import TypetalkKit


class ClientStreamingAPITests: XCTestCase {

    func testAcceptTeamInvite() {
        let model = AcceptTeamInviteEvent(data: streaming_json("acceptTeamInvite"))

        XCTAssertEqual(model.topics.count, 1)
        XCTAssertEqual(model.topics[0].name, "Sample topic")
        XCTAssertEqual(model.topics[0].createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.topics[0].updatedAt.description, "2014-10-06 15:04:07 +0000")

        XCTAssertEqual(model.invite!.id, 9999)
        XCTAssertEqual(model.invite!.team.id, 1000)
        XCTAssertEqual(model.invite!.team.name, "MyTeam")

        XCTAssertEqual(model.invite!.sender.id, 2222)
        XCTAssertEqual(model.invite!.sender.name, "someone")

        XCTAssertEqual(model.invite!.account!.id, 3333)
        XCTAssertEqual(model.invite!.account!.name, "user")

        XCTAssertEqual(model.invite!.role, "member")
        XCTAssertEqual(model.invite!.message, "Please join my team on Typetalk.")
    }

    func testAddTalkPost() {
        let model = AddTalkPostEvent(data: streaming_json("addTalkPost"))
    }

    func testCreateTalk() {
        let model = CreateTalkEvent(data: streaming_json("createTalk"))
    }

    func testCreateTopic() {
        let model = CreateTopicEvent(data: streaming_json("createTopic"))
    }

    func testDeclineTeamInvite() {
        let model = DeclineTeamInviteEvent(data: streaming_json("declineTeamInvite"))

        XCTAssertEqual(model.invite!.id, 9999)
        XCTAssertEqual(model.invite!.team.id, 1000)
        XCTAssertEqual(model.invite!.team.name, "MyTeam")

        XCTAssertEqual(model.invite!.sender.id, 2222)
        XCTAssertEqual(model.invite!.sender.name, "someone")

        XCTAssertEqual(model.invite!.account!.id, 3333)
        XCTAssertEqual(model.invite!.account!.name, "user")

        XCTAssertEqual(model.invite!.role, "member")
        XCTAssertEqual(model.invite!.message, "Please join my team on Typetalk.")
    }

    func testDeleteMessageEvent() {
        let model = DeleteMessageEvent(data: streaming_json("deleteMessage"))
    }

    func testDeleteTalkEvent() {
        let model = DeleteTalkEvent(data: streaming_json("deleteTalk"))
    }

    func testDeleteTopicEvent() {
        let model = DeleteTopicEvent(data: streaming_json("deleteTopic"))
    }

    func testFavoriteTopicEvent() {
        let model = FavoriteTopicEvent(data: streaming_json("favoriteTopic"))
    }

    func testJoinTopicsEvent() {
        let model = JoinTopicsEvent(data: streaming_json("joinTopics"))
    }

    func testLeaveTopicsEvent() {
        let model = LeaveTopicsEvent(data: streaming_json("leaveTopics"))
    }

    func testLikeMessageEvent() {
        let model = LikeMessageEvent(data: streaming_json("likeMessage"))
    }

    func testNotifyMentionEvent() {
        let model = NotifyMentionEvent(data: streaming_json("notifyMention"))
    }

    func testPostMessageEvent() {
        let model = PostMessageEvent(data: streaming_json("postMessage"))
    }

    func testReadMentionEvent() {
        let model = ReadMentionEvent(data: streaming_json("readMention"))
    }

    func testRemoveTalkPostEvent() {
        let model = RemoveTalkPostEvent(data: streaming_json("removeTalkPost"))
    }

    func testRequestTeamInviteEvent() {
        let model = RequestTeamInviteEvent(data: streaming_json("requestTeamInvite"))
    }

    func testSaveBookmarkEvent() {
        let model = SaveBookmarkEvent(data: streaming_json("saveBookmark"))
    }

    func testUnfavoriteTopicEvent() {
        let model = UnfavoriteTopicEvent(data: streaming_json("unfavoriteTopic"))
    }

    func testUnlikeMessageEvent() {
        let model = UnlikeMessageEvent(data: streaming_json("unlikeMessage"))
    }

    func testUpdateNotificationAccessEvent() {
        let model = UpdateNotificationAccessEvent(data: streaming_json("updateNotificationAccess"))
    }

    func testUpdateTalkEvent() {
        let model = UpdateTalkEvent(data: streaming_json("updateTalk"))
    }

    func testUpdateTopicEvent() {
        let model = UpdateTopicEvent(data: streaming_json("updateTopic"))
    }
}
