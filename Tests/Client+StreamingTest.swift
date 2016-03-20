//
//  Client+StreamingTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/15.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import XCTest
import APIKit
@testable import TypetalkKit


class ClientStreamingAPITests: XCTestCase {

    func testAcceptTeamInvite() {
        let model = try! AcceptTeamInviteEvent.parseJSON(streaming_json("acceptTeamInvite"))

        XCTAssertEqual(model.topics.count, 1)
        XCTAssertEqual(model.topics[0].name, "Sample topic")
        XCTAssertEqual(model.topics[0].createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.topics[0].updatedAt.description, "2014-10-06 15:04:07 +0000")

        XCTAssertEqual(model.invite!.id, 9999)
        XCTAssertEqual(model.invite!.team!.id, 1000)
        XCTAssertEqual(model.invite!.team!.name, "MyTeam")

        XCTAssertEqual(model.invite!.sender!.id, 2222)
        XCTAssertEqual(model.invite!.sender!.name, "someone")

        XCTAssertEqual(model.invite!.account!.id, 3333)
        XCTAssertEqual(model.invite!.account!.name, "user")

        // FIXME: XCTAssertEqual(model.invite!.role, "member")
        XCTAssertEqual(model.invite!.message, "Please join my team on Typetalk.")
    }

    func testAddTalkPost() {
        let model = try! AddTalkPostEvent.parseJSON(streaming_json("addTalkPost"))

        XCTAssertEqual(model.topic.id, 10999)
        XCTAssertEqual(model.topic.name, "foo")
        XCTAssertEqual(model.topic.suggestion, "foo")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2015-02-15 11:48:37 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2015-02-15 11:41:49 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2015-02-15 11:41:49 +0000")

        XCTAssertEqual(model.talk.id, 8888)
        XCTAssertEqual(model.talk.topicId, 10999)
        XCTAssertEqual(model.talk.name, "bar")
        XCTAssertEqual(model.talk.suggestion, "bar")
        XCTAssertEqual(model.talk.createdAt.description, "2015-02-15 11:48:29 +0000")
        XCTAssertEqual(model.talk.updatedAt.description, "2015-02-15 11:48:40 +0000")

        XCTAssertEqual(model.postIds.count, 1)
        XCTAssertEqual(model.postIds[0], 998877)
    }

    func testCreateTalk() {
        let model = try! CreateTalkEvent.parseJSON(streaming_json("createTalk"))

        XCTAssertEqual(model.topic.id, 10000)
        XCTAssertEqual(model.topic.name, "Sample Topic")
        XCTAssertEqual(model.topic.suggestion, "Sample Topic")
        XCTAssertEqual(model.topic.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2015-02-15 11:14:24 +0000")

        XCTAssertEqual(model.talk.id, 8888)
        XCTAssertEqual(model.talk.topicId, 10000)
        XCTAssertEqual(model.talk.name, "SuperTalk")
        XCTAssertEqual(model.talk.suggestion, "SuperTalk")
        XCTAssertEqual(model.talk.createdAt.description, "2015-02-15 11:18:31 +0000")
        XCTAssertEqual(model.talk.updatedAt.description, "2015-02-15 11:18:31 +0000")

        XCTAssertEqual(model.postIds.count, 1)
        XCTAssertEqual(model.postIds[0], 999999)
    }

    func testCreateTopic() {
        let model = try! CreateTopicEvent.parseJSON(streaming_json("createTopic"))

        XCTAssertEqual(model.topic.id, 11111)
        XCTAssertEqual(model.topic.name, "Super Topic")
        XCTAssertEqual(model.topic.suggestion, "Super Topic")
        XCTAssertNil(model.topic.lastPostedAt)
        XCTAssertEqual(model.topic.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2015-02-15 11:12:37 +0000")

        XCTAssertTrue(model.favorite)

        XCTAssertEqual(model.unread!.topicId, 11111)
        XCTAssertEqual(model.unread!.postId, 777)
        XCTAssertEqual(model.unread!.count, 2)
    }

    func testDeclineTeamInvite() {
        let model = try! DeclineTeamInviteEvent.parseJSON(streaming_json("declineTeamInvite"))

        XCTAssertEqual(model.invite!.id, 9999)
        XCTAssertEqual(model.invite!.team!.id, 1000)
        XCTAssertEqual(model.invite!.team!.name, "MyTeam")
        XCTAssertEqual(model.invite!.team!.imageUrl.description, "https://typetalk.in/teams/1000/image.png?t=1412158606241")
        XCTAssertEqual(model.invite!.team!.createdAt.description, "2014-10-06 13:09:39 +0000")
        XCTAssertEqual(model.invite!.team!.updatedAt.description, "2014-10-06 13:19:46 +0000")

        XCTAssertEqual(model.invite!.sender!.id, 2222)
        XCTAssertEqual(model.invite!.sender!.name, "someone")
        XCTAssertEqual(model.invite!.sender!.fullName, "someone")
        XCTAssertEqual(model.invite!.sender!.suggestion, "someone")
        XCTAssertEqual(model.invite!.sender!.imageUrl.description, "https://typetalk.in/accounts/2222/profile_image.png?t=1414708327750")
        XCTAssertEqual(model.invite!.sender!.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.invite!.sender!.updatedAt.description, "2015-02-15 11:38:16 +0000")

        XCTAssertEqual(model.invite!.account!.id, 3333)
        XCTAssertEqual(model.invite!.account!.name, "user")
        XCTAssertEqual(model.invite!.account!.fullName, "user")
        XCTAssertEqual(model.invite!.account!.suggestion, "user")
        XCTAssertEqual(model.invite!.account!.imageUrl.description, "https://typetalk.in/accounts/3333/profile_image.png?t=1413127202468")
        XCTAssertEqual(model.invite!.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.invite!.account!.updatedAt.description, "2015-02-15 10:23:55 +0000")

        XCTAssertEqual(model.invite!.role!, "member")
        XCTAssertEqual(model.invite!.message, "Please join my team on Typetalk.")
        XCTAssertEqual(model.invite!.createdAt!.description, "2015-02-15 11:43:29 +0000")
        XCTAssertEqual(model.invite!.updatedAt!.description, "2015-02-15 11:44:03 +0000")
    }

    func testDeleteMessageEvent() {
        let model = try! DeleteMessageEvent.parseJSON(streaming_json("deleteMessage"))

        XCTAssertEqual(model.topic!.id, 11111)
        XCTAssertEqual(model.topic!.name, "foobar")
        XCTAssertEqual(model.topic!.suggestion, "foobar")
        XCTAssertEqual(model.topic!.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.topic!.updatedAt.description, "2015-02-15 11:14:24 +0000")

        XCTAssertEqual(model.post!.id, 999999)
        XCTAssertEqual(model.post!.topicId, 11111)
        XCTAssertNil(model.post!.replyTo)
        XCTAssertEqual(model.post!.message, "@someone hello")

        XCTAssertEqual(model.post!.account.id, 3333)
        XCTAssertEqual(model.post!.account.name, "user")
        XCTAssertEqual(model.post!.account.fullName, "user")
        XCTAssertEqual(model.post!.account.suggestion, "user")
        XCTAssertEqual(model.post!.account.imageUrl.absoluteString, "https://typetalk.in/accounts/3333/profile_image.png?t=1413127202468")
        XCTAssertEqual(model.post!.account.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.post!.account.updatedAt.description, "2015-02-15 10:23:55 +0000")

        //XCTAssertNil(model.post!.mention)

        XCTAssertEqual((model.post!.attachments).count, 0)
        XCTAssertEqual((model.post!.likes).count, 0)
        XCTAssertEqual((model.post!.talks).count, 1)
        XCTAssertEqual(model.post!.talks[0].id, 8888)
        XCTAssertEqual(model.post!.talks[0].topicId, 11111)
        XCTAssertEqual(model.post!.talks[0].name, "foo")
        XCTAssertEqual(model.post!.talks[0].suggestion, "foo")
        XCTAssertEqual(model.post!.talks[0].createdAt.description, "2015-02-15 11:18:31 +0000")
        XCTAssertEqual(model.post!.talks[0].updatedAt.description, "2015-02-15 11:18:31 +0000")
        XCTAssertEqual((model.post!.links).count, 0)

        XCTAssertEqual(model.post!.createdAt.description, "2015-02-15 11:17:05 +0000")
        XCTAssertEqual(model.post!.updatedAt.description, "2015-02-15 11:17:05 +0000")
    }

    func testDeleteTalkEvent() {
        let model = try! DeleteTalkEvent.parseJSON(streaming_json("deleteTalk"))

        XCTAssertEqual(model.topic.id, 3333)
        XCTAssertEqual(model.topic.name, "Sample topic")
        XCTAssertEqual(model.topic.suggestion, "Sample topic")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2015-02-15 11:11:09 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2014-10-04 10:02:33 +0000")

        XCTAssertEqual(model.talk.id, 8888)
        XCTAssertEqual(model.talk.topicId, 3333)
        XCTAssertEqual(model.talk.name, "SuperTalk")
        XCTAssertEqual(model.talk.suggestion, "SuperTalk")
        XCTAssertEqual(model.talk.createdAt.description, "2015-01-21 14:03:05 +0000")
        XCTAssertEqual(model.talk.updatedAt.description, "2015-02-15 11:25:51 +0000")
    }

    func testDeleteTopicEvent() {
        let model = try! DeleteTopicEvent.parseJSON(streaming_json("deleteTopic"))

        XCTAssertEqual(model.id, 11111)
        XCTAssertEqual(model.name, "Good Topic")
        XCTAssertEqual(model.suggestion, "Good Topic")
        XCTAssertEqual(model.lastPostedAt!.description, "2015-02-15 11:17:05 +0000")
        XCTAssertEqual(model.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.updatedAt.description, "2015-02-15 11:14:24 +0000")
    }

    func testFavoriteTopicEvent() {
        let model = try! FavoriteTopicEvent.parseJSON(streaming_json("favoriteTopic"))

        XCTAssertEqual(model.topic.id, 11111)
        XCTAssertEqual(model.topic.name, "Super Topic")
        XCTAssertEqual(model.topic.suggestion, "Super Topic")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2015-02-15 11:14:43 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2015-02-15 11:14:24 +0000")

        XCTAssertTrue(model.favorite)
    }

    func testJoinTopicsEvent() {
        let model = try! JoinTopicsEvent.parseJSON(streaming_json("joinTopics"))

        XCTAssertEqual(model.topics.count, 1)
        let topic = model.topics[0]

        XCTAssertEqual(topic.topic.id, 11111)
        XCTAssertEqual(topic.topic.name, "foo")
        XCTAssertEqual(topic.topic.suggestion, "foo")
        XCTAssertNil(topic.topic.lastPostedAt)
        XCTAssertEqual(topic.topic.createdAt.description, "2015-02-15 11:41:49 +0000")
        XCTAssertEqual(topic.topic.updatedAt.description, "2015-02-15 11:41:49 +0000")

        XCTAssertTrue(topic.favorite)

        XCTAssertEqual(topic.unread!.topicId, 11111)
        XCTAssertEqual(topic.unread!.postId, 0)
        XCTAssertEqual(topic.unread!.count, 0)
    }

    func testLeaveTopicsEvent() {
        let model = try! LeaveTopicsEvent.parseJSON(streaming_json("leaveTopics"))

        XCTAssertEqual(model.topics.count, 1)
        let topic = model.topics[0]

        XCTAssertEqual(topic.id, 8888)
        XCTAssertEqual(topic.name, "Sample topic")
        XCTAssertEqual(topic.suggestion, "Sample topic")
        XCTAssertNil(topic.lastPostedAt)
        XCTAssertEqual(topic.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(topic.updatedAt.description, "2014-10-06 15:04:07 +0000")
    }

    func testLikeMessageEvent() {
        let model = try! LikeMessageEvent.parseJSON(streaming_json("likeMessage"))

        XCTAssertEqual(model.like.id, 111111)
        XCTAssertEqual(model.like.postId, 999999)
        XCTAssertEqual(model.like.topicId, 3333)
        XCTAssertEqual(model.like.comment!, "")
        XCTAssertEqual(model.like.account!.id, 3333)
        XCTAssertEqual(model.like.account!.name, "someone")
        XCTAssertEqual(model.like.account!.fullName, "someone")
        XCTAssertEqual(model.like.account!.suggestion, "someone")
        XCTAssertEqual(model.like.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/3333/profile_image.png?t=1474613202128")
        XCTAssertEqual(model.like.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.like.account!.updatedAt.description, "2015-02-15 10:23:55 +0000")
    }

    func testNotifyMentionEvent() {
        let model = try! NotifyMentionEvent.parseJSON(streaming_json("notifyMention"))

        XCTAssertEqual(model.mention.id, 111111)
        XCTAssertNil(model.mention.readAt)
        XCTAssertEqual(model.mention.post!.id, 999999)
        XCTAssertEqual(model.mention.post!.topicId, 10033)
        XCTAssertNil(model.mention.post!.replyTo)
        XCTAssertEqual(model.mention.post!.message, "@someone hello")
        XCTAssertEqual(model.mention.post!.account.id, 3333)
        XCTAssertEqual(model.mention.post!.account.name, "user")
        XCTAssertEqual(model.mention.post!.createdAt.description, "2015-02-15 11:17:05 +0000")
        XCTAssertEqual(model.mention.post!.updatedAt.description, "2015-02-15 11:17:05 +0000")
    }

    func testPostMessageEvent() {
        let model = try! PostMessageEvent.parseJSON(streaming_json("postMessage"))

        XCTAssertEqual(model.topic!.id, 3333)
        XCTAssertEqual(model.topic!.name, "Sample topic")
        XCTAssertEqual(model.topic!.suggestion, "Sample topic")
        XCTAssertEqual(model.topic!.lastPostedAt!.description, "2015-02-15 11:11:09 +0000")
        XCTAssertEqual(model.topic!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.topic!.updatedAt.description, "2014-10-04 10:02:33 +0000")

        XCTAssertEqual(model.post!.id, 999999)
        XCTAssertEqual(model.post!.topicId, 3333)
        XCTAssertNil(model.post!.replyTo)
        XCTAssertEqual(model.post!.message, "How are you?")

        XCTAssertEqual(model.post!.account.id, 3333)
        XCTAssertEqual(model.post!.account.name, "user")
        XCTAssertEqual(model.post!.account.fullName, "user")
        XCTAssertEqual(model.post!.account.suggestion, "user")
        XCTAssertEqual(model.post!.account.imageUrl.absoluteString, "https://typetalk.in/accounts/3333/profile_image.png?t=1412123207468")
        XCTAssertEqual(model.post!.account.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.post!.account.updatedAt.description, "2015-02-15 10:23:55 +0000")

        //XCTAssertNil(model.post!.mention)

        XCTAssertEqual((model.post!.attachments).count, 0)
        XCTAssertEqual((model.post!.likes).count, 0)
        XCTAssertEqual((model.post!.talks).count, 0)
        XCTAssertEqual((model.post!.links).count, 0)

        XCTAssertEqual(model.post!.createdAt.description, "2015-02-15 11:11:09 +0000")
        XCTAssertEqual(model.post!.updatedAt.description, "2015-02-15 11:11:09 +0000")
    }

    func testPostLinksEvent() {
        let model = try! PostLinksEvent.parseJSON(streaming_json("postLinks"))

        XCTAssertEqual(model.postId, 567899)
        XCTAssertEqual(model.links.count, 1)
        XCTAssertEqual(model.links[0].id, 12345)
        XCTAssertEqual(model.links[0].url.absoluteString, "http://nulab-inc.com")
        XCTAssertEqual(model.links[0].contentType, "text/html; charset=UTF-8")
        XCTAssertEqual(model.links[0].title, "Fun. Creative. Collaboration. | Nulab Inc.")
        XCTAssertEqual(model.links[0].description, "We develop collaborative software tools aimed at facilitating effective work communication and collaboration.")
        XCTAssertEqual(model.links[0].imageUrl.absoluteString, "http://nulab-inc.com/ogp_dft.png")
        XCTAssertEqual(model.links[0].createdAt.description, "2015-02-19 14:28:17 +0000")
        XCTAssertEqual(model.links[0].updatedAt.description, "2015-02-19 14:28:17 +0000")
    }

    func testReadMentionEvent() {
        let model = try! ReadMentionEvent.parseJSON(streaming_json("readMention"))

        XCTAssertEqual(model.mention.id, 111111)
        XCTAssertEqual(model.mention.readAt!.description, "2015-02-15 11:47:18 +0000")
        XCTAssertEqual(model.mention.post!.id, 999999)
        XCTAssertEqual(model.mention.post!.topicId, 10999)
        XCTAssertNil(model.mention.post!.replyTo)
        XCTAssertEqual(model.mention.post!.message, "@user hello")
        XCTAssertEqual(model.mention.post!.account.id, 2222)
        XCTAssertEqual(model.mention.post!.account.name, "someone")
        XCTAssertEqual(model.mention.post!.account.fullName, "someone")
        XCTAssertEqual(model.mention.post!.account.suggestion, "someone")
        XCTAssertEqual(model.mention.post!.account.imageUrl.absoluteString, "https://typetalk.in/accounts/2222/profile_image.png?t=1418350277470")

        XCTAssertEqual((model.mention.post!.attachments).count, 0)
        XCTAssertEqual(model.mention.post!.createdAt.description, "2015-02-15 11:47:17 +0000")
        XCTAssertEqual(model.mention.post!.updatedAt.description, "2015-02-15 11:47:17 +0000")
    }

    func testRemoveTalkPostEvent() {
        let model = try! RemoveTalkPostEvent.parseJSON(streaming_json("removeTalkPost"))

        XCTAssertEqual(model.topic.id, 10999)
        XCTAssertEqual(model.topic.name, "foo")
        XCTAssertEqual(model.topic.suggestion, "foo")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2015-02-15 11:48:37 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2015-02-15 11:41:49 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2015-02-15 11:41:49 +0000")

        XCTAssertEqual(model.talk.id, 8888)
        XCTAssertEqual(model.talk.topicId, 10999)
        XCTAssertEqual(model.talk.name, "bar")
        XCTAssertEqual(model.talk.suggestion, "bar")
        XCTAssertEqual(model.talk.createdAt.description, "2015-02-15 11:48:29 +0000")
        XCTAssertEqual(model.talk.updatedAt.description, "2015-02-15 11:49:13 +0000")

        XCTAssertEqual(model.postIds.count, 1)
        XCTAssertEqual(model.postIds[0], 998877)
    }

    func testRequestTeamInviteEvent() {
        let model = try! RequestTeamInviteEvent.parseJSON(streaming_json("requestTeamInvite"))

        XCTAssertEqual(model.id, 9999)
        XCTAssertEqual(model.team!.id, 1000)
        XCTAssertEqual(model.team!.name, "Myteam")
        XCTAssertEqual(model.team!.imageUrl.description, "https://typetalk.in/teams/1000/image.png?t=1401581266241")
        XCTAssertEqual(model.team!.createdAt.description, "2014-10-06 13:09:39 +0000")
        XCTAssertEqual(model.team!.updatedAt.description, "2014-10-06 13:19:46 +0000")

        XCTAssertEqual(model.sender!.id, 2222)
        XCTAssertEqual(model.sender!.name, "someone")
        XCTAssertEqual(model.sender!.fullName, "someone")
        XCTAssertEqual(model.sender!.suggestion, "someone")
        XCTAssertEqual(model.sender!.imageUrl.description, "https://typetalk.in/accounts/2222/profile_image.png?t=1774704128350")
        XCTAssertEqual(model.sender!.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.sender!.updatedAt.description, "2015-02-15 11:38:16 +0000")

        XCTAssertEqual(model.account!.id, 3333)
        XCTAssertEqual(model.account!.name, "user")
        XCTAssertEqual(model.account!.fullName, "user")
        XCTAssertEqual(model.account!.suggestion, "user")
        XCTAssertEqual(model.account!.imageUrl.description, "https://typetalk.in/accounts/3333/profile_image.png?t=1420212137468")
        XCTAssertEqual(model.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.account!.updatedAt.description, "2015-02-15 10:23:55 +0000")

        // FIXME: XCTAssertEqual(model.role, "member")
        XCTAssertEqual(model.message, "Please join my team on Typetalk.")
        XCTAssertEqual(model.createdAt!.description, "2015-02-15 11:43:29 +0000")
        XCTAssertEqual(model.updatedAt!.description, "2015-02-15 11:43:29 +0000")
    }

    func testSaveBookmarkEvent() {
        let model = try! SaveBookmarkEvent.parseJSON(streaming_json("saveBookmark"))

        XCTAssertEqual(model.unread.topicId, 3333)
        XCTAssertEqual(model.unread.postId, 999999)
        XCTAssertEqual(model.unread.count, 0)
    }

    func testUnfavoriteTopicEvent() {
        let model = try! UnfavoriteTopicEvent.parseJSON(streaming_json("unfavoriteTopic"))

        XCTAssertEqual(model.topic.id, 11111)
        XCTAssertEqual(model.topic.name, "Super Topic")
        XCTAssertEqual(model.topic.suggestion, "Super Topic")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2015-02-15 11:14:43 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2015-02-15 11:14:24 +0000")

        XCTAssertFalse(model.favorite)
    }

    func testUnlikeMessageEvent() {
        let model = try! UnlikeMessageEvent.parseJSON(streaming_json("unlikeMessage"))

        XCTAssertEqual(model.like.id, 111111)
        XCTAssertEqual(model.like.postId, 999999)
        XCTAssertEqual(model.like.topicId, 3333)
        XCTAssertEqual(model.like.comment!, "")
        XCTAssertEqual(model.like.account!.id, 3333)
        XCTAssertEqual(model.like.account!.name, "user")
        XCTAssertEqual(model.like.account!.fullName, "user")
        XCTAssertEqual(model.like.account!.suggestion, "user")
        XCTAssertEqual(model.like.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/3333/profile_image.png?t=1413127420268")
        XCTAssertEqual(model.like.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.like.account!.updatedAt.description, "2015-02-15 10:23:55 +0000")
    }

    func testUpdateNotificationAccessEvent() {
        let model = try! UpdateNotificationAccessEvent.parseJSON(streaming_json("updateNotificationAccess"))

        XCTAssertEqual(model.access!.unopened!, 8)
        XCTAssertTrue(nil == model.mention)
        XCTAssertTrue(nil == model.invite)
    }

    func testUpdateTalkEvent() {
        let model = try! UpdateTalkEvent.parseJSON(streaming_json("updateTalk"))

        XCTAssertEqual(model.topic.id, 3333)
        XCTAssertEqual(model.topic.name, "Sample topic")
        XCTAssertEqual(model.topic.suggestion, "Sample topic")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2015-02-15 11:11:09 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2014-10-04 10:02:33 +0000")

        XCTAssertEqual(model.talk.id, 8888)
        XCTAssertEqual(model.talk.topicId, 3333)
        XCTAssertEqual(model.talk.name, "SuperTalk")
        XCTAssertEqual(model.talk.suggestion, "SuperTalk")
        XCTAssertEqual(model.talk.createdAt.description, "2015-01-21 14:03:05 +0000")
        XCTAssertEqual(model.talk.updatedAt.description, "2015-02-15 11:25:51 +0000")

        XCTAssertEqual(model.postIds.count, 0)
    }

    func testUpdateTopicEvent() {
        let model = try! UpdateTopicEvent.parseJSON(streaming_json("updateTopic"))

        XCTAssertEqual(model.id, 11111)
        XCTAssertEqual(model.name, "Super Topic")
        XCTAssertEqual(model.suggestion, "Super Topic")
        XCTAssertNil(model.lastPostedAt)
        XCTAssertEqual(model.createdAt.description, "2015-02-15 11:12:37 +0000")
        XCTAssertEqual(model.updatedAt.description, "2015-02-15 11:12:37 +0000")
    }

    func testRequestTopicInviteEvent() {
        let model = try! RequestTopicInviteEvent.parseJSON(streaming_json("requestTopicInvite"))

        XCTAssertEqual(model.id, 4321)
        XCTAssertEqual(model.topic!.name, "SampleTopic")
        XCTAssertEqual(model.topic!.suggestion, "SampleTopic")
        XCTAssertNil(model.topic!.lastPostedAt)
        XCTAssertEqual(model.topic!.createdAt.description, "2015-02-28 14:34:12 +0000")
        XCTAssertEqual(model.topic!.updatedAt.description, "2015-02-28 14:34:12 +0000")

        XCTAssertEqual(model.sender!.id, 5678)
        XCTAssertEqual(model.sender!.name, "User1")
        XCTAssertEqual(model.sender!.fullName, "User1")
        XCTAssertEqual(model.sender!.suggestion, "User1")
        XCTAssertEqual(model.sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/5678/profile_image.png?t=1447083512770")
        XCTAssertEqual(model.sender!.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.sender!.updatedAt.description, "2015-02-28 14:30:22 +0000")

        XCTAssertEqual(model.account!.id, 3210)
        XCTAssertEqual(model.account!.name, "Foobar")
        XCTAssertEqual(model.account!.fullName, "Foobar")
        XCTAssertEqual(model.account!.suggestion, "Foobar")
        XCTAssertEqual(model.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/3210/profile_image.png?t=1441342021468")
        XCTAssertEqual(model.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.account!.updatedAt.description, "2015-02-28 14:32:39 +0000")

        XCTAssertEqual(model.message, "Sample")
        XCTAssertEqual(model.createdAt!.description, "2015-02-28 14:34:21 +0000")
        XCTAssertEqual(model.updatedAt!.description, "2015-02-28 14:34:21 +0000")
    }

    func testAcceptTopicInviteEvent() {
        let model = try! AcceptTopicInviteEvent.parseJSON(streaming_json("acceptTopicInvite"))

        XCTAssertEqual(model.invite.id, 4321)
        XCTAssertEqual(model.invite.topic!.name, "サンプルトピック")
        XCTAssertEqual(model.invite.topic!.suggestion, "サンプルトピック")
        XCTAssertNil(model.invite.topic!.lastPostedAt)
        XCTAssertEqual(model.invite.topic!.createdAt.description, "2015-02-28 14:34:12 +0000")
        XCTAssertEqual(model.invite.topic!.updatedAt.description, "2015-02-28 14:41:48 +0000")

        XCTAssertEqual(model.invite.sender!.id, 5432)
        XCTAssertEqual(model.invite.sender!.name, "User1")
        XCTAssertEqual(model.invite.sender!.fullName, "User1")
        XCTAssertEqual(model.invite.sender!.suggestion, "User1")
        XCTAssertEqual(model.invite.sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/5432/profile_image.png?t=1410835027747")
        XCTAssertEqual(model.invite.sender!.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.invite.sender!.updatedAt.description, "2015-02-28 14:30:22 +0000")

        XCTAssertEqual(model.invite.account!.id, 3210)
        XCTAssertEqual(model.invite.account!.name, "Foobar")
        XCTAssertEqual(model.invite.account!.fullName, "Foobar")
        XCTAssertEqual(model.invite.account!.suggestion, "Foobar")
        XCTAssertEqual(model.invite.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/3210/profile_image.png?t=1412746832021")
        XCTAssertEqual(model.invite.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.invite.account!.updatedAt.description, "2015-02-28 14:32:39 +0000")

        XCTAssertEqual(model.invite.message, "Hello?")
        XCTAssertEqual(model.invite.createdAt!.description, "2015-02-28 14:43:52 +0000")
        XCTAssertEqual(model.invite.updatedAt!.description, "2015-02-28 14:44:01 +0000")
    }

    func testDeclineTopicInviteEvent() {
        let model = try! DeclineTopicInviteEvent.parseJSON(streaming_json("declineTopicInvite"))

        XCTAssertEqual(model.invite.id, 4321)
        XCTAssertEqual(model.invite.topic!.name, "SampleTopic")
        XCTAssertEqual(model.invite.topic!.suggestion, "SampleTopic")
        XCTAssertNil(model.invite.topic!.lastPostedAt)
        XCTAssertEqual(model.invite.topic!.createdAt.description, "2015-02-28 14:34:12 +0000")
        XCTAssertEqual(model.invite.topic!.updatedAt.description, "2015-02-28 14:34:12 +0000")

        XCTAssertEqual(model.invite.sender!.id, 5678)
        XCTAssertEqual(model.invite.sender!.name, "User1")
        XCTAssertEqual(model.invite.sender!.fullName, "User1")
        XCTAssertEqual(model.invite.sender!.suggestion, "User1")
        XCTAssertEqual(model.invite.sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/5678/profile_image.png?t=1412783507470")
        XCTAssertEqual(model.invite.sender!.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.invite.sender!.updatedAt.description, "2015-02-28 14:30:22 +0000")

        XCTAssertEqual(model.invite.account!.id, 3210)
        XCTAssertEqual(model.invite.account!.name, "Foobar")
        XCTAssertEqual(model.invite.account!.fullName, "Foobar")
        XCTAssertEqual(model.invite.account!.suggestion, "Foobar")
        XCTAssertEqual(model.invite.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/3210/profile_image.png?t=1421271320468")
        XCTAssertEqual(model.invite.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.invite.account!.updatedAt.description, "2015-02-28 14:32:39 +0000")

        XCTAssertEqual(model.invite.message, "")
        XCTAssertEqual(model.invite.createdAt!.description, "2015-02-28 14:34:21 +0000")
        XCTAssertEqual(model.invite.updatedAt!.description, "2015-02-28 14:38:28 +0000")
    }

    func testCancelTopicInviteEvent() {
        let model = try! CancelTopicInviteEvent.parseJSON(streaming_json("cancelTopicInvite"))

        XCTAssertEqual(model.invite.id, 4321)
        XCTAssertEqual(model.invite.topic!.name, "サンプルトピック")
        XCTAssertEqual(model.invite.topic!.suggestion, "サンプルトピック")
        XCTAssertNil(model.invite.topic!.lastPostedAt)
        XCTAssertEqual(model.invite.topic!.createdAt.description, "2015-02-28 14:34:12 +0000")
        XCTAssertEqual(model.invite.topic!.updatedAt.description, "2015-02-28 14:41:48 +0000")

        XCTAssertEqual(model.invite.sender!.id, 5432)
        XCTAssertEqual(model.invite.sender!.name, "User1")
        XCTAssertEqual(model.invite.sender!.fullName, "User1")
        XCTAssertEqual(model.invite.sender!.suggestion, "User1")
        XCTAssertEqual(model.invite.sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/5432/profile_image.png?t=1414708350277")
        XCTAssertEqual(model.invite.sender!.createdAt.description, "2014-10-04 08:51:10 +0000")
        XCTAssertEqual(model.invite.sender!.updatedAt.description, "2015-02-28 14:30:22 +0000")

        XCTAssertEqual(model.invite.account!.id, 3210)
        XCTAssertEqual(model.invite.account!.name, "Foobar")
        XCTAssertEqual(model.invite.account!.fullName, "Foobar")
        XCTAssertEqual(model.invite.account!.suggestion, "Foobar")
        XCTAssertEqual(model.invite.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/3210/profile_image.png?t=1421271320468")
        XCTAssertEqual(model.invite.account!.createdAt.description, "2014-03-18 14:38:01 +0000")
        XCTAssertEqual(model.invite.account!.updatedAt.description, "2015-02-28 14:32:39 +0000")

        XCTAssertEqual(model.invite.message, "")
        XCTAssertEqual(model.invite.createdAt!.description, "2015-02-28 14:34:21 +0000")
        XCTAssertEqual(model.invite.updatedAt!.description, "2015-02-28 14:38:28 +0000")
    }

}
