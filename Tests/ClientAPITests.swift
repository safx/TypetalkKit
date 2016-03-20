//
//  ClientAPITests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2016/03/19.
//  Copyright (c) 2016 Safx Developers. All rights reserved.
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


	func testAddMessageToTalk() {
		createStub("add-message-to-talk")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(AddMessageToTalk(topicId: 0, talkId: 0)) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.postIds.count, 2)
				XCTAssertEqual(r.postIds[0], 300)
				XCTAssertEqual(r.postIds[1], 301)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "About us")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "About us")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-03-04 02:37:14 +0000")
				XCTAssertEqual(r.talk.id, 900)
				XCTAssertEqual(r.talk.createdAt.description, "2014-07-02 03:42:29 +0000")

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
		TypetalkAPI.sendRequest(CreateTalk(topicId: 0, talkName: "")) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.postIds.count, 2)
				XCTAssertEqual(r.postIds[0], 300)
				XCTAssertEqual(r.postIds[1], 301)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "Feedback new design")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "Feedback new design")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-03-04 02:37:12 +0000")
				XCTAssertEqual(r.talk.id, 902)
				XCTAssertEqual(r.talk.createdAt.description, "2016-03-04 02:37:12 +0000")

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
		TypetalkAPI.sendRequest(CreateTopic(name: "")) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.integrations.count, 0)
				XCTAssertNil(r.remainingInvitations)
				XCTAssertEqual(r.groups.count, 1)
				XCTAssertEqual(r.groups[0].memberCount, 4)
				XCTAssertEqual(r.groups[0].group.key, "groupkey01")
				XCTAssertEqual(r.groups[0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
				XCTAssertEqual(r.groups[0].group.suggestion, "Joe Tech Inc. All")
				XCTAssertEqual(r.groups[0].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.id, 1100)
				XCTAssertEqual(r.groups[0].group.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.name, "Joe Tech Inc. All")
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-01-20 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.accountsForApi.count, 0)
				XCTAssertEqual(r.teams.count, 0)
				XCTAssertEqual(r.topic.name, "Test topic")
				XCTAssertNil(r.topic.lastPostedAt)
				XCTAssertEqual(r.topic.suggestion, "Test topic")
				XCTAssertEqual(r.topic.updatedAt.description, "2016-03-04 02:37:05 +0000")
				XCTAssertEqual(r.topic.id, 222)
				XCTAssertEqual(r.topic.createdAt.description, "2016-03-04 02:37:05 +0000")
				XCTAssertEqual(r.accounts.count, 1)
				XCTAssertEqual(r.accounts[0].name, "chelseab")
				XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.accounts[0].suggestion, "ChelseaB")
				XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].fullName, "ChelseaB")
				XCTAssertEqual(r.accounts[0].id, 106)
				XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invitingAccounts.count, 0)
				XCTAssertEqual(r.invites.count, 0)

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
			case .Success(let r):
				XCTAssertEqual(r.topicId, 208)
				XCTAssertEqual(r.account.name, "jessica")
				XCTAssertEqual(r.account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.account.id, 100)
				XCTAssertEqual(r.account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.attachments.count, 0)
				XCTAssertEqual(r.links.count, 0)
				XCTAssertNil(r.replyTo)
				XCTAssertNil(r.mention)
				XCTAssertEqual(r.likes.count, 0)
				XCTAssertEqual(r.updatedAt.description, "2016-03-04 02:36:51 +0000")
				XCTAssertEqual(r.talks.count, 0)
				XCTAssertEqual(r.message, "Let's party like it's 1999!")
				XCTAssertEqual(r.id, 333)
				XCTAssertEqual(r.createdAt.description, "2016-03-04 02:36:51 +0000")

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testDeleteTalk() {
		createStub("delete-talk")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(DeleteTalk(topicId: 0, talkId: 0)) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "Feedback new site design")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "Feedback new site design")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-03-04 02:37:13 +0000")
				XCTAssertEqual(r.talk.id, 902)
				XCTAssertEqual(r.talk.createdAt.description, "2016-03-04 02:37:12 +0000")

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
			case .Success(let r):
				XCTAssertEqual(r.name, "Update test topic")
				XCTAssertNil(r.lastPostedAt)
				XCTAssertEqual(r.suggestion, "Update test topic")
				XCTAssertEqual(r.updatedAt.description, "2016-03-04 02:37:06 +0000")
				XCTAssertEqual(r.id, 222)
				XCTAssertEqual(r.createdAt.description, "2016-03-04 02:37:05 +0000")

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
		TypetalkAPI.sendRequest(DownloadAttachment(topicId: 0, postId: 0, attachmentId: 0, filename: "")) { result in
			switch result {
			case .Success(let r):

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
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "VisualDesigners")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topic.suggestion, "VisualDesigners")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 206)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.favorite, true)

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
				XCTAssertEqual(r.accounts.count, 3)
				XCTAssertEqual(r.accounts[0].name, "brad")
				XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts[0].suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts[0].id, 105)
				XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].name, "cooper")
				XCTAssertEqual(r.accounts[1].imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts[1].suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts[1].updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts[1].id, 104)
				XCTAssertEqual(r.accounts[1].createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].name, "jessica")
				XCTAssertEqual(r.accounts[2].imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.accounts[2].suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[2].updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[2].id, 100)
				XCTAssertEqual(r.accounts[2].createdAt.description, "2014-06-24 02:32:29 +0000")

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
				XCTAssertEqual(r.mentions[0].post.topicId, 203)
				XCTAssertEqual(r.mentions[0].post.account.name, "moss")
				XCTAssertEqual(r.mentions[0].post.account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.mentions[0].post.account.suggestion, "Moss")
				XCTAssertEqual(r.mentions[0].post.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.account.fullName, "Moss")
				XCTAssertEqual(r.mentions[0].post.account.id, 102)
				XCTAssertEqual(r.mentions[0].post.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.attachments.count, 0)
				XCTAssertEqual(r.mentions[0].post.links.count, 0)
				XCTAssertNil(r.mentions[0].post.replyTo)
				XCTAssertEqual(r.mentions[0].post.topic!.name, "Techies")
				XCTAssertEqual(r.mentions[0].post.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.topic!.suggestion, "Techies")
				XCTAssertEqual(r.mentions[0].post.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.topic!.id, 203)
				XCTAssertEqual(r.mentions[0].post.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.updatedAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.message, "@jessica Help me!")
				XCTAssertEqual(r.mentions[0].post.id, 309)
				XCTAssertEqual(r.mentions[0].post.createdAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions[0].id, 501)
				XCTAssertNil(r.mentions[0].readAt)
				XCTAssertEqual(r.mentions[1].post.topicId, 202)
				XCTAssertEqual(r.mentions[1].post.account.name, "ahorowitz")
				XCTAssertEqual(r.mentions[1].post.account.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.mentions[1].post.account.suggestion, "AHorowitz")
				XCTAssertEqual(r.mentions[1].post.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.account.fullName, "AHorowitz")
				XCTAssertEqual(r.mentions[1].post.account.id, 101)
				XCTAssertEqual(r.mentions[1].post.account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.attachments.count, 0)
				XCTAssertEqual(r.mentions[1].post.links.count, 0)
				XCTAssertNil(r.mentions[1].post.replyTo)
				XCTAssertEqual(r.mentions[1].post.topic!.name, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions[1].post.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.topic!.suggestion, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions[1].post.topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.topic!.id, 202)
				XCTAssertEqual(r.mentions[1].post.topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.updatedAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.message, "@jessica What do you think about this?")
				XCTAssertEqual(r.mentions[1].post.id, 308)
				XCTAssertEqual(r.mentions[1].post.createdAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions[1].id, 500)
				XCTAssertEqual(r.mentions[1].readAt!.description, "2014-06-30 15:00:00 +0000")

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
			case .Success(let r):
				XCTAssertEqual(r.exceedsAttachmentLimit, false)
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-01-20 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:51 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.replies.count, 2)
				XCTAssertEqual(r.replies[0].topicId, 208)
				XCTAssertEqual(r.replies[0].account.name, "cooper")
				XCTAssertEqual(r.replies[0].account.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.replies[0].account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.replies[0].account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.replies[0].account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.replies[0].account.id, 104)
				XCTAssertEqual(r.replies[0].account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.replies[0].attachments.count, 0)
				XCTAssertEqual(r.replies[0].links.count, 0)
				XCTAssertNil(r.replies[0].replyTo)
				XCTAssertNil(r.replies[0].mention)
				XCTAssertEqual(r.replies[0].likes.count, 0)
				XCTAssertEqual(r.replies[0].updatedAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.replies[0].talks.count, 2)
				XCTAssertEqual(r.replies[0].talks[0].topicId, 208)
				XCTAssertEqual(r.replies[0].talks[0].name, "2nd talk")
				XCTAssertNil(r.replies[0].talks[0].backlog)
				XCTAssertEqual(r.replies[0].talks[0].suggestion, "2nd talk")
				XCTAssertEqual(r.replies[0].talks[0].updatedAt.description, "2014-07-02 03:55:29 +0000")
				XCTAssertEqual(r.replies[0].talks[0].id, 901)
				XCTAssertEqual(r.replies[0].talks[0].createdAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.replies[0].talks[1].topicId, 208)
				XCTAssertEqual(r.replies[0].talks[1].name, "About us")
				XCTAssertNil(r.replies[0].talks[1].backlog)
				XCTAssertEqual(r.replies[0].talks[1].suggestion, "About us")
				XCTAssertEqual(r.replies[0].talks[1].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.replies[0].talks[1].id, 900)
				XCTAssertEqual(r.replies[0].talks[1].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.replies[0].message, "And I'm a 32 year old IT-man who works in a basement. Word.")
				XCTAssertEqual(r.replies[0].id, 305)
				XCTAssertEqual(r.replies[0].createdAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.replies[1].topicId, 208)
				XCTAssertEqual(r.replies[1].account.name, "jessica")
				XCTAssertEqual(r.replies[1].account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.replies[1].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.replies[1].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.replies[1].account.id, 100)
				XCTAssertEqual(r.replies[1].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].attachments.count, 0)
				XCTAssertEqual(r.replies[1].links.count, 0)
				XCTAssertEqual(r.replies[1].replyTo, 305)
				XCTAssertNil(r.replies[1].mention)
				XCTAssertEqual(r.replies[1].likes.count, 5)
				XCTAssertNil(r.replies[1].likes[0].comment)
				XCTAssertEqual(r.replies[1].likes[0].topicId, 208)
				XCTAssertEqual(r.replies[1].likes[0].account!.name, "ahorowitz")
				XCTAssertEqual(r.replies[1].likes[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.replies[1].likes[0].account!.suggestion, "AHorowitz")
				XCTAssertEqual(r.replies[1].likes[0].account!.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[0].account!.fullName, "AHorowitz")
				XCTAssertEqual(r.replies[1].likes[0].account!.id, 101)
				XCTAssertEqual(r.replies[1].likes[0].account!.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[0].postId, 306)
				XCTAssertEqual(r.replies[1].likes[0].id, 403)
				XCTAssertNil(r.replies[1].likes[1].comment)
				XCTAssertEqual(r.replies[1].likes[1].topicId, 208)
				XCTAssertEqual(r.replies[1].likes[1].account!.name, "moss")
				XCTAssertEqual(r.replies[1].likes[1].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.replies[1].likes[1].account!.suggestion, "Moss")
				XCTAssertEqual(r.replies[1].likes[1].account!.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[1].account!.fullName, "Moss")
				XCTAssertEqual(r.replies[1].likes[1].account!.id, 102)
				XCTAssertEqual(r.replies[1].likes[1].account!.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[1].postId, 306)
				XCTAssertEqual(r.replies[1].likes[1].id, 404)
				XCTAssertNil(r.replies[1].likes[2].comment)
				XCTAssertEqual(r.replies[1].likes[2].topicId, 208)
				XCTAssertEqual(r.replies[1].likes[2].account!.name, "stefhull")
				XCTAssertEqual(r.replies[1].likes[2].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.replies[1].likes[2].account!.suggestion, "StefHull")
				XCTAssertEqual(r.replies[1].likes[2].account!.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[2].account!.fullName, "StefHull")
				XCTAssertEqual(r.replies[1].likes[2].account!.id, 103)
				XCTAssertEqual(r.replies[1].likes[2].account!.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[2].postId, 306)
				XCTAssertEqual(r.replies[1].likes[2].id, 405)
				XCTAssertNil(r.replies[1].likes[3].comment)
				XCTAssertEqual(r.replies[1].likes[3].topicId, 208)
				XCTAssertEqual(r.replies[1].likes[3].account!.name, "cooper")
				XCTAssertEqual(r.replies[1].likes[3].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.replies[1].likes[3].account!.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.replies[1].likes[3].account!.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[3].account!.fullName, "CooperDaChopper")
				XCTAssertEqual(r.replies[1].likes[3].account!.id, 104)
				XCTAssertEqual(r.replies[1].likes[3].account!.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[3].postId, 306)
				XCTAssertEqual(r.replies[1].likes[3].id, 406)
				XCTAssertNil(r.replies[1].likes[4].comment)
				XCTAssertEqual(r.replies[1].likes[4].topicId, 208)
				XCTAssertEqual(r.replies[1].likes[4].account!.name, "brad")
				XCTAssertEqual(r.replies[1].likes[4].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.replies[1].likes[4].account!.suggestion, "BradMarshalls")
				XCTAssertEqual(r.replies[1].likes[4].account!.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[4].account!.fullName, "BradMarshalls")
				XCTAssertEqual(r.replies[1].likes[4].account!.id, 105)
				XCTAssertEqual(r.replies[1].likes[4].account!.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.replies[1].likes[4].postId, 306)
				XCTAssertEqual(r.replies[1].likes[4].id, 407)
				XCTAssertEqual(r.replies[1].updatedAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.replies[1].talks.count, 1)
				XCTAssertEqual(r.replies[1].talks[0].topicId, 208)
				XCTAssertEqual(r.replies[1].talks[0].name, "About us")
				XCTAssertNil(r.replies[1].talks[0].backlog)
				XCTAssertEqual(r.replies[1].talks[0].suggestion, "About us")
				XCTAssertEqual(r.replies[1].talks[0].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.replies[1].talks[0].id, 900)
				XCTAssertEqual(r.replies[1].talks[0].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.replies[1].message, "Oh. What time of the month? The weekend?")
				XCTAssertEqual(r.replies[1].id, 306)
				XCTAssertEqual(r.replies[1].createdAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.post.topicId, 208)
				XCTAssertEqual(r.post.account.name, "jessica")
				XCTAssertEqual(r.post.account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.post.account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.post.account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post.account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.post.account.id, 100)
				XCTAssertEqual(r.post.account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post.attachments.count, 0)
				XCTAssertEqual(r.post.links.count, 0)
				XCTAssertEqual(r.post.replyTo, 306)
				XCTAssertNil(r.post.mention)
				XCTAssertEqual(r.post.likes.count, 1)
				XCTAssertNil(r.post.likes[0].comment)
				XCTAssertEqual(r.post.likes[0].topicId, 208)
				XCTAssertEqual(r.post.likes[0].account!.name, "jessica")
				XCTAssertEqual(r.post.likes[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.post.likes[0].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.post.likes[0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post.likes[0].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.post.likes[0].account!.id, 100)
				XCTAssertEqual(r.post.likes[0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post.likes[0].postId, 307)
				XCTAssertEqual(r.post.likes[0].id, 408)
				XCTAssertEqual(r.post.updatedAt.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.post.talks.count, 0)
				XCTAssertEqual(r.post.message, "Hope it doesn't sound arrogant but I'm the greatest man in the world!")
				XCTAssertEqual(r.post.id, 307)
				XCTAssertEqual(r.post.createdAt.description, "2014-07-01 02:32:29 +0000")
				XCTAssertNil(r.team)

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
		TypetalkAPI.sendRequest(GetMessages(topicId: 0)) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.hasNext, false)
				XCTAssertEqual(r.exceedsAttachmentLimit, false)
				XCTAssertEqual(r.bookmark.postId, 304)
				XCTAssertEqual(r.bookmark.updatedAt.description, "2016-03-04 02:36:38 +0000")
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-01-20 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.posts.count, 8)
				XCTAssertEqual(r.posts[0].topicId, 208)
				XCTAssertEqual(r.posts[0].account.name, "stefhull")
				XCTAssertEqual(r.posts[0].account.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.posts[0].account.suggestion, "StefHull")
				XCTAssertEqual(r.posts[0].account.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[0].account.fullName, "StefHull")
				XCTAssertEqual(r.posts[0].account.id, 103)
				XCTAssertEqual(r.posts[0].account.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[0].attachments.count, 4)
				XCTAssertEqual(r.posts[0].attachments[0].webUrl.absoluteString, "https://typetalk.in/topics/208/posts/300/attachments/1/1.jpg")
				XCTAssertEqual(r.posts[0].attachments[0].attachment.fileKey, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
				XCTAssertEqual(r.posts[0].attachments[0].attachment.contentType, "image/jpeg")
				XCTAssertEqual(r.posts[0].attachments[0].attachment.fileSize, 472263)
				XCTAssertEqual(r.posts[0].attachments[0].attachment.fileName, "1.jpg")
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails.count, 3)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[0].width, 480)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[0].type.rawValue, "small")
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[0].fileSize, 16842)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[0].height, 360)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[1].width, 800)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[1].type.rawValue, "medium")
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[1].fileSize, 23714)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[1].height, 600)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[2].width, 1024)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[2].type.rawValue, "large")
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[2].fileSize, 41130)
				XCTAssertEqual(r.posts[0].attachments[0].thumbnails[2].height, 768)
				XCTAssertEqual(r.posts[0].attachments[0].apiUrl.absoluteString, "https://typetalk.in/api/v1/topics/208/posts/300/attachments/1/1.jpg")
				XCTAssertEqual(r.posts[0].attachments[1].webUrl.absoluteString, "https://typetalk.in/topics/208/posts/300/attachments/2/2.jpg")
				XCTAssertEqual(r.posts[0].attachments[1].attachment.fileKey, "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
				XCTAssertEqual(r.posts[0].attachments[1].attachment.contentType, "image/jpeg")
				XCTAssertEqual(r.posts[0].attachments[1].attachment.fileSize, 494376)
				XCTAssertEqual(r.posts[0].attachments[1].attachment.fileName, "2.jpg")
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails.count, 3)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[0].width, 480)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[0].type.rawValue, "small")
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[0].fileSize, 8533)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[0].height, 360)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[1].width, 800)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[1].type.rawValue, "medium")
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[1].fileSize, 26098)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[1].height, 600)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[2].width, 1024)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[2].type.rawValue, "large")
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[2].fileSize, 43551)
				XCTAssertEqual(r.posts[0].attachments[1].thumbnails[2].height, 768)
				XCTAssertEqual(r.posts[0].attachments[1].apiUrl.absoluteString, "https://typetalk.in/api/v1/topics/208/posts/300/attachments/2/2.jpg")
				XCTAssertEqual(r.posts[0].attachments[2].webUrl.absoluteString, "https://typetalk.in/topics/208/posts/300/attachments/3/5.jpg")
				XCTAssertEqual(r.posts[0].attachments[2].attachment.fileKey, "cccccccccccccccccccccccccccccccccccccccc")
				XCTAssertEqual(r.posts[0].attachments[2].attachment.contentType, "image/jpeg")
				XCTAssertEqual(r.posts[0].attachments[2].attachment.fileSize, 218100)
				XCTAssertEqual(r.posts[0].attachments[2].attachment.fileName, "5.jpg")
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails.count, 3)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[0].width, 480)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[0].type.rawValue, "small")
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[0].fileSize, 5910)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[0].height, 20)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[1].width, 800)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[1].type.rawValue, "medium")
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[1].fileSize, 17403)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[1].height, 33)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[2].width, 1024)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[2].type.rawValue, "large")
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[2].fileSize, 34877)
				XCTAssertEqual(r.posts[0].attachments[2].thumbnails[2].height, 43)
				XCTAssertEqual(r.posts[0].attachments[2].apiUrl.absoluteString, "https://typetalk.in/api/v1/topics/208/posts/300/attachments/3/5.jpg")
				XCTAssertEqual(r.posts[0].attachments[3].webUrl.absoluteString, "https://typetalk.in/topics/208/posts/300/attachments/4/6.jpg")
				XCTAssertEqual(r.posts[0].attachments[3].attachment.fileKey, "dddddddddddddddddddddddddddddddddddddddd")
				XCTAssertEqual(r.posts[0].attachments[3].attachment.contentType, "image/jpeg")
				XCTAssertEqual(r.posts[0].attachments[3].attachment.fileSize, 627926)
				XCTAssertEqual(r.posts[0].attachments[3].attachment.fileName, "6.jpg")
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails.count, 3)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[0].width, 480)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[0].type.rawValue, "small")
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[0].fileSize, 10439)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[0].height, 360)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[1].width, 800)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[1].type.rawValue, "medium")
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[1].fileSize, 32664)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[1].height, 600)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[2].width, 1024)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[2].type.rawValue, "large")
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[2].fileSize, 52914)
				XCTAssertEqual(r.posts[0].attachments[3].thumbnails[2].height, 768)
				XCTAssertEqual(r.posts[0].attachments[3].apiUrl.absoluteString, "https://typetalk.in/api/v1/topics/208/posts/300/attachments/4/6.jpg")
				XCTAssertEqual(r.posts[0].links.count, 2)
				XCTAssertEqual(r.posts[0].links[0].contentType, "text/html; charset=UTF-8")
				XCTAssertEqual(r.posts[0].links[0].description, "We develop collaborative software tools aimed at facilitating effective work communication and collaboration.")
				XCTAssertEqual(r.posts[0].links[0].title, "Fun. Creative. Collaboration. | Nulab Inc.")
				XCTAssertEqual(r.posts[0].links[0].url.absoluteString, "http://nulab-inc.com")
				XCTAssertEqual(r.posts[0].links[0].imageUrl.absoluteString, "http://nulab-inc.com/ogp_dft.png")
				XCTAssertEqual(r.posts[0].links[0].updatedAt.description, "2016-03-04 02:36:38 +0000")
				XCTAssertNil(r.posts[0].links[0].embed)
				XCTAssertEqual(r.posts[0].links[0].id, 112)
				XCTAssertEqual(r.posts[0].links[0].createdAt.description, "2016-03-04 02:36:38 +0000")
				XCTAssertEqual(r.posts[0].links[1].contentType, "text/html; charset=utf-8")
				XCTAssertEqual(r.posts[0].links[1].description, "Presentation slides at Nulab 10th Anniversary NUCON http://nucon-10th.nulab-inc.com/")
				XCTAssertEqual(r.posts[0].links[1].title, "Nulab's Way of Working Remotely")
				XCTAssertEqual(r.posts[0].links[1].url.absoluteString, "https://speakerdeck.com/nulabinc/nulabs-way-of-working-remotely")
				XCTAssertEqual(r.posts[0].links[1].imageUrl.absoluteString, "https://speakerd.s3.amazonaws.com/presentations/4445cf303b350132afda224ffdff9a3d/slide_0.jpg")
				XCTAssertEqual(r.posts[0].links[1].updatedAt.description, "2016-03-04 02:36:38 +0000")
				XCTAssertEqual(r.posts[0].links[1].embed!.providerURL!.absoluteString, "https://speakerdeck.com/")
				XCTAssertEqual(r.posts[0].links[1].embed!.title, "Nulab's Way of Working Remotely")
				XCTAssertEqual(r.posts[0].links[1].embed!.html, "<iframe allowfullscreen=\"true\" allowtransparency=\"true\" frameborder=\"0\" height=\"596\" id=\"talk_frame_130304\" mozallowfullscreen=\"true\" src=\"//speakerdeck.com/player/4445cf303b350132afda224ffdff9a3d\" style=\"border:0; padding:0; margin:0; background:transparent;\" webkitallowfullscreen=\"true\" width=\"710\"></iframe>\n")
				XCTAssertEqual(r.posts[0].links[1].embed!.authorName, "Nulab Inc.")
				XCTAssertEqual(r.posts[0].links[1].embed!.height, 596)
				XCTAssertEqual(r.posts[0].links[1].embed!.width, 710)
				XCTAssertEqual(r.posts[0].links[1].embed!.version, 1)
				XCTAssertEqual(r.posts[0].links[1].embed!.authorURL!.absoluteString, "https://speakerdeck.com/nulabinc")
				XCTAssertEqual(r.posts[0].links[1].embed!.providerName, "Speaker Deck")
				XCTAssertEqual(r.posts[0].links[1].embed!.type, "rich")
				XCTAssertEqual(r.posts[0].links[1].id, 113)
				XCTAssertEqual(r.posts[0].links[1].createdAt.description, "2016-03-04 02:36:38 +0000")
				XCTAssertNil(r.posts[0].replyTo)
				XCTAssertNil(r.posts[0].mention)
				XCTAssertEqual(r.posts[0].likes.count, 0)
				XCTAssertEqual(r.posts[0].updatedAt.description, "2014-06-29 00:32:29 +0000")
				XCTAssertEqual(r.posts[0].talks.count, 0)
				XCTAssertEqual(r.posts[0].message, "Here's an example of a link, images and slide. http://nulab-inc.com https://speakerdeck.com/nulabinc/nulabs-way-of-working-remotely")
				XCTAssertEqual(r.posts[0].id, 300)
				XCTAssertEqual(r.posts[0].createdAt.description, "2014-06-29 00:32:29 +0000")
				XCTAssertEqual(r.posts[1].topicId, 208)
				XCTAssertEqual(r.posts[1].account.name, "jessica")
				XCTAssertEqual(r.posts[1].account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts[1].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[1].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[1].account.id, 100)
				XCTAssertEqual(r.posts[1].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].attachments.count, 0)
				XCTAssertEqual(r.posts[1].links.count, 0)
				XCTAssertNil(r.posts[1].replyTo)
				XCTAssertNil(r.posts[1].mention)
				XCTAssertEqual(r.posts[1].likes.count, 0)
				XCTAssertEqual(r.posts[1].updatedAt.description, "2014-06-30 01:32:29 +0000")
				XCTAssertEqual(r.posts[1].talks.count, 0)
				XCTAssertEqual(r.posts[1].message, "OK. Moss, what did you have for breakfast this morning?")
				XCTAssertEqual(r.posts[1].id, 301)
				XCTAssertEqual(r.posts[1].createdAt.description, "2014-06-30 01:32:29 +0000")
				XCTAssertEqual(r.posts[2].topicId, 208)
				XCTAssertEqual(r.posts[2].account.name, "moss")
				XCTAssertEqual(r.posts[2].account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.posts[2].account.suggestion, "Moss")
				XCTAssertEqual(r.posts[2].account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].account.fullName, "Moss")
				XCTAssertEqual(r.posts[2].account.id, 102)
				XCTAssertEqual(r.posts[2].account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].attachments.count, 0)
				XCTAssertEqual(r.posts[2].links.count, 0)
				XCTAssertEqual(r.posts[2].replyTo, 301)
				XCTAssertNil(r.posts[2].mention)
				XCTAssertEqual(r.posts[2].likes.count, 3)
				XCTAssertNil(r.posts[2].likes[0].comment)
				XCTAssertEqual(r.posts[2].likes[0].topicId, 208)
				XCTAssertEqual(r.posts[2].likes[0].account!.name, "jessica")
				XCTAssertEqual(r.posts[2].likes[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts[2].likes[0].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[2].likes[0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].likes[0].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[2].likes[0].account!.id, 100)
				XCTAssertEqual(r.posts[2].likes[0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].likes[0].postId, 302)
				XCTAssertEqual(r.posts[2].likes[0].id, 400)
				XCTAssertNil(r.posts[2].likes[1].comment)
				XCTAssertEqual(r.posts[2].likes[1].topicId, 208)
				XCTAssertEqual(r.posts[2].likes[1].account!.name, "ahorowitz")
				XCTAssertEqual(r.posts[2].likes[1].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.posts[2].likes[1].account!.suggestion, "AHorowitz")
				XCTAssertEqual(r.posts[2].likes[1].account!.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].likes[1].account!.fullName, "AHorowitz")
				XCTAssertEqual(r.posts[2].likes[1].account!.id, 101)
				XCTAssertEqual(r.posts[2].likes[1].account!.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].likes[1].postId, 302)
				XCTAssertEqual(r.posts[2].likes[1].id, 401)
				XCTAssertNil(r.posts[2].likes[2].comment)
				XCTAssertEqual(r.posts[2].likes[2].topicId, 208)
				XCTAssertEqual(r.posts[2].likes[2].account!.name, "stefhull")
				XCTAssertEqual(r.posts[2].likes[2].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.posts[2].likes[2].account!.suggestion, "StefHull")
				XCTAssertEqual(r.posts[2].likes[2].account!.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].likes[2].account!.fullName, "StefHull")
				XCTAssertEqual(r.posts[2].likes[2].account!.id, 103)
				XCTAssertEqual(r.posts[2].likes[2].account!.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[2].likes[2].postId, 302)
				XCTAssertEqual(r.posts[2].likes[2].id, 402)
				XCTAssertEqual(r.posts[2].updatedAt.description, "2014-06-30 04:32:29 +0000")
				XCTAssertEqual(r.posts[2].talks.count, 0)
				XCTAssertEqual(r.posts[2].message, "Smarties cereal.")
				XCTAssertEqual(r.posts[2].id, 302)
				XCTAssertEqual(r.posts[2].createdAt.description, "2014-06-30 04:32:29 +0000")
				XCTAssertEqual(r.posts[3].topicId, 208)
				XCTAssertEqual(r.posts[3].account.name, "stefhull")
				XCTAssertEqual(r.posts[3].account.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.posts[3].account.suggestion, "StefHull")
				XCTAssertEqual(r.posts[3].account.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[3].account.fullName, "StefHull")
				XCTAssertEqual(r.posts[3].account.id, 103)
				XCTAssertEqual(r.posts[3].account.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[3].attachments.count, 0)
				XCTAssertEqual(r.posts[3].links.count, 0)
				XCTAssertNil(r.posts[3].replyTo)
				XCTAssertNil(r.posts[3].mention)
				XCTAssertEqual(r.posts[3].likes.count, 0)
				XCTAssertEqual(r.posts[3].updatedAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts[3].talks.count, 0)
				XCTAssertEqual(r.posts[3].message, "Heard you're single again. All the best, Maurice Moss!")
				XCTAssertEqual(r.posts[3].id, 303)
				XCTAssertEqual(r.posts[3].createdAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts[4].topicId, 208)
				XCTAssertEqual(r.posts[4].account.name, "moss")
				XCTAssertEqual(r.posts[4].account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.posts[4].account.suggestion, "Moss")
				XCTAssertEqual(r.posts[4].account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[4].account.fullName, "Moss")
				XCTAssertEqual(r.posts[4].account.id, 102)
				XCTAssertEqual(r.posts[4].account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[4].attachments.count, 0)
				XCTAssertEqual(r.posts[4].links.count, 0)
				XCTAssertEqual(r.posts[4].replyTo, 303)
				XCTAssertNil(r.posts[4].mention)
				XCTAssertEqual(r.posts[4].likes.count, 0)
				XCTAssertEqual(r.posts[4].updatedAt.description, "2014-06-30 13:32:29 +0000")
				XCTAssertEqual(r.posts[4].talks.count, 0)
				XCTAssertEqual(r.posts[4].message, "Yes, I do the whole Lonely Hearts thing! Hello, IT.")
				XCTAssertEqual(r.posts[4].id, 304)
				XCTAssertEqual(r.posts[4].createdAt.description, "2014-06-30 13:32:29 +0000")
				XCTAssertEqual(r.posts[5].topicId, 208)
				XCTAssertEqual(r.posts[5].account.name, "cooper")
				XCTAssertEqual(r.posts[5].account.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.posts[5].account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.posts[5].account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[5].account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.posts[5].account.id, 104)
				XCTAssertEqual(r.posts[5].account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[5].attachments.count, 0)
				XCTAssertEqual(r.posts[5].links.count, 0)
				XCTAssertNil(r.posts[5].replyTo)
				XCTAssertNil(r.posts[5].mention)
				XCTAssertEqual(r.posts[5].likes.count, 0)
				XCTAssertEqual(r.posts[5].updatedAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts[5].talks.count, 2)
				XCTAssertEqual(r.posts[5].talks[0].topicId, 208)
				XCTAssertEqual(r.posts[5].talks[0].name, "2nd talk")
				XCTAssertNil(r.posts[5].talks[0].backlog)
				XCTAssertEqual(r.posts[5].talks[0].suggestion, "2nd talk")
				XCTAssertEqual(r.posts[5].talks[0].updatedAt.description, "2014-07-02 03:55:29 +0000")
				XCTAssertEqual(r.posts[5].talks[0].id, 901)
				XCTAssertEqual(r.posts[5].talks[0].createdAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts[5].talks[1].topicId, 208)
				XCTAssertEqual(r.posts[5].talks[1].name, "About us")
				XCTAssertNil(r.posts[5].talks[1].backlog)
				XCTAssertEqual(r.posts[5].talks[1].suggestion, "About us")
				XCTAssertEqual(r.posts[5].talks[1].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts[5].talks[1].id, 900)
				XCTAssertEqual(r.posts[5].talks[1].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.posts[5].message, "And I'm a 32 year old IT-man who works in a basement. Word.")
				XCTAssertEqual(r.posts[5].id, 305)
				XCTAssertEqual(r.posts[5].createdAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts[6].topicId, 208)
				XCTAssertEqual(r.posts[6].account.name, "jessica")
				XCTAssertEqual(r.posts[6].account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts[6].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[6].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[6].account.id, 100)
				XCTAssertEqual(r.posts[6].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].attachments.count, 0)
				XCTAssertEqual(r.posts[6].links.count, 0)
				XCTAssertEqual(r.posts[6].replyTo, 305)
				XCTAssertNil(r.posts[6].mention)
				XCTAssertEqual(r.posts[6].likes.count, 5)
				XCTAssertNil(r.posts[6].likes[0].comment)
				XCTAssertEqual(r.posts[6].likes[0].topicId, 208)
				XCTAssertEqual(r.posts[6].likes[0].account!.name, "ahorowitz")
				XCTAssertEqual(r.posts[6].likes[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.posts[6].likes[0].account!.suggestion, "AHorowitz")
				XCTAssertEqual(r.posts[6].likes[0].account!.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[0].account!.fullName, "AHorowitz")
				XCTAssertEqual(r.posts[6].likes[0].account!.id, 101)
				XCTAssertEqual(r.posts[6].likes[0].account!.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[0].postId, 306)
				XCTAssertEqual(r.posts[6].likes[0].id, 403)
				XCTAssertNil(r.posts[6].likes[1].comment)
				XCTAssertEqual(r.posts[6].likes[1].topicId, 208)
				XCTAssertEqual(r.posts[6].likes[1].account!.name, "moss")
				XCTAssertEqual(r.posts[6].likes[1].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.posts[6].likes[1].account!.suggestion, "Moss")
				XCTAssertEqual(r.posts[6].likes[1].account!.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[1].account!.fullName, "Moss")
				XCTAssertEqual(r.posts[6].likes[1].account!.id, 102)
				XCTAssertEqual(r.posts[6].likes[1].account!.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[1].postId, 306)
				XCTAssertEqual(r.posts[6].likes[1].id, 404)
				XCTAssertNil(r.posts[6].likes[2].comment)
				XCTAssertEqual(r.posts[6].likes[2].topicId, 208)
				XCTAssertEqual(r.posts[6].likes[2].account!.name, "stefhull")
				XCTAssertEqual(r.posts[6].likes[2].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.posts[6].likes[2].account!.suggestion, "StefHull")
				XCTAssertEqual(r.posts[6].likes[2].account!.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[2].account!.fullName, "StefHull")
				XCTAssertEqual(r.posts[6].likes[2].account!.id, 103)
				XCTAssertEqual(r.posts[6].likes[2].account!.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[2].postId, 306)
				XCTAssertEqual(r.posts[6].likes[2].id, 405)
				XCTAssertNil(r.posts[6].likes[3].comment)
				XCTAssertEqual(r.posts[6].likes[3].topicId, 208)
				XCTAssertEqual(r.posts[6].likes[3].account!.name, "cooper")
				XCTAssertEqual(r.posts[6].likes[3].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.posts[6].likes[3].account!.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.posts[6].likes[3].account!.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[3].account!.fullName, "CooperDaChopper")
				XCTAssertEqual(r.posts[6].likes[3].account!.id, 104)
				XCTAssertEqual(r.posts[6].likes[3].account!.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[3].postId, 306)
				XCTAssertEqual(r.posts[6].likes[3].id, 406)
				XCTAssertNil(r.posts[6].likes[4].comment)
				XCTAssertEqual(r.posts[6].likes[4].topicId, 208)
				XCTAssertEqual(r.posts[6].likes[4].account!.name, "brad")
				XCTAssertEqual(r.posts[6].likes[4].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.posts[6].likes[4].account!.suggestion, "BradMarshalls")
				XCTAssertEqual(r.posts[6].likes[4].account!.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[4].account!.fullName, "BradMarshalls")
				XCTAssertEqual(r.posts[6].likes[4].account!.id, 105)
				XCTAssertEqual(r.posts[6].likes[4].account!.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.posts[6].likes[4].postId, 306)
				XCTAssertEqual(r.posts[6].likes[4].id, 407)
				XCTAssertEqual(r.posts[6].updatedAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.posts[6].talks.count, 1)
				XCTAssertEqual(r.posts[6].talks[0].topicId, 208)
				XCTAssertEqual(r.posts[6].talks[0].name, "About us")
				XCTAssertNil(r.posts[6].talks[0].backlog)
				XCTAssertEqual(r.posts[6].talks[0].suggestion, "About us")
				XCTAssertEqual(r.posts[6].talks[0].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts[6].talks[0].id, 900)
				XCTAssertEqual(r.posts[6].talks[0].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.posts[6].message, "Oh. What time of the month? The weekend?")
				XCTAssertEqual(r.posts[6].id, 306)
				XCTAssertEqual(r.posts[6].createdAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.posts[7].topicId, 208)
				XCTAssertEqual(r.posts[7].account.name, "jessica")
				XCTAssertEqual(r.posts[7].account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts[7].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[7].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[7].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[7].account.id, 100)
				XCTAssertEqual(r.posts[7].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[7].attachments.count, 0)
				XCTAssertEqual(r.posts[7].links.count, 0)
				XCTAssertEqual(r.posts[7].replyTo, 306)
				XCTAssertNil(r.posts[7].mention)
				XCTAssertEqual(r.posts[7].likes.count, 1)
				XCTAssertNil(r.posts[7].likes[0].comment)
				XCTAssertEqual(r.posts[7].likes[0].topicId, 208)
				XCTAssertEqual(r.posts[7].likes[0].account!.name, "jessica")
				XCTAssertEqual(r.posts[7].likes[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts[7].likes[0].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[7].likes[0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[7].likes[0].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[7].likes[0].account!.id, 100)
				XCTAssertEqual(r.posts[7].likes[0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[7].likes[0].postId, 307)
				XCTAssertEqual(r.posts[7].likes[0].id, 408)
				XCTAssertEqual(r.posts[7].updatedAt.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.posts[7].talks.count, 0)
				XCTAssertEqual(r.posts[7].message, "Hope it doesn't sound arrogant but I'm the greatest man in the world!")
				XCTAssertEqual(r.posts[7].id, 307)
				XCTAssertEqual(r.posts[7].createdAt.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertNil(r.team)

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
			case .Success(let r):
				XCTAssertEqual(r.access!.unopened, 0)
				XCTAssertEqual(r.mention!.unread, 1)
				XCTAssertEqual(r.invite!.topic!.pending, 2)
				XCTAssertEqual(r.invite!.team!.pending, 0)

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
			case .Success(let r):
				XCTAssertEqual(r.mentions.count, 2)
				XCTAssertEqual(r.mentions[0].post.topicId, 203)
				XCTAssertEqual(r.mentions[0].post.account.name, "moss")
				XCTAssertEqual(r.mentions[0].post.account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.mentions[0].post.account.suggestion, "Moss")
				XCTAssertEqual(r.mentions[0].post.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.account.fullName, "Moss")
				XCTAssertEqual(r.mentions[0].post.account.id, 102)
				XCTAssertEqual(r.mentions[0].post.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.attachments.count, 0)
				XCTAssertEqual(r.mentions[0].post.links.count, 0)
				XCTAssertNil(r.mentions[0].post.replyTo)
				XCTAssertEqual(r.mentions[0].post.topic!.name, "Techies")
				XCTAssertEqual(r.mentions[0].post.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.topic!.suggestion, "Techies")
				XCTAssertEqual(r.mentions[0].post.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.topic!.id, 203)
				XCTAssertEqual(r.mentions[0].post.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.updatedAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post.message, "@jessica Help me!")
				XCTAssertEqual(r.mentions[0].post.id, 309)
				XCTAssertEqual(r.mentions[0].post.createdAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions[0].id, 501)
				XCTAssertNil(r.mentions[0].readAt)
				XCTAssertEqual(r.mentions[1].post.topicId, 202)
				XCTAssertEqual(r.mentions[1].post.account.name, "ahorowitz")
				XCTAssertEqual(r.mentions[1].post.account.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.mentions[1].post.account.suggestion, "AHorowitz")
				XCTAssertEqual(r.mentions[1].post.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.account.fullName, "AHorowitz")
				XCTAssertEqual(r.mentions[1].post.account.id, 101)
				XCTAssertEqual(r.mentions[1].post.account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.attachments.count, 0)
				XCTAssertEqual(r.mentions[1].post.links.count, 0)
				XCTAssertNil(r.mentions[1].post.replyTo)
				XCTAssertEqual(r.mentions[1].post.topic!.name, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions[1].post.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.topic!.suggestion, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions[1].post.topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.topic!.id, 202)
				XCTAssertEqual(r.mentions[1].post.topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.updatedAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post.message, "@jessica What do you think about this?")
				XCTAssertEqual(r.mentions[1].post.id, 308)
				XCTAssertEqual(r.mentions[1].post.createdAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions[1].id, 500)
				XCTAssertEqual(r.mentions[1].readAt!.description, "2014-06-30 15:00:00 +0000")
				XCTAssertEqual(r.invites.topics.count, 2)
				XCTAssertEqual(r.invites.topics[0].account!.name, "jessica")
				XCTAssertEqual(r.invites.topics[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.invites.topics[0].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics[0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics[0].account!.id, 100)
				XCTAssertEqual(r.invites.topics[0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].sender!.name, "brad")
				XCTAssertEqual(r.invites.topics[0].sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.invites.topics[0].sender!.suggestion, "BradMarshalls")
				XCTAssertEqual(r.invites.topics[0].sender!.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].sender!.fullName, "BradMarshalls")
				XCTAssertEqual(r.invites.topics[0].sender!.id, 105)
				XCTAssertEqual(r.invites.topics[0].sender!.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].topic!.name, "Development")
				XCTAssertEqual(r.invites.topics[0].topic!.lastPostedAt!.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].topic!.suggestion, "Development")
				XCTAssertEqual(r.invites.topics[0].topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].topic!.id, 210)
				XCTAssertEqual(r.invites.topics[0].topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].updatedAt!.description, "2014-07-04 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[0].message, "It is a new project. Join us!")
				XCTAssertEqual(r.invites.topics[0].id, 601)
				XCTAssertEqual(r.invites.topics[0].createdAt!.description, "2014-07-04 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].account!.name, "jessica")
				XCTAssertEqual(r.invites.topics[1].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.invites.topics[1].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics[1].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics[1].account!.id, 100)
				XCTAssertEqual(r.invites.topics[1].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].sender!.name, "chelseab")
				XCTAssertEqual(r.invites.topics[1].sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.invites.topics[1].sender!.suggestion, "ChelseaB")
				XCTAssertEqual(r.invites.topics[1].sender!.updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].sender!.fullName, "ChelseaB")
				XCTAssertEqual(r.invites.topics[1].sender!.id, 106)
				XCTAssertEqual(r.invites.topics[1].sender!.createdAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].topic!.name, "Web Site")
				XCTAssertEqual(r.invites.topics[1].topic!.lastPostedAt!.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].topic!.suggestion, "Web Site")
				XCTAssertEqual(r.invites.topics[1].topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].topic!.id, 209)
				XCTAssertEqual(r.invites.topics[1].topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].updatedAt!.description, "2014-07-03 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics[1].message, "It is a new project. Join us!")
				XCTAssertEqual(r.invites.topics[1].id, 600)
				XCTAssertEqual(r.invites.topics[1].createdAt!.description, "2014-07-03 02:32:29 +0000")
				XCTAssertEqual(r.invites.teams.count, 0)

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testGetProfile() {
		createStub("get-profile")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(GetProfile()) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.account.name, "jessica")
				XCTAssertEqual(r.account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.account.id, 100)
				XCTAssertEqual(r.account.createdAt.description, "2014-06-24 02:32:29 +0000")

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testGetSpaceMembers() {
		createStub("get-space-members")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(GetSpaceMembers(spaceKey: "")) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.accounts.count, 7)
				XCTAssertEqual(r.accounts[0].name, "ahorowitz")
				XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.accounts[0].suggestion, "AHorowitz")
				XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].fullName, "AHorowitz")
				XCTAssertEqual(r.accounts[0].id, 101)
				XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].name, "brad")
				XCTAssertEqual(r.accounts[1].imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts[1].suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts[1].updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts[1].id, 105)
				XCTAssertEqual(r.accounts[1].createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].name, "chelseab")
				XCTAssertEqual(r.accounts[2].imageUrl.absoluteString, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.accounts[2].suggestion, "ChelseaB")
				XCTAssertEqual(r.accounts[2].updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].fullName, "ChelseaB")
				XCTAssertEqual(r.accounts[2].id, 106)
				XCTAssertEqual(r.accounts[2].createdAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.accounts[3].name, "cooper")
				XCTAssertEqual(r.accounts[3].imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts[3].suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts[3].updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[3].fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts[3].id, 104)
				XCTAssertEqual(r.accounts[3].createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[4].name, "jessica")
				XCTAssertEqual(r.accounts[4].imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.accounts[4].suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[4].updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[4].fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[4].id, 100)
				XCTAssertEqual(r.accounts[4].createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[5].name, "moss")
				XCTAssertEqual(r.accounts[5].imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.accounts[5].suggestion, "Moss")
				XCTAssertEqual(r.accounts[5].updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.accounts[5].fullName, "Moss")
				XCTAssertEqual(r.accounts[5].id, 102)
				XCTAssertEqual(r.accounts[5].createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.accounts[6].name, "stefhull")
				XCTAssertEqual(r.accounts[6].imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.accounts[6].suggestion, "StefHull")
				XCTAssertEqual(r.accounts[6].updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.accounts[6].fullName, "StefHull")
				XCTAssertEqual(r.accounts[6].id, 103)
				XCTAssertEqual(r.accounts[6].createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.groups.count, 4)
				XCTAssertEqual(r.groups[0].memberCount, 1)
				XCTAssertEqual(r.groups[0].group.key, "groupkey03")
				XCTAssertEqual(r.groups[0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey03/photo/medium")
				XCTAssertEqual(r.groups[0].group.suggestion, "Cycling team")
				XCTAssertEqual(r.groups[0].group.updatedAt.description, "2014-06-12 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.id, 1102)
				XCTAssertEqual(r.groups[0].group.createdAt.description, "2014-06-12 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.name, "Cycling team")
				XCTAssertEqual(r.groups[1].memberCount, 4)
				XCTAssertEqual(r.groups[1].group.key, "groupkey01")
				XCTAssertEqual(r.groups[1].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
				XCTAssertEqual(r.groups[1].group.suggestion, "Joe Tech Inc. All")
				XCTAssertEqual(r.groups[1].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[1].group.id, 1100)
				XCTAssertEqual(r.groups[1].group.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[1].group.name, "Joe Tech Inc. All")
				XCTAssertEqual(r.groups[2].memberCount, 1)
				XCTAssertEqual(r.groups[2].group.key, "groupkey02")
				XCTAssertEqual(r.groups[2].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey02/photo/medium")
				XCTAssertEqual(r.groups[2].group.suggestion, "OSS Project")
				XCTAssertEqual(r.groups[2].group.updatedAt.description, "2014-06-11 02:32:29 +0000")
				XCTAssertEqual(r.groups[2].group.id, 1101)
				XCTAssertEqual(r.groups[2].group.createdAt.description, "2014-06-11 02:32:29 +0000")
				XCTAssertEqual(r.groups[2].group.name, "OSS Project")
				XCTAssertEqual(r.groups[3].memberCount, 1)
				XCTAssertEqual(r.groups[3].group.key, "groupkey04")
				XCTAssertEqual(r.groups[3].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey04/photo/medium")
				XCTAssertEqual(r.groups[3].group.suggestion, "WP Team")
				XCTAssertEqual(r.groups[3].group.updatedAt.description, "2014-06-13 02:32:29 +0000")
				XCTAssertEqual(r.groups[3].group.id, 1103)
				XCTAssertEqual(r.groups[3].group.createdAt.description, "2014-06-13 02:32:29 +0000")
				XCTAssertEqual(r.groups[3].group.name, "WP Team")

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testGetSpaces() {
		createStub("get-spaces")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(GetSpaces()) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.mySpaces.count, 2)
				XCTAssertEqual(r.mySpaces[0].myRole, "ADMIN")
				XCTAssertEqual(r.mySpaces[0].isPaymentAdmin, true)
				XCTAssertEqual(r.mySpaces[0].myPlan.numberOfUsers, 4)
				XCTAssertEqual(r.mySpaces[0].myPlan.enabled, true)
				XCTAssertNil(r.mySpaces[0].myPlan.trial)
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpaces[0].myPlan.updatedAt.description, "2016-03-04 02:37:08 +0000")
				XCTAssertEqual(r.mySpaces[0].myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpaces[0].myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpaces[0].space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpaces[0].space.enabled, true)
				XCTAssertEqual(r.mySpaces[0].space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpaces[0].space.key, "abcdefghij")
				XCTAssertEqual(r.mySpaces[1].myRole, "USER")
				XCTAssertEqual(r.mySpaces[1].isPaymentAdmin, false)
				XCTAssertEqual(r.mySpaces[1].myPlan.numberOfUsers, 2)
				XCTAssertEqual(r.mySpaces[1].myPlan.enabled, true)
				XCTAssertEqual(r.mySpaces[1].myPlan.trial!.endDate, "2016-03-18")
				XCTAssertEqual(r.mySpaces[1].myPlan.trial!.daysLeft, 15)
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.name, "Starter Plan")
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.key, "typetalk.starter")
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.limitTotalAttachmentSize, 10737418240)
				XCTAssertEqual(r.mySpaces[1].myPlan.updatedAt.description, "2016-03-04 02:36:38 +0000")
				XCTAssertEqual(r.mySpaces[1].myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpaces[1].myPlan.createdAt.description, "2016-02-18 02:36:38 +0000")
				XCTAssertEqual(r.mySpaces[1].space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/0123456789/photo/large")
				XCTAssertEqual(r.mySpaces[1].space.enabled, true)
				XCTAssertEqual(r.mySpaces[1].space.name, "Nu team")
				XCTAssertEqual(r.mySpaces[1].space.key, "0123456789")

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
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.hasNext, false)
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 4)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-03-04 02:37:08 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.posts.count, 2)
				XCTAssertEqual(r.posts[0].topicId, 208)
				XCTAssertEqual(r.posts[0].account.name, "cooper")
				XCTAssertEqual(r.posts[0].account.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.posts[0].account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.posts[0].account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[0].account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.posts[0].account.id, 104)
				XCTAssertEqual(r.posts[0].account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[0].attachments.count, 0)
				XCTAssertEqual(r.posts[0].links.count, 0)
				XCTAssertNil(r.posts[0].replyTo)
				XCTAssertNil(r.posts[0].mention)
				XCTAssertEqual(r.posts[0].likes.count, 0)
				XCTAssertEqual(r.posts[0].updatedAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts[0].talks.count, 2)
				XCTAssertEqual(r.posts[0].talks[0].topicId, 208)
				XCTAssertEqual(r.posts[0].talks[0].name, "2nd talk")
				XCTAssertNil(r.posts[0].talks[0].backlog)
				XCTAssertEqual(r.posts[0].talks[0].suggestion, "2nd talk")
				XCTAssertEqual(r.posts[0].talks[0].updatedAt.description, "2014-07-02 03:55:29 +0000")
				XCTAssertEqual(r.posts[0].talks[0].id, 901)
				XCTAssertEqual(r.posts[0].talks[0].createdAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts[0].talks[1].topicId, 208)
				XCTAssertEqual(r.posts[0].talks[1].name, "About us")
				XCTAssertNil(r.posts[0].talks[1].backlog)
				XCTAssertEqual(r.posts[0].talks[1].suggestion, "About us")
				XCTAssertEqual(r.posts[0].talks[1].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts[0].talks[1].id, 900)
				XCTAssertEqual(r.posts[0].talks[1].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.posts[0].message, "And I'm a 32 year old IT-man who works in a basement. Word.")
				XCTAssertEqual(r.posts[0].id, 305)
				XCTAssertEqual(r.posts[0].createdAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts[1].topicId, 208)
				XCTAssertEqual(r.posts[1].account.name, "jessica")
				XCTAssertEqual(r.posts[1].account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts[1].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[1].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts[1].account.id, 100)
				XCTAssertEqual(r.posts[1].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].attachments.count, 0)
				XCTAssertEqual(r.posts[1].links.count, 0)
				XCTAssertEqual(r.posts[1].replyTo, 305)
				XCTAssertNil(r.posts[1].mention)
				XCTAssertEqual(r.posts[1].likes.count, 5)
				XCTAssertNil(r.posts[1].likes[0].comment)
				XCTAssertEqual(r.posts[1].likes[0].topicId, 208)
				XCTAssertEqual(r.posts[1].likes[0].account!.name, "ahorowitz")
				XCTAssertEqual(r.posts[1].likes[0].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.posts[1].likes[0].account!.suggestion, "AHorowitz")
				XCTAssertEqual(r.posts[1].likes[0].account!.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[0].account!.fullName, "AHorowitz")
				XCTAssertEqual(r.posts[1].likes[0].account!.id, 101)
				XCTAssertEqual(r.posts[1].likes[0].account!.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[0].postId, 306)
				XCTAssertEqual(r.posts[1].likes[0].id, 403)
				XCTAssertNil(r.posts[1].likes[1].comment)
				XCTAssertEqual(r.posts[1].likes[1].topicId, 208)
				XCTAssertEqual(r.posts[1].likes[1].account!.name, "moss")
				XCTAssertEqual(r.posts[1].likes[1].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.posts[1].likes[1].account!.suggestion, "Moss")
				XCTAssertEqual(r.posts[1].likes[1].account!.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[1].account!.fullName, "Moss")
				XCTAssertEqual(r.posts[1].likes[1].account!.id, 102)
				XCTAssertEqual(r.posts[1].likes[1].account!.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[1].postId, 306)
				XCTAssertEqual(r.posts[1].likes[1].id, 404)
				XCTAssertNil(r.posts[1].likes[2].comment)
				XCTAssertEqual(r.posts[1].likes[2].topicId, 208)
				XCTAssertEqual(r.posts[1].likes[2].account!.name, "stefhull")
				XCTAssertEqual(r.posts[1].likes[2].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.posts[1].likes[2].account!.suggestion, "StefHull")
				XCTAssertEqual(r.posts[1].likes[2].account!.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[2].account!.fullName, "StefHull")
				XCTAssertEqual(r.posts[1].likes[2].account!.id, 103)
				XCTAssertEqual(r.posts[1].likes[2].account!.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[2].postId, 306)
				XCTAssertEqual(r.posts[1].likes[2].id, 405)
				XCTAssertNil(r.posts[1].likes[3].comment)
				XCTAssertEqual(r.posts[1].likes[3].topicId, 208)
				XCTAssertEqual(r.posts[1].likes[3].account!.name, "cooper")
				XCTAssertEqual(r.posts[1].likes[3].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.posts[1].likes[3].account!.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.posts[1].likes[3].account!.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[3].account!.fullName, "CooperDaChopper")
				XCTAssertEqual(r.posts[1].likes[3].account!.id, 104)
				XCTAssertEqual(r.posts[1].likes[3].account!.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[3].postId, 306)
				XCTAssertEqual(r.posts[1].likes[3].id, 406)
				XCTAssertNil(r.posts[1].likes[4].comment)
				XCTAssertEqual(r.posts[1].likes[4].topicId, 208)
				XCTAssertEqual(r.posts[1].likes[4].account!.name, "brad")
				XCTAssertEqual(r.posts[1].likes[4].account!.imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.posts[1].likes[4].account!.suggestion, "BradMarshalls")
				XCTAssertEqual(r.posts[1].likes[4].account!.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[4].account!.fullName, "BradMarshalls")
				XCTAssertEqual(r.posts[1].likes[4].account!.id, 105)
				XCTAssertEqual(r.posts[1].likes[4].account!.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.posts[1].likes[4].postId, 306)
				XCTAssertEqual(r.posts[1].likes[4].id, 407)
				XCTAssertEqual(r.posts[1].updatedAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.posts[1].talks.count, 1)
				XCTAssertEqual(r.posts[1].talks[0].topicId, 208)
				XCTAssertEqual(r.posts[1].talks[0].name, "About us")
				XCTAssertNil(r.posts[1].talks[0].backlog)
				XCTAssertEqual(r.posts[1].talks[0].suggestion, "About us")
				XCTAssertEqual(r.posts[1].talks[0].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts[1].talks[0].id, 900)
				XCTAssertEqual(r.posts[1].talks[0].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.posts[1].message, "Oh. What time of the month? The weekend?")
				XCTAssertEqual(r.posts[1].id, 306)
				XCTAssertEqual(r.posts[1].createdAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "About us")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "About us")
				XCTAssertEqual(r.talk.updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.talk.id, 900)
				XCTAssertEqual(r.talk.createdAt.description, "2014-07-02 03:42:29 +0000")

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
				XCTAssertEqual(r.talks[0].topicId, 208)
				XCTAssertEqual(r.talks[0].name, "2nd talk")
				XCTAssertNil(r.talks[0].backlog)
				XCTAssertEqual(r.talks[0].suggestion, "2nd talk")
				XCTAssertEqual(r.talks[0].updatedAt.description, "2014-07-02 03:55:29 +0000")
				XCTAssertEqual(r.talks[0].id, 901)
				XCTAssertEqual(r.talks[0].createdAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.talks[1].topicId, 208)
				XCTAssertEqual(r.talks[1].name, "About us")
				XCTAssertNil(r.talks[1].backlog)
				XCTAssertEqual(r.talks[1].suggestion, "About us")
				XCTAssertEqual(r.talks[1].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.talks[1].id, 900)
				XCTAssertEqual(r.talks[1].createdAt.description, "2014-07-02 03:42:29 +0000")

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
			case .Success(let r):
				XCTAssertEqual(r.integrations.count, 0)
				XCTAssertNil(r.remainingInvitations)
				XCTAssertEqual(r.groups.count, 1)
				XCTAssertEqual(r.groups[0].memberCount, 4)
				XCTAssertEqual(r.groups[0].group.key, "groupkey01")
				XCTAssertEqual(r.groups[0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
				XCTAssertEqual(r.groups[0].group.suggestion, "Joe Tech Inc. All")
				XCTAssertEqual(r.groups[0].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.id, 1100)
				XCTAssertEqual(r.groups[0].group.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.name, "Joe Tech Inc. All")
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-03-04 02:37:07 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.accountsForApi.count, 0)
				XCTAssertEqual(r.teams.count, 0)
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.accounts.count, 2)
				XCTAssertEqual(r.accounts[0].name, "brad")
				XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts[0].suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts[0].id, 105)
				XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].name, "cooper")
				XCTAssertEqual(r.accounts[1].imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts[1].suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts[1].updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts[1].id, 104)
				XCTAssertEqual(r.accounts[1].createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.invitingAccounts.count, 0)
				XCTAssertEqual(r.invites.count, 0)

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
			case .Success(let r):
				XCTAssertEqual(r.pendings.count, 0)
				XCTAssertEqual(r.accounts.count, 6)
				XCTAssertEqual(r.accounts[0].account.name, "ahorowitz")
				XCTAssertEqual(r.accounts[0].account.imageUrl.absoluteString, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.accounts[0].account.suggestion, "AHorowitz")
				XCTAssertEqual(r.accounts[0].account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].account.fullName, "AHorowitz")
				XCTAssertEqual(r.accounts[0].account.id, 101)
				XCTAssertEqual(r.accounts[0].account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].online, false)
				XCTAssertEqual(r.accounts[1].account.name, "brad")
				XCTAssertEqual(r.accounts[1].account.imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts[1].account.suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts[1].account.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].account.fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts[1].account.id, 105)
				XCTAssertEqual(r.accounts[1].account.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].online, false)
				XCTAssertEqual(r.accounts[2].account.name, "cooper")
				XCTAssertEqual(r.accounts[2].account.imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts[2].account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts[2].account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts[2].account.id, 104)
				XCTAssertEqual(r.accounts[2].account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].online, false)
				XCTAssertEqual(r.accounts[3].account.name, "jessica")
				XCTAssertEqual(r.accounts[3].account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.accounts[3].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[3].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[3].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[3].account.id, 100)
				XCTAssertEqual(r.accounts[3].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[3].online, false)
				XCTAssertEqual(r.accounts[4].account.name, "moss")
				XCTAssertEqual(r.accounts[4].account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.accounts[4].account.suggestion, "Moss")
				XCTAssertEqual(r.accounts[4].account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.accounts[4].account.fullName, "Moss")
				XCTAssertEqual(r.accounts[4].account.id, 102)
				XCTAssertEqual(r.accounts[4].account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.accounts[4].online, false)
				XCTAssertEqual(r.accounts[5].account.name, "stefhull")
				XCTAssertEqual(r.accounts[5].account.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.accounts[5].account.suggestion, "StefHull")
				XCTAssertEqual(r.accounts[5].account.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.accounts[5].account.fullName, "StefHull")
				XCTAssertEqual(r.accounts[5].account.id, 103)
				XCTAssertEqual(r.accounts[5].account.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.accounts[5].online, false)

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
				XCTAssertEqual(r.topics.count, 9)
				XCTAssertEqual(r.topics[0].topic.name, "IT Peeps")
				XCTAssertEqual(r.topics[0].topic.lastPostedAt!.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.topics[0].topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topics[0].topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topics[0].topic.id, 208)
				XCTAssertEqual(r.topics[0].topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topics[0].unread!.count, 3)
				XCTAssertEqual(r.topics[0].unread!.topicId, 208)
				XCTAssertEqual(r.topics[0].unread!.postId, 304)
				XCTAssertEqual(r.topics[0].favorite, true)
				XCTAssertEqual(r.topics[1].topic.name, "VisualDesigners")
				XCTAssertEqual(r.topics[1].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[1].topic.suggestion, "VisualDesigners")
				XCTAssertEqual(r.topics[1].topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topics[1].topic.id, 206)
				XCTAssertEqual(r.topics[1].topic.createdAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topics[1].unread!.count, 0)
				XCTAssertEqual(r.topics[1].unread!.topicId, 206)
				XCTAssertEqual(r.topics[1].unread!.postId, 0)
				XCTAssertEqual(r.topics[1].favorite, false)
				XCTAssertEqual(r.topics[2].topic.name, "Creatives Home")
				XCTAssertEqual(r.topics[2].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[2].topic.suggestion, "Creatives Home")
				XCTAssertEqual(r.topics[2].topic.updatedAt.description, "2014-06-06 02:32:29 +0000")
				XCTAssertEqual(r.topics[2].topic.id, 204)
				XCTAssertEqual(r.topics[2].topic.createdAt.description, "2014-06-06 02:32:29 +0000")
				XCTAssertEqual(r.topics[2].unread!.count, 0)
				XCTAssertEqual(r.topics[2].unread!.topicId, 204)
				XCTAssertEqual(r.topics[2].unread!.postId, 0)
				XCTAssertEqual(r.topics[2].favorite, false)
				XCTAssertEqual(r.topics[3].topic.name, "Communications Team")
				XCTAssertEqual(r.topics[3].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[3].topic.suggestion, "Communications Team")
				XCTAssertEqual(r.topics[3].topic.updatedAt.description, "2014-06-03 02:32:29 +0000")
				XCTAssertEqual(r.topics[3].topic.id, 201)
				XCTAssertEqual(r.topics[3].topic.createdAt.description, "2014-06-03 02:32:29 +0000")
				XCTAssertEqual(r.topics[3].unread!.count, 0)
				XCTAssertEqual(r.topics[3].unread!.topicId, 201)
				XCTAssertEqual(r.topics[3].unread!.postId, 0)
				XCTAssertEqual(r.topics[3].favorite, false)
				XCTAssertEqual(r.topics[4].topic.name, "Art Directors")
				XCTAssertEqual(r.topics[4].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[4].topic.suggestion, "Art Directors")
				XCTAssertEqual(r.topics[4].topic.updatedAt.description, "2014-06-09 02:32:29 +0000")
				XCTAssertEqual(r.topics[4].topic.id, 207)
				XCTAssertEqual(r.topics[4].topic.createdAt.description, "2014-06-09 02:32:29 +0000")
				XCTAssertEqual(r.topics[4].unread!.count, 0)
				XCTAssertEqual(r.topics[4].unread!.topicId, 207)
				XCTAssertEqual(r.topics[4].unread!.postId, 0)
				XCTAssertEqual(r.topics[4].favorite, true)
				XCTAssertEqual(r.topics[5].topic.name, "Arts & Crafts Club")
				XCTAssertEqual(r.topics[5].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[5].topic.suggestion, "Arts & Crafts Club")
				XCTAssertEqual(r.topics[5].topic.updatedAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.topics[5].topic.id, 202)
				XCTAssertEqual(r.topics[5].topic.createdAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.topics[5].unread!.count, 1)
				XCTAssertEqual(r.topics[5].unread!.topicId, 202)
				XCTAssertEqual(r.topics[5].unread!.postId, 0)
				XCTAssertEqual(r.topics[5].favorite, true)
				XCTAssertEqual(r.topics[6].topic.name, "UI/UX")
				XCTAssertEqual(r.topics[6].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[6].topic.suggestion, "UI/UX")
				XCTAssertEqual(r.topics[6].topic.updatedAt.description, "2014-06-07 02:32:29 +0000")
				XCTAssertEqual(r.topics[6].topic.id, 205)
				XCTAssertEqual(r.topics[6].topic.createdAt.description, "2014-06-07 02:32:29 +0000")
				XCTAssertEqual(r.topics[6].unread!.count, 0)
				XCTAssertEqual(r.topics[6].unread!.topicId, 205)
				XCTAssertEqual(r.topics[6].unread!.postId, 0)
				XCTAssertEqual(r.topics[6].favorite, true)
				XCTAssertEqual(r.topics[7].topic.name, "Creative Technologists")
				XCTAssertEqual(r.topics[7].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[7].topic.suggestion, "Creative Technologists")
				XCTAssertEqual(r.topics[7].topic.updatedAt.description, "2014-06-02 02:32:29 +0000")
				XCTAssertEqual(r.topics[7].topic.id, 200)
				XCTAssertEqual(r.topics[7].topic.createdAt.description, "2014-06-02 02:32:29 +0000")
				XCTAssertEqual(r.topics[7].unread!.count, 0)
				XCTAssertEqual(r.topics[7].unread!.topicId, 200)
				XCTAssertEqual(r.topics[7].unread!.postId, 0)
				XCTAssertEqual(r.topics[7].favorite, false)
				XCTAssertEqual(r.topics[8].topic.name, "Techies")
				XCTAssertEqual(r.topics[8].topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[8].topic.suggestion, "Techies")
				XCTAssertEqual(r.topics[8].topic.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.topics[8].topic.id, 203)
				XCTAssertEqual(r.topics[8].topic.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.topics[8].unread!.count, 1)
				XCTAssertEqual(r.topics[8].unread!.topicId, 203)
				XCTAssertEqual(r.topics[8].unread!.postId, 0)
				XCTAssertEqual(r.topics[8].favorite, false)

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
				XCTAssertEqual(r.like.comment, "")
				XCTAssertEqual(r.like.topicId, 208)
				XCTAssertEqual(r.like.account!.name, "jessica")
				XCTAssertEqual(r.like.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.like.account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.like.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.like.account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.like.account!.id, 100)
				XCTAssertEqual(r.like.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.like.postId, 305)
				XCTAssertEqual(r.like.id, 604)

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
			case .Success(let r):
				XCTAssertEqual(r.access!.unopened, 0)

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
		TypetalkAPI.sendRequest(PostMessage(topicId: 0, message: "")) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic!.name, "IT Peeps")
				XCTAssertEqual(r.topic!.lastPostedAt!.description, "2016-03-04 02:36:51 +0000")
				XCTAssertEqual(r.topic!.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic!.id, 208)
				XCTAssertEqual(r.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.mentions.count, 0)
				XCTAssertEqual(r.post!.topicId, 208)
				XCTAssertEqual(r.post!.account.name, "jessica")
				XCTAssertEqual(r.post!.account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.post!.account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.post!.account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post!.account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.post!.account.id, 100)
				XCTAssertEqual(r.post!.account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post!.attachments.count, 0)
				XCTAssertEqual(r.post!.links.count, 0)
				XCTAssertNil(r.post!.replyTo)
				XCTAssertNil(r.post!.mention)
				XCTAssertEqual(r.post!.likes.count, 0)
				XCTAssertEqual(r.post!.updatedAt.description, "2016-03-04 02:36:51 +0000")
				XCTAssertEqual(r.post!.talks.count, 0)
				XCTAssertEqual(r.post!.message, "Let's party like it's 1999!")
				XCTAssertEqual(r.post!.id, 333)
				XCTAssertEqual(r.post!.createdAt.description, "2016-03-04 02:36:51 +0000")
				XCTAssertEqual(r.exceedsAttachmentLimit, false)

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testRemoveMessageFromTalk() {
		createStub("remove-message-from-talk")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(RemoveMessageFromTalk(topicId: 0, talkId: 0, postIds: [])) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.postIds.count, 2)
				XCTAssertEqual(r.postIds[0], 300)
				XCTAssertEqual(r.postIds[1], 301)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "About us")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "About us")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-03-04 02:37:15 +0000")
				XCTAssertEqual(r.talk.id, 900)
				XCTAssertEqual(r.talk.createdAt.description, "2014-07-02 03:42:29 +0000")

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
				XCTAssertEqual(r.mention.post.topicId, 203)
				XCTAssertEqual(r.mention.post.account.name, "moss")
				XCTAssertEqual(r.mention.post.account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.mention.post.account.suggestion, "Moss")
				XCTAssertEqual(r.mention.post.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mention.post.account.fullName, "Moss")
				XCTAssertEqual(r.mention.post.account.id, 102)
				XCTAssertEqual(r.mention.post.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mention.post.attachments.count, 0)
				XCTAssertEqual(r.mention.post.links.count, 0)
				XCTAssertNil(r.mention.post.replyTo)
				XCTAssertEqual(r.mention.post.topic!.name, "Techies")
				XCTAssertEqual(r.mention.post.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mention.post.topic!.suggestion, "Techies")
				XCTAssertEqual(r.mention.post.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mention.post.topic!.id, 203)
				XCTAssertEqual(r.mention.post.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mention.post.updatedAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mention.post.message, "@jessica Help me!")
				XCTAssertEqual(r.mention.post.id, 309)
				XCTAssertEqual(r.mention.post.createdAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mention.id, 501)
				XCTAssertEqual(r.mention.readAt!.description, "2016-03-04 02:37:04 +0000")

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
				XCTAssertEqual(r.unread.count, 0)
				XCTAssertEqual(r.unread.topicId, 208)
				XCTAssertEqual(r.unread.postId, 307)

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
			case .Success(let r):
				XCTAssertEqual(r.name, "moss")
				XCTAssertEqual(r.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.suggestion, "Moss")
				XCTAssertEqual(r.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.fullName, "Moss")
				XCTAssertEqual(r.id, 102)
				XCTAssertEqual(r.createdAt.description, "2014-06-26 02:32:29 +0000")

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
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "VisualDesigners")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topic.suggestion, "VisualDesigners")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 206)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.favorite, false)

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
				XCTAssertEqual(r.like.comment, "")
				XCTAssertEqual(r.like.topicId, 208)
				XCTAssertEqual(r.like.account!.name, "jessica")
				XCTAssertEqual(r.like.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.like.account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.like.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.like.account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.like.account!.id, 100)
				XCTAssertEqual(r.like.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.like.postId, 305)
				XCTAssertEqual(r.like.id, 604)

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testUpdateMessage() {
		createStub("update-message")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(UpdateMessage(topicId: 0, postId: 0, message: "")) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic!.name, "IT Peeps")
				XCTAssertEqual(r.topic!.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic!.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic!.id, 208)
				XCTAssertEqual(r.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.mentions.count, 0)
				XCTAssertEqual(r.post!.topicId, 208)
				XCTAssertEqual(r.post!.account.name, "jessica")
				XCTAssertEqual(r.post!.account.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.post!.account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.post!.account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post!.account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.post!.account.id, 100)
				XCTAssertEqual(r.post!.account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.post!.attachments.count, 0)
				XCTAssertEqual(r.post!.links.count, 0)
				XCTAssertEqual(r.post!.replyTo, 306)
				XCTAssertNil(r.post!.mention)
				XCTAssertEqual(r.post!.likes.count, 0)
				XCTAssertEqual(r.post!.updatedAt.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.post!.talks.count, 0)
				XCTAssertEqual(r.post!.message, "your message")
				XCTAssertEqual(r.post!.id, 307)
				XCTAssertEqual(r.post!.createdAt.description, "2014-07-01 02:32:29 +0000")

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testUpdateTalk() {
		createStub("update-talk")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(UpdateTalk(topicId: 0, talkId: 0, talkName: "")) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "Feedback new site design")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "Feedback new site design")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-03-04 02:37:13 +0000")
				XCTAssertEqual(r.talk.id, 902)
				XCTAssertEqual(r.talk.createdAt.description, "2016-03-04 02:37:12 +0000")

				expectation.fulfill()
			case .Failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectationsWithTimeout(3) { (error) in
			XCTAssertNil(error, "\(error)")
		}
	}


	func testUpdateTopicMembers() {
		createStub("update-topic-members")

		let expectation = expectationWithDescription("")
		TypetalkAPI.sendRequest(UpdateTopicMembers(topicId: 0)) { result in
			switch result {
			case .Success(let r):
				XCTAssertEqual(r.integrations.count, 0)
				XCTAssertNil(r.remainingInvitations)
				XCTAssertEqual(r.groups.count, 0)
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-03-04 02:37:07 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.accountsForApi.count, 0)
				XCTAssertEqual(r.teams.count, 0)
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-03-04 02:36:56 +0000")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.accounts.count, 3)
				XCTAssertEqual(r.accounts[0].name, "brad")
				XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts[0].suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts[0].id, 105)
				XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].name, "cooper")
				XCTAssertEqual(r.accounts[1].imageUrl.absoluteString, "https://typetalk.in/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts[1].suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts[1].updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts[1].id, 104)
				XCTAssertEqual(r.accounts[1].createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].name, "jessica")
				XCTAssertEqual(r.accounts[2].imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.accounts[2].suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[2].updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[2].fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[2].id, 100)
				XCTAssertEqual(r.accounts[2].createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invitingAccounts.count, 0)
				XCTAssertEqual(r.invites.count, 0)

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
			case .Success(let r):
				XCTAssertEqual(r.integrations.count, 0)
				XCTAssertNil(r.remainingInvitations)
				XCTAssertEqual(r.groups.count, 1)
				XCTAssertEqual(r.groups[0].memberCount, 4)
				XCTAssertEqual(r.groups[0].group.key, "groupkey01")
				XCTAssertEqual(r.groups[0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
				XCTAssertEqual(r.groups[0].group.suggestion, "Joe Tech Inc. All")
				XCTAssertEqual(r.groups[0].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.id, 1100)
				XCTAssertEqual(r.groups[0].group.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups[0].group.name, "Joe Tech Inc. All")
				XCTAssertEqual(r.mySpace.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace.myPlan.enabled, true)
				XCTAssertNil(r.mySpace.myPlan.trial)
				XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2016-03-04 02:37:05 +0000")
				XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
				XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace.space.enabled, true)
				XCTAssertEqual(r.mySpace.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace.space.key, "abcdefghij")
				XCTAssertEqual(r.accountsForApi.count, 0)
				XCTAssertEqual(r.teams.count, 0)
				XCTAssertEqual(r.topic.name, "Update test topic")
				XCTAssertNil(r.topic.lastPostedAt)
				XCTAssertEqual(r.topic.suggestion, "Update test topic")
				XCTAssertEqual(r.topic.updatedAt.description, "2016-03-04 02:37:06 +0000")
				XCTAssertEqual(r.topic.id, 222)
				XCTAssertEqual(r.topic.createdAt.description, "2016-03-04 02:37:05 +0000")
				XCTAssertEqual(r.accounts.count, 1)
				XCTAssertEqual(r.accounts[0].name, "chelseab")
				XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.accounts[0].suggestion, "ChelseaB")
				XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].fullName, "ChelseaB")
				XCTAssertEqual(r.accounts[0].id, 106)
				XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invitingAccounts.count, 0)
				XCTAssertEqual(r.invites.count, 0)

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
			case .Success(let r):
				XCTAssertEqual(r.fileKey, "dea1bafbd43c9cb220d3215da0fa22e60790231a")
				XCTAssertEqual(r.contentType, "image/jpeg")
				XCTAssertEqual(r.fileSize, 472263)
				XCTAssertEqual(r.fileName, "sample.jpg")

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
