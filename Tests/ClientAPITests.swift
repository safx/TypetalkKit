//
//  ClientAPITests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/12.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
import APIKit
import OHHTTPStubs
@testable import TypetalkKit


class ClientAPITests: XCTestCase {

    func createStub(name: String) {
        OHHTTPStubs.stubRequestsPassingTest({ _ in return true }) { _ in
            let fixture = OHPathForFile("api_\(name).json", self.dynamicType)
            return OHHTTPStubsResponse(fileAtPath: fixture!,
                statusCode: 200, headers: ["Content-Type":"application/json"])
        }
    }

    override func setUp() {
        TypetalkAPI.setDummyAccessTokenForTest()
        super.setUp()
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testGetProfile() {
        createStub("get-profile")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetProfile()) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.account.id, 100)
                XCTAssertEqual(r.account.name, "jessica")
                XCTAssertEqual(r.account.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.account.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.account.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.account.updatedAt.description, "2014-06-24 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTopics() {
        createStub("get-topics")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetTopics()) { result in
            switch result {
            case .Success(let r):
                let last = r.topics[8]
                XCTAssertEqual(last.topic.id, 206)
                XCTAssertEqual(last.topic.name, "VisualDesigners")
                XCTAssertEqual(last.topic.suggestion, "VisualDesigners")
                XCTAssertEqual(last.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(last.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertEqual(last.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertFalse(last.favorite)
                XCTAssertTrue(nil == last.unread)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetMessages() {
        createStub("get-messages")

        let expectation = expectationWithDescription("")

        TypetalkAPI.sendRequest(GetMessages(topicId: 0, count: nil, from: nil, direction: nil)) { result in
            switch result {
            case .Success(let messages):
                let first = messages.posts[0]
                XCTAssertEqual(first.id, 300)
                XCTAssertEqual(first.topicId, 208)
                XCTAssertNil(first.replyTo)
                XCTAssertEqual(first.links.count, 2)
                XCTAssertTrue(nil == first.links[0].embed)
                XCTAssertTrue(nil != first.links[1].embed)

                XCTAssertEqual(first.links[1].embed!.type, "rich")
                XCTAssertEqual(first.links[1].embed!.version, Float(1.0))
                XCTAssertEqual(first.links[1].embed!.providerName, "Speaker Deck")
                XCTAssertEqual(first.links[1].embed!.providerURL!.absoluteString, "https://speakerdeck.com/")
                XCTAssertEqual(first.links[1].embed!.title, "Nulab's Way of Working Remotely")
                XCTAssertEqual(first.links[1].embed!.authorName, "Nulab Inc.")
                XCTAssertEqual(first.links[1].embed!.authorURL!.absoluteString, "https://speakerdeck.com/nulabinc")
                XCTAssertEqual(first.links[1].embed!.html, "<iframe allowfullscreen=\"true\" allowtransparency=\"true\" frameborder=\"0\" height=\"596\" id=\"talk_frame_130304\" mozallowfullscreen=\"true\" src=\"//speakerdeck.com/player/4445cf303b350132afda224ffdff9a3d\" style=\"border:0; padding:0; margin:0; background:transparent;\" webkitallowfullscreen=\"true\" width=\"710\"></iframe>\n")
                XCTAssertEqual(first.links[1].embed!.width, 710)
                XCTAssertEqual(first.links[1].embed!.height, 596)

                let last = messages.posts[7]
                XCTAssertEqual(last.id, 307)
                XCTAssertEqual(last.topicId, 208)
                XCTAssertEqual(last.replyTo!, 306)
                XCTAssertEqual(last.message, "Hope it doesn't sound arrogant but I'm the greatest man in the world!")
                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testPostMessage() {
        createStub("post-message")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(PostMessage(topicId: 0, message: "", fileKeys: [], talkIds: [])) { result in
            switch result {
            case .Success(let res):
                let topic = res.topic!
                let post = res.post!
                XCTAssertEqual(topic.id, 208)
                XCTAssertEqual(topic.name, "IT Peeps")
                XCTAssertEqual(topic.suggestion, "IT Peeps")

                XCTAssertEqual(post.id, 333)
                XCTAssertNil(post.replyTo)
                //XCTAssertNil(post.mention)
                XCTAssertEqual(post.message, "Let's party like it's 1999!")
                XCTAssertTrue(post.attachments.isEmpty)
                XCTAssertTrue(post.likes.isEmpty)
                XCTAssertTrue(post.talks.isEmpty)
                XCTAssertTrue(post.links.isEmpty)

                XCTAssertEqual(post.account.id, 100)
                XCTAssertEqual(post.account.name, "jessica")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testUploadAttachment() {
        createStub("upload-attachment")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(UploadAttachment(topicId: 0, name: "", contents: NSData())) { result in
            switch result {
            case .Success(let attachment):
                XCTAssertEqual(attachment.fileKey, "0569fedc62f37e48779ee285fe04f0ff4057e0d0")
                XCTAssertEqual(attachment.fileName, "sample.jpg")
                XCTAssertEqual(attachment.fileSize, 472263)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTopicMembers() {
        createStub("get-topic-members")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetTopicMembers(topicId: 0)) { result in
            switch result {
            case .Success(let res):
                XCTAssertEqual(res.pendings.count, 1)

                let last = res.accounts[5]
                XCTAssertEqual(last.account.id, 103)
                XCTAssertEqual(last.account.name, "stefhull")
                XCTAssertEqual(last.account.fullName, "StefHull")
                XCTAssertEqual(last.account.suggestion, "StefHull")
                XCTAssertEqual(last.account.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
                XCTAssertEqual(last.account.createdAt.description, "2014-06-27 02:32:29 +0000")
                XCTAssertEqual(last.online, false)

                XCTAssertEqual(res.pendings.count, 1)

                let pending = res.pendings[0]
                XCTAssertEqual(pending.account.id, 106)
                XCTAssertEqual(pending.account.name, "chelseab")
                XCTAssertEqual(pending.account.fullName, "ChelseaB")
                XCTAssertEqual(pending.account.suggestion, "ChelseaB")
                XCTAssertEqual(pending.account.imageUrl.absoluteString, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
                XCTAssertEqual(pending.account.createdAt.description, "2014-06-30 02:32:29 +0000")
                XCTAssertNil(pending.mailAddress)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetMessage() {
        createStub("get-message")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetMessage(topicId: 0, postId: 0)) { result in
            switch result {
            case .Success(let message):
                XCTAssertEqual(message.team.id, 700)
                XCTAssertEqual(message.team.name, "Nulab Inc.")
                XCTAssertEqual(message.team.imageUrl.absoluteString, "https://typetalk.in/teams/700/image.png?t=1402367549000")
                XCTAssertEqual(message.team.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(message.team.updatedAt.description, "2014-06-10 02:32:29 +0000")

                XCTAssertEqual(message.topic.id, 208)
                XCTAssertEqual(message.topic.name, "IT Peeps")
                XCTAssertEqual(message.topic.suggestion, "IT Peeps")
                XCTAssertEqual(message.topic.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(message.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(message.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")

                XCTAssertEqual(message.post.id, 307)
                XCTAssertEqual(message.post.topicId, 208)
                XCTAssertEqual(message.post.replyTo!, 306)
                XCTAssertEqual(message.post.likes.count, 1)

                XCTAssertEqual(message.replies.count, 2)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDeleteMessage() {
        createStub("delete-message")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(DeleteMessage(topicId: 0, postId: 0)) { result in
            switch result {
            case .Success(let post):
                XCTAssertEqual(post.id, 333)
                XCTAssertNil(post.replyTo)
                //XCTAssertNil(post.mention)
                XCTAssertEqual(post.message, "Let's party like it's 1999!")
                XCTAssertTrue(post.attachments.isEmpty)
                XCTAssertEqual(post.account.id, 100)
                XCTAssertEqual(post.account.name, "jessica")
                XCTAssertEqual(post.attachments.count, 0)
                XCTAssertTrue(post.likes.isEmpty)
                XCTAssertTrue(post.talks.isEmpty)
                XCTAssertTrue(post.links.isEmpty)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testLikeMessage() {
        createStub("like-message")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(LikeMessage(topicId: 0, postId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.like.id, 604)
                XCTAssertEqual(r.like.postId, 305)
                XCTAssertEqual(r.like.topicId, 208)
                XCTAssertEqual(r.like.comment!, "")
                XCTAssertEqual(r.like.account!.id, 100)
                XCTAssertEqual(r.like.account!.name, "jessica")
                XCTAssertEqual(r.like.account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.like.account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.like.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.like.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.like.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testUnlikeMessage() {
        createStub("unlike-message")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(UnlikeMessage(topicId: 0, postId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.like.id, 604)
                XCTAssertEqual(r.like.postId, 305)
                XCTAssertEqual(r.like.topicId, 208)
                XCTAssertEqual(r.like.comment!, "")
                XCTAssertEqual(r.like.account!.id, 100)
                XCTAssertEqual(r.like.account!.name, "jessica")
                XCTAssertEqual(r.like.account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.like.account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.like.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.like.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.like.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testFavoriteTopic() {
        createStub("favorite-topic")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(FavoriteTopic(topicId: 0)) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 206)
                XCTAssertEqual(topic.topic.name, "VisualDesigners")
                XCTAssertEqual(topic.topic.suggestion, "VisualDesigners")
                XCTAssertEqual(topic.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(topic.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")

                XCTAssertTrue(topic.favorite)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testUnfavoriteTopic() {
        createStub("unfavorite-topic")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(UnfavoriteTopic(topicId: 0)) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 206)
                XCTAssertEqual(topic.topic.name, "VisualDesigners")
                XCTAssertEqual(topic.topic.suggestion, "VisualDesigners")
                XCTAssertEqual(topic.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(topic.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")

                XCTAssertFalse(topic.favorite)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetNotifications() {
        createStub("get-notifications")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetNotifications()) { result in
            switch result {
            case .Success(let notifications):
                XCTAssertEqual(notifications.mentions.count, 2)
                let mention = notifications.mentions[1]
                XCTAssertEqual(mention.id, 500)
                XCTAssertEqual(mention.readAt!.description, "2014-06-30 15:00:00 +0000")
                XCTAssertEqual(mention.post!.id, 308)
                XCTAssertEqual(mention.post!.topicId, 202)
                XCTAssertEqual(mention.post!.topic!.id, 202)
                XCTAssertEqual(mention.post!.topic!.name, "Arts & Crafts Club")
                XCTAssertNil(mention.post!.replyTo)
                XCTAssertEqual(mention.post!.message, "@jessica What do you think about this?")
                XCTAssertEqual(mention.post!.account.id, 101)
                XCTAssertEqual(mention.post!.account.name, "ahorowitz")

                XCTAssertEqual(notifications.invites.teams.count, 2)
                let team = notifications.invites.teams[1]
                XCTAssertEqual(team.id, 800)
                XCTAssertEqual(team.team!.id, 702)
                XCTAssertEqual(team.team!.name, "Cycling team")
                XCTAssertEqual(team.sender!.id, 106)
                XCTAssertEqual(team.sender!.name, "chelseab")
                XCTAssertEqual(team.account!.id, 100)
                XCTAssertEqual(team.account!.name, "jessica")

                XCTAssertEqual(notifications.invites.topics.count, 2)
                let topic = notifications.invites.topics[1]
                XCTAssertEqual(topic.id, 600)
                XCTAssertEqual(topic.topic!.id, 209)
                XCTAssertEqual(topic.topic!.name, "Web Site")
                XCTAssertEqual(topic.sender!.id, 106)
                XCTAssertEqual(topic.sender!.name, "chelseab")
                XCTAssertEqual(topic.account!.id, 100)
                XCTAssertEqual(topic.account!.name, "jessica")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetNotificationStatus() {
        createStub("get-notification-status")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetNotificationStatus()) { result in
            switch result {
            case .Success(let status):
                XCTAssertEqual(status.mention!.unread!, 1)
                XCTAssertEqual(status.access!.unopened!, 1)
                XCTAssertEqual(status.invite!.team!.pending!, 2)
                XCTAssertEqual(status.invite!.topic!.pending!, 2)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testOpenNotification() {
        createStub("open-notification")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(OpenNotification()) { result in
            switch result {
            case .Success(let status):
                XCTAssertTrue(nil == status.mention)
                XCTAssertEqual(status.access!.unopened!, 0)
                XCTAssertTrue(nil == status.invite)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSaveReadTopic() {
        createStub("save-read-topic")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(SaveReadTopic(topicId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.unread.topicId, 208)
                XCTAssertEqual(r.unread.postId, 307)
                XCTAssertEqual(r.unread.count, 0)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetMentions() {
        createStub("get-mentions")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetMentions()) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.mentions.count, 2)
                let mention = r.mentions[0]

                XCTAssertEqual(mention.id, 501)
                XCTAssertNil(mention.readAt)
                XCTAssertEqual(mention.post!.id, 309)
                XCTAssertEqual(mention.post!.topicId, 203)
                XCTAssertEqual(mention.post!.topic!.id, 203)
                XCTAssertEqual(mention.post!.topic!.name, "Techies")
                XCTAssertEqual(mention.post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(mention.post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(mention.post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertNil(mention.post!.replyTo)
                XCTAssertEqual(mention.post!.message, "@jessica Help me!")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSaveReadMention() {
        createStub("save-read-mention")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(SaveReadMention(mentionId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.mention.id, 501)
                XCTAssertEqual(r.mention.post!.id, 309)
                XCTAssertEqual(r.mention.post!.topicId, 203)
                XCTAssertEqual(r.mention.readAt!.description, "2014-07-25 03:38:52 +0000")
                XCTAssertEqual(r.mention.post!.topic!.id, 203)
                XCTAssertEqual(r.mention.post!.topic!.name, "Techies")
                XCTAssertEqual(r.mention.post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.mention.post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.mention.post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertNil(r.mention.post!.replyTo)
                XCTAssertEqual(r.mention.post!.message, "@jessica Help me!")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testAcceptTeamInvite() {
        createStub("accept-team-invite")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(AcceptTeamInvite(teamId: 0, inviteId: 0)) { result in
            switch result {
            case .Success(let res):
                let topics = res.topics
                let invite = res.invite!
                XCTAssertEqual(topics.count, 2)
                let topic = topics[1]
                XCTAssertEqual(topic.id, 212)
                XCTAssertEqual(topic.name, "Races")
                XCTAssertEqual(topic.suggestion, "Races")
                XCTAssertEqual(topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
                XCTAssertEqual(topic.createdAt.description, "2014-06-12 03:32:29 +0000")
                XCTAssertEqual(topic.updatedAt.description, "2014-06-12 03:32:29 +0000")

                XCTAssertEqual(invite.id, 800)
                XCTAssertEqual(invite.team!.id, 702)
                XCTAssertEqual(invite.team!.name, "Cycling team")
                XCTAssertEqual(invite.sender!.id, 106)
                XCTAssertEqual(invite.sender!.name, "chelseab")
                XCTAssertEqual(invite.account!.id, 100)
                XCTAssertEqual(invite.account!.name, "jessica")

                XCTAssertEqual(invite.role!, "member")
                XCTAssertEqual(invite.message, "Hello. Please join us.")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDeclineTeamInvite() {
        createStub("decline-team-invite")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(DeclineTeamInvite(teamId: 0, inviteId: 0)) { result in
            switch result {
            case .Success(let invite):
                XCTAssertEqual(invite.id, 801)
                XCTAssertEqual(invite.team!.id, 703)
                XCTAssertEqual(invite.team!.name, "WP Team")
                XCTAssertEqual(invite.sender!.id, 105)
                XCTAssertEqual(invite.sender!.name, "brad")
                XCTAssertEqual(invite.account!.id, 100)
                XCTAssertEqual(invite.account!.name, "jessica")

                XCTAssertEqual(invite.role!, "admin")
                XCTAssertEqual(invite.message, "This team is for new project.")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testAcceptTopicInvite() {
        createStub("accept-topic-invite")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(AcceptTopicInvite(topicId: 0, inviteId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.invite.id, 600)
                XCTAssertEqual(r.invite.topic!.id, 209)
                XCTAssertEqual(r.invite.topic!.name, "Web Site")
                XCTAssertEqual(r.invite.sender!.id, 106)
                XCTAssertEqual(r.invite.sender!.name, "chelseab")
                XCTAssertEqual(r.invite.account!.id, 100)
                XCTAssertEqual(r.invite.account!.name, "jessica")
                XCTAssertEqual(r.invite.message, "It is a new project. Join us!")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDeclineTopicInvite() {
        createStub("decline-topic-invite")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(DeclineTopicInvite(topicId: 0, inviteId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.invite.id, 601)
                XCTAssertEqual(r.invite.topic!.id, 210)
                XCTAssertEqual(r.invite.topic!.name, "Development")
                XCTAssertEqual(r.invite.sender!.id, 105)
                XCTAssertEqual(r.invite.sender!.name, "brad")
                XCTAssertEqual(r.invite.account!.id, 100)
                XCTAssertEqual(r.invite.account!.name, "jessica")
                XCTAssertEqual(r.invite.message, "It is a new project. Join us!")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testCreateTopic() {
        createStub("create-topic")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(CreateTopic(name: "", teamId: nil, inviteMembers: [], inviteMessage: "")) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 222)
                XCTAssertEqual(topic.topic.name, "Test topic")
                XCTAssertEqual(topic.topic.suggestion, "Test topic")
                XCTAssertNil(topic.topic.lastPostedAt)
                XCTAssertEqual(topic.topic.createdAt.description, "2014-07-25 03:38:55 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-07-25 03:38:55 +0000")

                XCTAssertEqual(topic.teams.count, 1)
                let team = topic.teams[0]
                XCTAssertEqual(team.team.id, 700)
                XCTAssertEqual(team.team.name, "Nulab Inc.")
                XCTAssertEqual(team.team.imageUrl.absoluteString, "https://typetalk.in/teams/700/image.png?t=1402367549000")
                XCTAssertEqual(team.team.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(team.team.updatedAt.description, "2014-06-10 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testUpdateTopic() {
        createStub("update-topic")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(UpdateTopic(topicId: 0)) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 222)
                XCTAssertEqual(topic.topic.name, "Update test topic")
                XCTAssertEqual(topic.topic.suggestion, "Update test topic")
                XCTAssertNil(topic.topic.lastPostedAt)
                XCTAssertEqual(topic.topic.createdAt.description, "2014-07-25 03:38:55 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-07-25 03:38:56 +0000")

                XCTAssertEqual(topic.teams.count, 0)
                XCTAssertEqual(topic.accounts.count, 1)
                XCTAssertEqual(topic.invites.count, 2)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDeleteTopic() {
        createStub("delete-topic")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(DeleteTopic(topicId: 0)) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.id, 222)
                XCTAssertEqual(topic.name, "Update test topic")
                XCTAssertEqual(topic.suggestion, "Update test topic")
                XCTAssertNil(topic.lastPostedAt)
                XCTAssertEqual(topic.createdAt.description, "2014-07-25 03:38:55 +0000")
                XCTAssertEqual(topic.updatedAt.description, "2014-07-25 03:38:56 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTopicDetails() {
        createStub("get-topic-details")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetTopicDetails(topicId: 0)) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 208)
                XCTAssertEqual(topic.topic.name, "IT Peeps")
                XCTAssertEqual(topic.topic.suggestion, "IT Peeps")
                XCTAssertEqual(topic.topic.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(topic.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")

                XCTAssertEqual(topic.teams.count, 1)
                XCTAssertEqual(topic.accounts.count, 2)
                XCTAssertEqual(topic.invites.count, 2)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testInviteTopicMember() {
        createStub("invite-topic-member")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(InviteTopicMember(topicId: 0, inviteMembers: [])) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 207)
                XCTAssertEqual(topic.topic.name, "Art Directors")
                XCTAssertEqual(topic.topic.suggestion, "Art Directors")
                XCTAssertEqual(topic.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(topic.topic.createdAt.description, "2014-06-09 02:32:29 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-06-09 02:32:29 +0000")

                XCTAssertEqual(topic.teams.count, 0)
                XCTAssertEqual(topic.accounts.count, 1)
                XCTAssertEqual(topic.invites.count, 2)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testRemoveTopicMember() {
        createStub("remove-topic-member")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(RemoveTopicMember(topicId: 0, removeInviteIds: [], removeMemberIds: [])) { result in
            switch result {
            case .Success(let topic):
                XCTAssertEqual(topic.topic.id, 208)
                XCTAssertEqual(topic.topic.name, "IT Peeps")
                XCTAssertEqual(topic.topic.suggestion, "IT Peeps")
                XCTAssertEqual(topic.topic.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(topic.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(topic.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")

                XCTAssertEqual(topic.teams.count, 1)
                XCTAssertEqual(topic.accounts.count, 0)
                XCTAssertEqual(topic.invites.count, 0)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTeams() {
        createStub("get-teams")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetTeams()) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.teams.count, 3)
                let first = r.teams[0]
                XCTAssertEqual(first.memberCount, 4)
                XCTAssertEqual(first.team.id, 700)
                XCTAssertEqual(first.team.name, "Nulab Inc.")
                XCTAssertEqual(first.team.imageUrl.absoluteString, "https://typetalk.in/teams/700/image.png?t=1402367549000")
                XCTAssertEqual(first.team.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(first.team.updatedAt.description, "2014-06-10 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetFriends() {
        createStub("get-friends")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetFriends()) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.accounts.count, 5)
                let last = r.accounts[4]
                XCTAssertEqual(last.id, 103)
                XCTAssertEqual(last.name, "stefhull")
                XCTAssertEqual(last.fullName, "StefHull")
                XCTAssertEqual(last.suggestion, "StefHull")
                XCTAssertEqual(last.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
                XCTAssertEqual(last.createdAt.description, "2014-06-27 02:32:29 +0000")
                XCTAssertEqual(last.updatedAt.description, "2014-06-27 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSearchAccounts() {
        createStub("search-accounts")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(SearchAccounts(nameOrEmailAddress: "")) { result in
            switch result {
            case .Success(let account):
                XCTAssertEqual(account.id, 102)
                XCTAssertEqual(account.name, "moss")
                XCTAssertEqual(account.fullName, "Moss")
                XCTAssertEqual(account.suggestion, "Moss")
                XCTAssertEqual(account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
                XCTAssertEqual(account.createdAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(account.updatedAt.description, "2014-06-26 02:32:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTalks() {
        createStub("get-talks")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetTalks(topicId: 0)) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.talks.count, 2)
                let last = r.talks[1]
                XCTAssertEqual(last.id, 900)
                XCTAssertEqual(last.topicId, 208)
                XCTAssertEqual(last.name, "About us")
                XCTAssertEqual(last.suggestion, "About us")
                XCTAssertEqual(last.createdAt.description, "2014-07-02 03:42:29 +0000")
                XCTAssertEqual(last.updatedAt.description, "2014-07-02 03:52:29 +0000")

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTalk() {
        createStub("get-talk")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(GetTalk(topicId: 0, talkId: 0)) { result in
            switch result {
            case .Success(let talk):
                XCTAssertEqual(talk.topic.id, 208)
                XCTAssertEqual(talk.topic.name, "IT Peeps")
                XCTAssertEqual(talk.topic.suggestion, "IT Peeps")
                XCTAssertEqual(talk.topic.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(talk.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(talk.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")

                XCTAssertEqual(talk.talk.id, 900)
                XCTAssertEqual(talk.talk.topicId, 208)
                XCTAssertEqual(talk.talk.name, "About us")
                XCTAssertEqual(talk.talk.createdAt.description, "2014-07-02 03:42:29 +0000")
                XCTAssertEqual(talk.talk.updatedAt.description, "2014-07-02 03:52:29 +0000")

                XCTAssertEqual(talk.posts.count, 2)
                let last = talk.posts[1]
                XCTAssertEqual(last.id, 306)
                XCTAssertEqual(last.topicId, 208)
                XCTAssertEqual(last.replyTo!, 305)
                XCTAssertEqual(last.message, "Oh. What time of the month? The weekend?")

                XCTAssertEqual(talk.hasNext, false)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testCreateTalk() {
        createStub("create-talk")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(CreateTalk(topicId: 0, talkName: "", postIds: [])) { result in
            switch result {
            case .Success(let r):
                XCTAssertEqual(r.topic.id, 208)
                XCTAssertEqual(r.topic.name, "IT Peeps")
                XCTAssertEqual(r.topic.suggestion, "IT Peeps")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2015-05-21 06:30:49 +0000")
                XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")

                XCTAssertEqual(r.talk.id, 902)
                XCTAssertEqual(r.talk.topicId, 208)
                XCTAssertEqual(r.talk.name, "Feedback new design")
                XCTAssertEqual(r.talk.suggestion, "Feedback new design")
                XCTAssertEqual(r.talk.createdAt.description, "2015-05-21 06:31:07 +0000")
                XCTAssertEqual(r.talk.updatedAt.description, "2015-05-21 06:31:07 +0000")

                XCTAssertEqual(r.postIds.count, 2)
                XCTAssertEqual(r.postIds[0], 300)
                XCTAssertEqual(r.postIds[1], 301)

                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDownloadAttachment() {
        createStub("download-attachment")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(DownloadAttachment(topicId: 0, postId: 1, attachmentId: 2, filename: "aaaaaa")) { result in
            switch result {
            case .Success:
                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDownloadAttachmentWithURL() {
        createStub("download-attachment")

        let expectation = expectationWithDescription("")
        TypetalkAPI.sendRequest(DownloadAttachment(url: NSURL(string: "https://typetalk.in/api/v1/topics/208/posts/300/attachments/2/2.jpg")!, attachmentType: .Large)!) { result -> Void in
            switch result {
            case .Success:
                expectation.fulfill()
            case .Failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}
