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

	func createStub(_ name: String) {
		OHHTTPStubs.stubRequests(passingTest: { _ in return true }) { _ in
			let fixture = OHPathForFile("api_\(name).json", type(of: self))
			return OHHTTPStubsResponse(fileAtPath: fixture!,
				statusCode: 200, headers: ["Content-Type":"application/json"])
		}
	}

	func createStubBinary(_ name: String) {
		OHHTTPStubs.stubRequests(passingTest: { _ in return true }) { _ in
			let fixture = OHPathForFile(name, type(of: self))
			return OHHTTPStubsResponse(fileAtPath: fixture!, statusCode: 200, headers: ["Content-Type": "application/octet-stream"])
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

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetProfile()) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.lang, "en-US")
                XCTAssertEqual(r.post.emojiSkinTone, "skin-tone-4")
                XCTAssertEqual(r.post.useCtrl, false)
                XCTAssertEqual(r.account.lang, "en-US")
                XCTAssertEqual(r.account.timezoneId, "Asia/Singapore")
                XCTAssertEqual(r.account.name, "Jessica")
                XCTAssertEqual(r.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.account.isBot, false)
                XCTAssertEqual(r.account.suggestion, "Jessica")
                XCTAssertEqual(r.account.updatedAt.description, "2018-10-29 03:01:43 +0000")
                XCTAssertEqual(r.account.fullName, "Jessica")
                XCTAssertEqual(r.account.id, 2500)
                XCTAssertEqual(r.account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.theme, "light")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in

		}
	}


	func testGetFriendProfile() {
		createStub("get-friend-profile")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetFriendProfile(accountName: "")) { result in
			switch result {
			case .success(let r):

                XCTAssertNil(r.status!.mobile)
                XCTAssertNil(r.status!.web)
                XCTAssertEqual(r.status!.presence, "away")
                XCTAssertEqual(r.account.imageUpdatedAt!.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.account.name, "ahorowitz")
                XCTAssertEqual(r.account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
                XCTAssertEqual(r.account.suggestion, "AHorowitz")
                XCTAssertEqual(r.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.account.fullName, "AHorowitz")
                XCTAssertEqual(r.account.mailAddress, "ahorowitz@example.com")
                XCTAssertEqual(r.account.id, 101)
                XCTAssertEqual(r.account.createdAt.description, "2014-06-25 02:32:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in

		}
	}



	func testGetOnlineStatus() {
		createStub("get-online-status")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetOnlineStatus(accountIds: [])) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.accounts.count, 2)
				XCTAssertNil(r.accounts[0].status!.mobile)
				XCTAssertNil(r.accounts[0].status!.web)
				XCTAssertEqual(r.accounts[0].status!.presence, "away")
				XCTAssertEqual(r.accounts[0].account.name, "ahorowitz")
				XCTAssertEqual(r.accounts[0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.accounts[0].account.isBot, false)
				XCTAssertEqual(r.accounts[0].account.suggestion, "AHorowitz")
				XCTAssertEqual(r.accounts[0].account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts[0].account.fullName, "AHorowitz")
				XCTAssertEqual(r.accounts[0].account.id, 101)
				XCTAssertEqual(r.accounts[0].account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertNil(r.accounts[1].status!.mobile)
				XCTAssertNil(r.accounts[1].status!.web)
				XCTAssertEqual(r.accounts[1].status!.presence, "away")
				XCTAssertEqual(r.accounts[1].account.name, "jessica")
				XCTAssertEqual(r.accounts[1].account.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.accounts[1].account.isBot, false)
				XCTAssertEqual(r.accounts[1].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[1].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts[1].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts[1].account.id, 100)
				XCTAssertEqual(r.accounts[1].account.createdAt.description, "2014-06-24 02:32:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in

		}
	}


	func testGetTopics() {
		createStub("get-topics")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetTopics(spaceKey: "")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topics.count, 13)
				XCTAssertEqual(r.topics[0].topic.lastPostedAt!.description, "2018-03-09 12:33:04 +0000")
				XCTAssertEqual(r.topics[0].topic.name, "test illo video")
				XCTAssertEqual(r.topics[0].topic.suggestion, "test illo video")
				XCTAssertEqual(r.topics[0].topic.updatedAt.description, "2018-03-09 12:29:30 +0000")
				XCTAssertEqual(r.topics[0].topic.id, 5446)
				XCTAssertEqual(r.topics[0].topic.createdAt.description, "2018-03-09 12:29:30 +0000")
				XCTAssertEqual(r.topics[0].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[0].unread!.count, 0)
				XCTAssertEqual(r.topics[0].unread!.topicId, 5446)
				XCTAssertEqual(r.topics[0].unread!.postId, 163520)
				XCTAssertEqual(r.topics[0].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[0].favorite, true)
				XCTAssertEqual(r.topics[1].topic.lastPostedAt!.description, "2018-02-19 11:03:26 +0000")
				XCTAssertEqual(r.topics[1].topic.name, "Coffee shop")
				XCTAssertEqual(r.topics[1].topic.suggestion, "Coffee shop")
				XCTAssertEqual(r.topics[1].topic.updatedAt.description, "2017-12-21 02:41:00 +0000")
				XCTAssertEqual(r.topics[1].topic.id, 4829)
				XCTAssertEqual(r.topics[1].topic.createdAt.description, "2017-11-13 22:27:21 +0000")
				XCTAssertEqual(r.topics[1].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[1].unread!.count, 0)
				XCTAssertEqual(r.topics[1].unread!.topicId, 4829)
				XCTAssertEqual(r.topics[1].unread!.postId, 163086)
				XCTAssertEqual(r.topics[1].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[1].favorite, true)
				XCTAssertNil(r.topics[2].topic.description)
				XCTAssertEqual(r.topics[2].topic.lastPostedAt!.description, "2017-11-13 22:19:49 +0000")
				XCTAssertEqual(r.topics[2].topic.name, "Marketing")
				XCTAssertEqual(r.topics[2].topic.suggestion, "Marketing")
				XCTAssertEqual(r.topics[2].topic.updatedAt.description, "2017-11-13 17:42:09 +0000")
				XCTAssertEqual(r.topics[2].topic.id, 3538)
				XCTAssertEqual(r.topics[2].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[2].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[2].unread!.count, 0)
				XCTAssertEqual(r.topics[2].unread!.topicId, 3538)
				XCTAssertEqual(r.topics[2].unread!.postId, 160926)
				XCTAssertEqual(r.topics[2].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[2].favorite, false)
                XCTAssertNil(r.topics[3].topic.description)
				XCTAssertEqual(r.topics[3].topic.lastPostedAt!.description, "2017-11-13 18:57:22 +0000")
				XCTAssertEqual(r.topics[3].topic.name, "Website Feedback")
				XCTAssertEqual(r.topics[3].topic.suggestion, "Website Feedback")
				XCTAssertEqual(r.topics[3].topic.updatedAt.description, "2017-11-13 18:13:55 +0000")
				XCTAssertEqual(r.topics[3].topic.id, 4828)
				XCTAssertEqual(r.topics[3].topic.createdAt.description, "2017-11-13 18:07:45 +0000")
				XCTAssertEqual(r.topics[3].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[3].unread!.count, 0)
				XCTAssertEqual(r.topics[3].unread!.topicId, 4828)
				XCTAssertEqual(r.topics[3].unread!.postId, 160924)
				XCTAssertEqual(r.topics[3].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[3].favorite, true)
                XCTAssertNil(r.topics[4].topic.description)
				XCTAssertEqual(r.topics[4].topic.lastPostedAt!.description, "2017-11-13 18:39:00 +0000")
				XCTAssertEqual(r.topics[4].topic.name, "Design")
				XCTAssertEqual(r.topics[4].topic.suggestion, "Design")
				XCTAssertEqual(r.topics[4].topic.updatedAt.description, "2018-02-19 06:58:35 +0000")
				XCTAssertEqual(r.topics[4].topic.id, 4483)
				XCTAssertEqual(r.topics[4].topic.createdAt.description, "2017-03-21 20:04:45 +0000")
				XCTAssertEqual(r.topics[4].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[4].unread!.count, 0)
				XCTAssertEqual(r.topics[4].unread!.topicId, 4483)
				XCTAssertEqual(r.topics[4].unread!.postId, 160915)
				XCTAssertEqual(r.topics[4].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[4].favorite, true)
                XCTAssertNil(r.topics[5].topic.description)
				XCTAssertEqual(r.topics[5].topic.lastPostedAt!.description, "2017-09-19 06:32:29 +0000")
				XCTAssertEqual(r.topics[5].topic.name, "All Company")
				XCTAssertEqual(r.topics[5].topic.suggestion, "All Company")
				XCTAssertEqual(r.topics[5].topic.updatedAt.description, "2017-03-21 21:14:21 +0000")
				XCTAssertEqual(r.topics[5].topic.id, 4457)
				XCTAssertEqual(r.topics[5].topic.createdAt.description, "2017-03-03 07:37:59 +0000")
				XCTAssertEqual(r.topics[5].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[5].unread!.count, 0)
				XCTAssertEqual(r.topics[5].unread!.topicId, 4457)
				XCTAssertEqual(r.topics[5].unread!.postId, 160020)
				XCTAssertEqual(r.topics[5].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[5].favorite, true)
                XCTAssertNil(r.topics[6].topic.description)
				XCTAssertEqual(r.topics[6].topic.lastPostedAt!.description, "2017-03-07 16:32:51 +0000")
				XCTAssertEqual(r.topics[6].topic.name, "Strategy")
				XCTAssertEqual(r.topics[6].topic.suggestion, "Strategy")
				XCTAssertEqual(r.topics[6].topic.updatedAt.description, "2017-11-13 17:41:49 +0000")
				XCTAssertEqual(r.topics[6].topic.id, 3540)
				XCTAssertEqual(r.topics[6].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[6].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[6].unread!.count, 0)
				XCTAssertEqual(r.topics[6].unread!.topicId, 3540)
				XCTAssertEqual(r.topics[6].unread!.postId, 157928)
				XCTAssertEqual(r.topics[6].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[6].favorite, false)
                XCTAssertNil(r.topics[7].topic.description)
				XCTAssertEqual(r.topics[7].topic.lastPostedAt!.description, "2017-03-03 10:58:30 +0000")
				XCTAssertEqual(r.topics[7].topic.name, "IT")
				XCTAssertEqual(r.topics[7].topic.suggestion, "IT")
				XCTAssertEqual(r.topics[7].topic.updatedAt.description, "2017-11-13 17:39:01 +0000")
				XCTAssertEqual(r.topics[7].topic.id, 3536)
				XCTAssertEqual(r.topics[7].topic.createdAt.description, "2016-01-28 02:29:23 +0000")
				XCTAssertEqual(r.topics[7].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[7].unread!.count, 0)
				XCTAssertEqual(r.topics[7].unread!.topicId, 3536)
				XCTAssertEqual(r.topics[7].unread!.postId, 158388)
				XCTAssertEqual(r.topics[7].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[7].favorite, true)
                XCTAssertNil(r.topics[8].topic.description)
				XCTAssertEqual(r.topics[8].topic.lastPostedAt!.description, "2016-01-28 01:29:24 +0000")
				XCTAssertEqual(r.topics[8].topic.name, "UI/UX")
				XCTAssertEqual(r.topics[8].topic.suggestion, "UI/UX")
				XCTAssertEqual(r.topics[8].topic.updatedAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[8].topic.id, 3539)
				XCTAssertEqual(r.topics[8].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[8].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[8].unread!.count, 0)
				XCTAssertEqual(r.topics[8].unread!.topicId, 3539)
				XCTAssertEqual(r.topics[8].unread!.postId, 0)
				XCTAssertEqual(r.topics[8].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[8].favorite, true)
                XCTAssertNil(r.topics[9].topic.description)
				XCTAssertEqual(r.topics[9].topic.lastPostedAt!.description, "2016-01-27 23:29:24 +0000")
				XCTAssertEqual(r.topics[9].topic.name, "Dev")
				XCTAssertEqual(r.topics[9].topic.suggestion, "Dev")
				XCTAssertEqual(r.topics[9].topic.updatedAt.description, "2017-11-13 18:07:00 +0000")
				XCTAssertEqual(r.topics[9].topic.id, 3541)
				XCTAssertEqual(r.topics[9].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[9].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[9].unread!.count, 0)
				XCTAssertEqual(r.topics[9].unread!.topicId, 3541)
				XCTAssertEqual(r.topics[9].unread!.postId, 0)
				XCTAssertEqual(r.topics[9].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[9].favorite, false)
                XCTAssertNil(r.topics[10].topic.description)
				XCTAssertEqual(r.topics[10].topic.lastPostedAt!.description, "2016-01-27 22:29:24 +0000")
				XCTAssertEqual(r.topics[10].topic.name, "Beer Brewing Club")
				XCTAssertEqual(r.topics[10].topic.suggestion, "Beer Brewing Club")
				XCTAssertEqual(r.topics[10].topic.updatedAt.description, "2017-03-21 21:13:44 +0000")
				XCTAssertEqual(r.topics[10].topic.id, 3542)
				XCTAssertEqual(r.topics[10].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[10].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[10].unread!.count, 0)
				XCTAssertEqual(r.topics[10].unread!.topicId, 3542)
				XCTAssertEqual(r.topics[10].unread!.postId, 0)
				XCTAssertEqual(r.topics[10].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[10].favorite, true)
                XCTAssertNil(r.topics[11].topic.description)
				XCTAssertEqual(r.topics[11].topic.lastPostedAt!.description, "2016-01-27 21:29:24 +0000")
				XCTAssertEqual(r.topics[11].topic.name, "HR")
				XCTAssertEqual(r.topics[11].topic.suggestion, "HR")
				XCTAssertEqual(r.topics[11].topic.updatedAt.description, "2017-11-13 17:43:00 +0000")
				XCTAssertEqual(r.topics[11].topic.id, 3543)
				XCTAssertEqual(r.topics[11].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[11].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[11].unread!.count, 0)
				XCTAssertEqual(r.topics[11].unread!.topicId, 3543)
				XCTAssertEqual(r.topics[11].unread!.postId, 0)
				XCTAssertEqual(r.topics[11].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[11].favorite, false)
                XCTAssertNil(r.topics[12].topic.description)
				XCTAssertEqual(r.topics[12].topic.lastPostedAt!.description, "2016-01-27 20:29:24 +0000")
				XCTAssertEqual(r.topics[12].topic.name, "Industry News")
				XCTAssertEqual(r.topics[12].topic.suggestion, "Industry News")
				XCTAssertEqual(r.topics[12].topic.updatedAt.description, "2017-11-13 17:43:28 +0000")
				XCTAssertEqual(r.topics[12].topic.id, 3544)
				XCTAssertEqual(r.topics[12].topic.createdAt.description, "2016-01-28 02:29:24 +0000")
				XCTAssertEqual(r.topics[12].topic.isDirectMessage, false)
				XCTAssertEqual(r.topics[12].unread!.count, 0)
				XCTAssertEqual(r.topics[12].unread!.topicId, 3544)
				XCTAssertEqual(r.topics[12].unread!.postId, 0)
				XCTAssertEqual(r.topics[12].unread!.isOverCountLimit, false)
				XCTAssertEqual(r.topics[12].favorite, false)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetDmTopics() {
		createStub("get-dm-topics")

		let expectation = self.expectation(description: "")
        TypetalkAPI.send(GetDmTopics(spaceKey: "foo")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topics.count, 5)
                XCTAssertNil(r.topics[0].topic.description)
				XCTAssertEqual(r.topics[0].topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
				XCTAssertEqual(r.topics[0].topic.name, "jessica,stefhull")
				XCTAssertEqual(r.topics[0].topic.suggestion, "jessica,stefhull")
				XCTAssertEqual(r.topics[0].topic.updatedAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[0].topic.id, 214)
				XCTAssertEqual(r.topics[0].topic.createdAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[0].topic.isDirectMessage, true)
				XCTAssertEqual(r.topics[0].unread.count, 0)
				XCTAssertEqual(r.topics[0].unread.topicId, 214)
				XCTAssertEqual(r.topics[0].unread.postId, 0)
				XCTAssertNil(r.topics[0].directMessage.status!.mobile)
				XCTAssertNil(r.topics[0].directMessage.status!.web)
				XCTAssertEqual(r.topics[0].directMessage.status!.presence, "away")
				XCTAssertEqual(r.topics[0].directMessage.account.name, "stefhull")
				XCTAssertEqual(r.topics[0].directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.topics[0].directMessage.account.isBot, false)
				XCTAssertEqual(r.topics[0].directMessage.account.suggestion, "StefHull")
				XCTAssertEqual(r.topics[0].directMessage.account.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.topics[0].directMessage.account.fullName, "StefHull")
				XCTAssertEqual(r.topics[0].directMessage.account.id, 103)
				XCTAssertEqual(r.topics[0].directMessage.account.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.topics[1].topic.description, "")
				XCTAssertEqual(r.topics[1].topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
				XCTAssertEqual(r.topics[1].topic.name, "jessica,cooper")
				XCTAssertEqual(r.topics[1].topic.suggestion, "jessica,cooper")
				XCTAssertEqual(r.topics[1].topic.updatedAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[1].topic.id, 215)
				XCTAssertEqual(r.topics[1].topic.createdAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[1].topic.isDirectMessage, true)
				XCTAssertEqual(r.topics[1].unread.count, 0)
				XCTAssertEqual(r.topics[1].unread.topicId, 215)
				XCTAssertEqual(r.topics[1].unread.postId, 0)
				XCTAssertNil(r.topics[1].directMessage.status!.mobile)
				XCTAssertNil(r.topics[1].directMessage.status!.web)
				XCTAssertEqual(r.topics[1].directMessage.status!.presence, "away")
				XCTAssertEqual(r.topics[1].directMessage.account.name, "cooper")
				XCTAssertEqual(r.topics[1].directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.topics[1].directMessage.account.isBot, false)
				XCTAssertEqual(r.topics[1].directMessage.account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.topics[1].directMessage.account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.topics[1].directMessage.account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.topics[1].directMessage.account.id, 104)
				XCTAssertEqual(r.topics[1].directMessage.account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.topics[2].topic.description, "")
				XCTAssertEqual(r.topics[2].topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
				XCTAssertEqual(r.topics[2].topic.name, "jessica,moss")
				XCTAssertEqual(r.topics[2].topic.suggestion, "jessica,moss")
				XCTAssertEqual(r.topics[2].topic.updatedAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[2].topic.id, 213)
				XCTAssertEqual(r.topics[2].topic.createdAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[2].topic.isDirectMessage, true)
				XCTAssertEqual(r.topics[2].unread.count, 0)
				XCTAssertEqual(r.topics[2].unread.topicId, 213)
				XCTAssertEqual(r.topics[2].unread.postId, 0)
				XCTAssertNil(r.topics[2].directMessage.status!.mobile)
				XCTAssertNil(r.topics[2].directMessage.status!.web)
				XCTAssertEqual(r.topics[2].directMessage.status!.presence, "away")
				XCTAssertEqual(r.topics[2].directMessage.account.name, "moss")
				XCTAssertEqual(r.topics[2].directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.topics[2].directMessage.account.isBot, false)
				XCTAssertEqual(r.topics[2].directMessage.account.suggestion, "Moss")
				XCTAssertEqual(r.topics[2].directMessage.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.topics[2].directMessage.account.fullName, "Moss")
				XCTAssertEqual(r.topics[2].directMessage.account.id, 102)
				XCTAssertEqual(r.topics[2].directMessage.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.topics[3].topic.description, "")
				XCTAssertEqual(r.topics[3].topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
				XCTAssertEqual(r.topics[3].topic.name, "jessica,brad")
				XCTAssertEqual(r.topics[3].topic.suggestion, "jessica,brad")
				XCTAssertEqual(r.topics[3].topic.updatedAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[3].topic.id, 216)
				XCTAssertEqual(r.topics[3].topic.createdAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[3].topic.isDirectMessage, true)
				XCTAssertEqual(r.topics[3].unread.count, 0)
				XCTAssertEqual(r.topics[3].unread.topicId, 216)
				XCTAssertEqual(r.topics[3].unread.postId, 0)
				XCTAssertNil(r.topics[3].directMessage.status!.mobile)
				XCTAssertNil(r.topics[3].directMessage.status!.web)
				XCTAssertEqual(r.topics[3].directMessage.status!.presence, "away")
				XCTAssertEqual(r.topics[3].directMessage.account.name, "brad")
				XCTAssertEqual(r.topics[3].directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.topics[3].directMessage.account.isBot, false)
				XCTAssertEqual(r.topics[3].directMessage.account.suggestion, "BradMarshalls")
				XCTAssertEqual(r.topics[3].directMessage.account.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.topics[3].directMessage.account.fullName, "BradMarshalls")
				XCTAssertEqual(r.topics[3].directMessage.account.id, 105)
				XCTAssertEqual(r.topics[3].directMessage.account.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.topics[4].topic.description, "")
				XCTAssertEqual(r.topics[4].topic.lastPostedAt!.description, "2014-06-12 04:32:29 +0000")
				XCTAssertEqual(r.topics[4].topic.name, "jessica,chelseab")
				XCTAssertEqual(r.topics[4].topic.suggestion, "jessica,chelseab")
				XCTAssertEqual(r.topics[4].topic.updatedAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[4].topic.id, 217)
				XCTAssertEqual(r.topics[4].topic.createdAt.description, "2014-06-12 03:32:29 +0000")
				XCTAssertEqual(r.topics[4].topic.isDirectMessage, true)
				XCTAssertEqual(r.topics[4].unread.count, 0)
				XCTAssertEqual(r.topics[4].unread.topicId, 217)
				XCTAssertEqual(r.topics[4].unread.postId, 0)
				XCTAssertNil(r.topics[4].directMessage.status!.mobile)
				XCTAssertNil(r.topics[4].directMessage.status!.web)
				XCTAssertEqual(r.topics[4].directMessage.status!.presence, "away")
				XCTAssertEqual(r.topics[4].directMessage.account.name, "chelseab")
				XCTAssertEqual(r.topics[4].directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.topics[4].directMessage.account.isBot, false)
				XCTAssertEqual(r.topics[4].directMessage.account.suggestion, "ChelseaB")
				XCTAssertEqual(r.topics[4].directMessage.account.updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topics[4].directMessage.account.fullName, "ChelseaB")
				XCTAssertEqual(r.topics[4].directMessage.account.id, 106)
				XCTAssertEqual(r.topics[4].directMessage.account.createdAt.description, "2014-06-30 02:32:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetMessages() {
		createStub("get-messages")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetMessages(topicId: 0)) { result in
			switch result {
			case .success(let r):
                XCTAssertEqual(r.hasNext, false)
                XCTAssertEqual(r.exceedsAttachmentLimit, false)
                XCTAssertEqual(r.bookmark.postId, 167419)
                XCTAssertEqual(r.bookmark.updatedAt.description, "2018-10-01 01:26:26 +0000")
                XCTAssertEqual(r.posts.count, 5)
                XCTAssertEqual(r.posts[0].topicId, 4829)
                XCTAssertEqual(r.posts[0].account.name, "Moss")
                XCTAssertEqual(r.posts[0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2499/profile_image.png?t=1453891379196")
                XCTAssertEqual(r.posts[0].account.isBot, false)
                XCTAssertEqual(r.posts[0].account.suggestion, "Moss")
                XCTAssertEqual(r.posts[0].account.updatedAt.description, "2018-08-18 01:42:19 +0000")
                XCTAssertEqual(r.posts[0].account.fullName, "Moss")
                XCTAssertEqual(r.posts[0].account.id, 2499)
                XCTAssertEqual(r.posts[0].account.createdAt.description, "2016-01-27 09:55:23 +0000")
                XCTAssertEqual(r.posts[0].attachments!.count, 0)
                XCTAssertEqual(r.posts[0].links!.count, 1)
                XCTAssertEqual(r.posts[0].links![0].contentType, "text/html")
                XCTAssertEqual(r.posts[0].links![0].description, "Discover & share this Justin GIF with everyone you know. GIPHY is how you search, share, discover, and create GIFs.")
                XCTAssertEqual(r.posts[0].links![0].title, "Its Friday GIF by Justin - Find & Share on GIPHY")
                XCTAssertEqual(r.posts[0].links![0].url.absoluteString, "https://media.giphy.com/media/3oEjHKjVoNVsCeMoDe/giphy.gif")
                XCTAssertEqual(r.posts[0].links![0].imageUrl!.absoluteString, "https://media.giphy.com/media/3oEjHKjVoNVsCeMoDe/giphy.gif")
                XCTAssertEqual(r.posts[0].links![0].updatedAt.description, "2018-08-18 02:32:28 +0000")
                /*
                XCTAssertEqual(r.posts[0].links![0].embed!.providerUrl.absoluteString, "https://giphy.com/")
                XCTAssertEqual(r.posts[0].links![0].embed!.title, "Its Friday GIF by Justin - Find & Share on GIPHY")
                XCTAssertEqual(r.posts[0].links![0].embed!.url.absoluteString, "https://media.giphy.com/media/3oEjHKjVoNVsCeMoDe/giphy.gif")
                XCTAssertEqual(r.posts[0].links![0].embed!.authorName, "Justin")
                XCTAssertEqual(r.posts[0].links![0].embed!.height, 371)
                XCTAssertEqual(r.posts[0].links![0].embed!.width, 480)
                XCTAssertEqual(r.posts[0].links![0].embed!.authorUrl.absoluteString, "https://giphy.com/justin")
                XCTAssertEqual(r.posts[0].links![0].embed!.providerName, "GIPHY")
                XCTAssertEqual(r.posts[0].links![0].embed!.type.rawValue, "photo")
                */
                XCTAssertEqual(r.posts[0].links![0].id, 3548)
                XCTAssertEqual(r.posts[0].links![0].createdAt.description, "2017-11-13 22:24:01 +0000")
                XCTAssertNil(r.posts[0].replyTo)
                XCTAssertNil(r.posts[0].mention)
                XCTAssertEqual(r.posts[0].likes!.count, 0)
                XCTAssertEqual(r.posts[0].updatedAt.description, "2017-11-13 22:29:03 +0000")
                XCTAssertEqual(r.posts[0].talks!.count, 0)
                XCTAssertEqual(r.posts[0].message, "In case you hadn't realized https://media.giphy.com/media/3oEjHKjVoNVsCeMoDe/giphy.gif")
                XCTAssertEqual(r.posts[0].id, 160928)
                XCTAssertEqual(r.posts[0].createdAt.description, "2017-11-13 22:29:03 +0000")
                XCTAssertEqual(r.posts[1].topicId, 4829)
                XCTAssertEqual(r.posts[1].account.name, "Jessica")
                XCTAssertEqual(r.posts[1].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.posts[1].account.isBot, false)
                XCTAssertEqual(r.posts[1].account.suggestion, "Jessica")
                XCTAssertEqual(r.posts[1].account.updatedAt.description, "2018-11-06 03:33:00 +0000")
                XCTAssertEqual(r.posts[1].account.fullName, "Jessica")
                XCTAssertEqual(r.posts[1].account.id, 2500)
                XCTAssertEqual(r.posts[1].account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.posts[1].attachments!.count, 0)
                XCTAssertEqual(r.posts[1].links!.count, 1)
                XCTAssertEqual(r.posts[1].links![0].contentType, "text/html")
                XCTAssertEqual(r.posts[1].links![0].description, "The official GIPHY channel for #TheVoice, Mondays and Tuesdays at 8/7c on NBC!")
                XCTAssertEqual(r.posts[1].links![0].title, "Christina Aguilera Television GIF by The Voice - Find & Share on GIPHY")
                XCTAssertEqual(r.posts[1].links![0].url.absoluteString, "https://media.giphy.com/media/111WSGoF53XKq4/giphy.gif")
                XCTAssertEqual(r.posts[1].links![0].imageUrl!.absoluteString, "https://media.giphy.com/media/111WSGoF53XKq4/giphy.gif")
                XCTAssertEqual(r.posts[1].links![0].updatedAt.description, "2018-08-18 02:46:05 +0000")
                /*
                XCTAssertEqual(r.posts[1].links![0].embed!.providerUrl.absoluteString, "https://giphy.com/")
                XCTAssertEqual(r.posts[1].links![0].embed!.title, "Christina Aguilera Television GIF by The Voice - Find & Share on GIPHY")
                XCTAssertEqual(r.posts[1].links![0].embed!.url.absoluteString, "https://media.giphy.com/media/111WSGoF53XKq4/giphy.gif")
                XCTAssertEqual(r.posts[1].links![0].embed!.authorName, "The Voice")
                XCTAssertEqual(r.posts[1].links![0].embed!.height, 281)
                XCTAssertEqual(r.posts[1].links![0].embed!.width, 500)
                XCTAssertEqual(r.posts[1].links![0].embed!.authorUrl.absoluteString, "https://giphy.com/thevoice")
                XCTAssertEqual(r.posts[1].links![0].embed!.providerName, "GIPHY")
                XCTAssertEqual(r.posts[1].links![0].embed!.type.rawValue, "photo")
                */
                XCTAssertEqual(r.posts[1].links![0].id, 3549)
                XCTAssertEqual(r.posts[1].links![0].createdAt.description, "2017-11-13 22:29:52 +0000")
                XCTAssertEqual(r.posts[1].replyTo, 160928)
                XCTAssertNil(r.posts[1].mention)
                XCTAssertEqual(r.posts[1].likes!.count, 2)
                XCTAssertEqual(r.posts[1].likes![0].comment, "")
                XCTAssertEqual(r.posts[1].likes![0].topicId, 4829)
                XCTAssertEqual(r.posts[1].likes![0].account!.name, "Stefanie")
                XCTAssertEqual(r.posts[1].likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.posts[1].likes![0].account!.isBot, false)
                XCTAssertEqual(r.posts[1].likes![0].account!.suggestion, "Stefanie")
                XCTAssertEqual(r.posts[1].likes![0].account!.updatedAt.description, "2018-08-18 01:42:19 +0000")
                XCTAssertEqual(r.posts[1].likes![0].account!.fullName, "Stefanie")
                XCTAssertEqual(r.posts[1].likes![0].account!.id, 2498)
                XCTAssertEqual(r.posts[1].likes![0].account!.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertEqual(r.posts[1].likes![0].postId, 160929)
                XCTAssertEqual(r.posts[1].likes![0].id, 19551)
                XCTAssertEqual(r.posts[1].likes![0].createdAt!.description, "2017-12-06 06:22:11 +0000")
                XCTAssertEqual(r.posts[1].likes![1].comment, "")
                XCTAssertEqual(r.posts[1].likes![1].topicId, 4829)
                XCTAssertEqual(r.posts[1].likes![1].account!.name, "Moss")
                XCTAssertEqual(r.posts[1].likes![1].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/2499/profile_image.png?t=1453891379196")
                XCTAssertEqual(r.posts[1].likes![1].account!.isBot, false)
                XCTAssertEqual(r.posts[1].likes![1].account!.suggestion, "Moss")
                XCTAssertEqual(r.posts[1].likes![1].account!.updatedAt.description, "2018-08-18 01:42:19 +0000")
                XCTAssertEqual(r.posts[1].likes![1].account!.fullName, "Moss")
                XCTAssertEqual(r.posts[1].likes![1].account!.id, 2499)
                XCTAssertEqual(r.posts[1].likes![1].account!.createdAt.description, "2016-01-27 09:55:23 +0000")
                XCTAssertEqual(r.posts[1].likes![1].postId, 160929)
                XCTAssertEqual(r.posts[1].likes![1].id, 19747)
                XCTAssertEqual(r.posts[1].likes![1].createdAt!.description, "2018-02-16 08:59:30 +0000")
                XCTAssertEqual(r.posts[1].updatedAt.description, "2017-11-13 22:29:51 +0000")
                XCTAssertEqual(r.posts[1].talks!.count, 0)
                XCTAssertEqual(r.posts[1].message, "https://media.giphy.com/media/111WSGoF53XKq4/giphy.gif")
                XCTAssertEqual(r.posts[1].id, 160929)
                XCTAssertEqual(r.posts[1].createdAt.description, "2017-11-13 22:29:51 +0000")
                XCTAssertEqual(r.posts[2].topicId, 4829)
                XCTAssertEqual(r.posts[2].account.name, "Stefanie")
                XCTAssertEqual(r.posts[2].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.posts[2].account.isBot, false)
                XCTAssertEqual(r.posts[2].account.suggestion, "Stefanie")
                XCTAssertEqual(r.posts[2].account.updatedAt.description, "2018-08-18 01:42:19 +0000")
                XCTAssertEqual(r.posts[2].account.fullName, "Stefanie")
                XCTAssertEqual(r.posts[2].account.id, 2498)
                XCTAssertEqual(r.posts[2].account.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertEqual(r.posts[2].attachments!.count, 0)
                XCTAssertEqual(r.posts[2].links!.count, 0)
                XCTAssertNil(r.posts[2].replyTo)
                XCTAssertEqual(r.posts[2].mention!.id, 16415)
                XCTAssertEqual(r.posts[2].mention!.readAt!.description, "2017-11-14 07:36:56 +0000")
                XCTAssertEqual(r.posts[2].likes!.count, 0)
                XCTAssertEqual(r.posts[2].updatedAt.description, "2017-11-13 22:32:27 +0000")
                XCTAssertEqual(r.posts[2].talks!.count, 1)
                XCTAssertEqual(r.posts[2].talks![0].topicId, 4829)
                XCTAssertEqual(r.posts[2].talks![0].name, "FOOD")
                XCTAssertNil(r.posts[2].talks![0].backlog)
                XCTAssertEqual(r.posts[2].talks![0].suggestion, "FOOD")
                XCTAssertEqual(r.posts[2].talks![0].updatedAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.posts[2].talks![0].id, 2172)
                XCTAssertEqual(r.posts[2].talks![0].createdAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.posts[2].message, "@all I made a few too many batches of chocolate chip cookies last night (a travesty, I know!), so I brought some in to share. They're in the kitchen! :cookie: :cookie: :cookie: :cookie: :cookie: ")
                XCTAssertEqual(r.posts[2].id, 160930)
                XCTAssertEqual(r.posts[2].createdAt.description, "2017-11-13 22:32:27 +0000")
                XCTAssertEqual(r.posts[3].topicId, 4829)
                XCTAssertEqual(r.posts[3].account.name, "Will")
                XCTAssertEqual(r.posts[3].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2497/profile_image.png?t=1510596200433")
                XCTAssertEqual(r.posts[3].account.isBot, false)
                XCTAssertEqual(r.posts[3].account.suggestion, "Will")
                XCTAssertEqual(r.posts[3].account.updatedAt.description, "2018-09-28 20:22:05 +0000")
                XCTAssertEqual(r.posts[3].account.fullName, "Will")
                XCTAssertEqual(r.posts[3].account.id, 2497)
                XCTAssertEqual(r.posts[3].account.createdAt.description, "2016-01-27 09:54:48 +0000")
                XCTAssertEqual(r.posts[3].attachments!.count, 0)
                XCTAssertEqual(r.posts[3].links!.count, 1)
                XCTAssertEqual(r.posts[3].links![0].contentType, "text/html")
                XCTAssertEqual(r.posts[3].links![0].description, "Discover & share this Cookie Monster GIF with everyone you know. GIPHY is how you search, share, discover, and create GIFs.")
                XCTAssertEqual(r.posts[3].links![0].title, "Cookie Monster GIF - Find & Share on GIPHY")
                XCTAssertEqual(r.posts[3].links![0].url.absoluteString, "https://media.giphy.com/media/bAlYQOugzX9sY/giphy.gif")
                XCTAssertEqual(r.posts[3].links![0].imageUrl!.absoluteString, "https://media.giphy.com/media/bAlYQOugzX9sY/200.gif")
                XCTAssertEqual(r.posts[3].links![0].updatedAt.description, "2018-08-18 02:49:34 +0000")
                /*
                XCTAssertEqual(r.posts[3].links![0].embed!.providerUrl.absoluteString, "https://giphy.com/")
                XCTAssertEqual(r.posts[3].links![0].embed!.title, "Cookie Monster GIF - Find & Share on GIPHY")
                XCTAssertEqual(r.posts[3].links![0].embed!.url.absoluteString, "https://media.giphy.com/media/bAlYQOugzX9sY/giphy.gif")
                XCTAssertEqual(r.posts[3].links![0].embed!.authorName, "GIPHY")
                XCTAssertEqual(r.posts[3].links![0].embed!.height, 180)
                XCTAssertEqual(r.posts[3].links![0].embed!.width, 320)
                XCTAssertEqual(r.posts[3].links![0].embed!.authorUrl.absoluteString, "https://giphy.com/")
                XCTAssertEqual(r.posts[3].links![0].embed!.providerName, "GIPHY")
                XCTAssertEqual(r.posts[3].links![0].embed!.type.rawValue, "photo")
                */
                XCTAssertEqual(r.posts[3].links![0].id, 3550)
                XCTAssertEqual(r.posts[3].links![0].createdAt.description, "2017-11-13 22:35:19 +0000")
                XCTAssertEqual(r.posts[3].replyTo, 160930)
                XCTAssertNil(r.posts[3].mention)
                XCTAssertEqual(r.posts[3].likes!.count, 0)
                XCTAssertEqual(r.posts[3].updatedAt.description, "2017-11-13 22:35:18 +0000")
                XCTAssertEqual(r.posts[3].talks!.count, 1)
                XCTAssertEqual(r.posts[3].talks![0].topicId, 4829)
                XCTAssertEqual(r.posts[3].talks![0].name, "FOOD")
                XCTAssertNil(r.posts[3].talks![0].backlog)
                XCTAssertEqual(r.posts[3].talks![0].suggestion, "FOOD")
                XCTAssertEqual(r.posts[3].talks![0].updatedAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.posts[3].talks![0].id, 2172)
                XCTAssertEqual(r.posts[3].talks![0].createdAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.posts[3].message, "@Stefanie :dizzy: thank you for making my dreams come true https://media.giphy.com/media/bAlYQOugzX9sY/giphy.gif")
                XCTAssertEqual(r.posts[3].id, 160931)
                XCTAssertEqual(r.posts[3].createdAt.description, "2017-11-13 22:35:18 +0000")
                XCTAssertEqual(r.posts[4].topicId, 4483)
                XCTAssertEqual(r.posts[4].account.name, "Jessica")
                XCTAssertEqual(r.posts[4].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.posts[4].account.isBot, false)
                XCTAssertEqual(r.posts[4].account.suggestion, "Jessica")
                XCTAssertEqual(r.posts[4].account.updatedAt.description, "2018-11-06 03:33:00 +0000")
                XCTAssertEqual(r.posts[4].account.fullName, "Jessica")
                XCTAssertEqual(r.posts[4].account.id, 2500)
                XCTAssertEqual(r.posts[4].account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.posts[4].attachments!.count, 1)
                XCTAssertEqual(r.posts[4].attachments![0].webUrl.absoluteString, "https://typetalk.com/topics/4483/posts/164018/attachments/1/wallpaper.jpg")
                XCTAssertEqual(r.posts[4].attachments![0].attachment.fileKey, "c5082a1da3e99ecc97b8e5119781ac2b82e18dfa")
                XCTAssertEqual(r.posts[4].attachments![0].attachment.contentType, "image/jpeg")
                XCTAssertEqual(r.posts[4].attachments![0].attachment.fileSize, 14356)
                XCTAssertEqual(r.posts[4].attachments![0].attachment.fileName, "wallpaper.jpg")
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails!.count, 3)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![0].width, 198)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![0].type.rawValue, "small")
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![0].fileSize, 14356)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![0].height, 125)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![1].width, 198)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![1].type.rawValue, "medium")
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![1].fileSize, 14356)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![1].height, 125)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![2].width, 198)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![2].type.rawValue, "large")
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![2].fileSize, 14356)
                XCTAssertEqual(r.posts[4].attachments![0].thumbnails![2].height, 125)
                XCTAssertEqual(r.posts[4].attachments![0].apiUrl.absoluteString, "https://typetalk.com/api/v1/topics/4483/posts/164018/attachments/1/wallpaper.jpg")
                XCTAssertEqual(r.posts[4].links!.count, 0)
                XCTAssertNil(r.posts[4].replyTo)
                XCTAssertNil(r.posts[4].mention)
                XCTAssertEqual(r.posts[4].likes!.count, 0)
                XCTAssertEqual(r.posts[4].updatedAt.description, "2018-04-18 06:56:37 +0000")
                XCTAssertEqual(r.posts[4].talks!.count, 0)
                XCTAssertEqual(r.posts[4].message, "How about this wallpaper?")
                XCTAssertEqual(r.posts[4].id, 164018)
                XCTAssertEqual(r.posts[4].createdAt.description, "2018-04-18 06:56:37 +0000")
                XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
                XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
                XCTAssertEqual(r.mySpace!.invitableRoles!.count, 3)
                XCTAssertEqual(r.mySpace!.invitableRoles![0], "ADMIN")
                XCTAssertEqual(r.mySpace!.invitableRoles![1], "USER")
                XCTAssertEqual(r.mySpace!.invitableRoles![2], "GUEST")
                XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 4)
                XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
                XCTAssertEqual(r.mySpace!.myPlan.numberOfAllowedAddresses, 0)
                XCTAssertNil(r.mySpace!.myPlan.trial)
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfAllowedAddresses, 10)
                XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Standard 10 Users")
                XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.standard10")
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 10737418240)
                XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2018-09-25 09:43:56 +0000")
                XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 14356)
                XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-27 09:37:27 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxx/photo/large")
                XCTAssertEqual(r.mySpace!.space.enabled, true)
                XCTAssertEqual(r.mySpace!.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.mySpace!.space.key, "xxxxx")
                XCTAssertEqual(r.favorite, true)
                XCTAssertEqual(r.topic.name, "Coffee shop")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2018-09-28 20:23:57 +0000")
                XCTAssertEqual(r.topic.description, "A topic for getting off-topic")
                XCTAssertEqual(r.topic.suggestion, "Coffee shop")
                XCTAssertEqual(r.topic.updatedAt.description, "2017-12-21 02:41:00 +0000")
                XCTAssertEqual(r.topic.id, 4829)
                XCTAssertEqual(r.topic.createdAt.description, "2017-11-13 22:27:21 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, false)
                XCTAssertNil(r.onboarding)
                XCTAssertNil(r.team)
                XCTAssertNil(r.myTopic)
                XCTAssertEqual(r.isPostEnabled, true)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testPostMessage() {
		createStub("post-message")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(PostMessage(topicId: 0, message: "foo")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxx/photo/large")
                XCTAssertEqual(r.space.enabled, true)
                XCTAssertEqual(r.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.space.key, "xxxxx")
                XCTAssertEqual(r.topic.name, "Coffee shop")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2018-11-06 07:56:42 +0000")
                XCTAssertEqual(r.topic.description, "A topic for getting off-topic")
                XCTAssertEqual(r.topic.suggestion, "Coffee shop")
                XCTAssertEqual(r.topic.updatedAt.description, "2017-12-21 02:41:00 +0000")
                XCTAssertEqual(r.topic.id, 4829)
                XCTAssertEqual(r.topic.createdAt.description, "2017-11-13 22:27:21 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, false)
                XCTAssertNil(r.directMessage)
                XCTAssertEqual(r.exceedsAttachmentLimit, false)
                XCTAssertEqual(r.mentions.count, 0)
                XCTAssertEqual(r.post.topicId, 4829)
                XCTAssertEqual(r.post.account.name, "Jessica")
                XCTAssertEqual(r.post.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.post.account.isBot, false)
                XCTAssertEqual(r.post.account.suggestion, "Jessica")
                XCTAssertEqual(r.post.account.updatedAt.description, "2018-11-06 07:54:44 +0000")
                XCTAssertEqual(r.post.account.fullName, "Jessica")
                XCTAssertEqual(r.post.account.id, 2500)
                XCTAssertEqual(r.post.account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.post.attachments!.count, 0)
                XCTAssertEqual(r.post.links!.count, 0)
                XCTAssertNil(r.post.replyTo)
                XCTAssertNil(r.post.mention)
                XCTAssertEqual(r.post.likes!.count, 0)
                XCTAssertEqual(r.post.updatedAt.description, "2018-11-06 07:56:42 +0000")
                XCTAssertEqual(r.post.talks!.count, 0)
                XCTAssertEqual(r.post.message, "Hi")
                XCTAssertEqual(r.post.id, 167964)
                XCTAssertEqual(r.post.createdAt.description, "2018-11-06 07:56:42 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testUploadAttachment() {
		createStub("upload-attachment")

		let expectation = self.expectation(description: "")
	 	TypetalkAPI.send(UploadAttachment(topicId: 0, file: Data())) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.fileKey, "035c2446499f888be1f32953a5d3c8d9d8b4c2e8")
				XCTAssertEqual(r.contentType, "image/jpeg")
				XCTAssertEqual(r.fileSize, 472263)
				XCTAssertEqual(r.fileName, "sample.jpg")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetTopicMembers() {
		createStub("get-topic-members")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetTopicMembers(topicId: 0)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.pendings!.count, 0)
				XCTAssertEqual(r.accounts!.count, 6)
				XCTAssertEqual(r.accounts![0].account.name, "ahorowitz")
				XCTAssertEqual(r.accounts![0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.accounts![0].account.isBot, false)
				XCTAssertEqual(r.accounts![0].account.suggestion, "AHorowitz")
				XCTAssertEqual(r.accounts![0].account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts![0].account.fullName, "AHorowitz")
				XCTAssertEqual(r.accounts![0].account.id, 101)
				XCTAssertEqual(r.accounts![0].account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.accounts![0].online, false)
				XCTAssertEqual(r.accounts![1].account.name, "brad")
				XCTAssertEqual(r.accounts![1].account.imageUrl.absoluteString, "https://typetalk.com/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts![1].account.isBot, false)
				XCTAssertEqual(r.accounts![1].account.suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts![1].account.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts![1].account.fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts![1].account.id, 105)
				XCTAssertEqual(r.accounts![1].account.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts![1].online, false)
				XCTAssertEqual(r.accounts![2].account.name, "cooper")
				XCTAssertEqual(r.accounts![2].account.imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts![2].account.isBot, false)
				XCTAssertEqual(r.accounts![2].account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts![2].account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts![2].account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts![2].account.id, 104)
				XCTAssertEqual(r.accounts![2].account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts![2].online, false)
				XCTAssertEqual(r.accounts![3].account.name, "jessica")
				XCTAssertEqual(r.accounts![3].account.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.accounts![3].account.isBot, false)
				XCTAssertEqual(r.accounts![3].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts![3].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts![3].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.accounts![3].account.id, 100)
				XCTAssertEqual(r.accounts![3].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.accounts![3].online, false)
				XCTAssertEqual(r.accounts![4].account.name, "moss")
				XCTAssertEqual(r.accounts![4].account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.accounts![4].account.isBot, false)
				XCTAssertEqual(r.accounts![4].account.suggestion, "Moss")
				XCTAssertEqual(r.accounts![4].account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.accounts![4].account.fullName, "Moss")
				XCTAssertEqual(r.accounts![4].account.id, 102)
				XCTAssertEqual(r.accounts![4].account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.accounts![4].online, false)
				XCTAssertEqual(r.accounts![5].account.name, "stefhull")
				XCTAssertEqual(r.accounts![5].account.imageUrl.absoluteString, "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.accounts![5].account.isBot, false)
				XCTAssertEqual(r.accounts![5].account.suggestion, "StefHull")
				XCTAssertEqual(r.accounts![5].account.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.accounts![5].account.fullName, "StefHull")
				XCTAssertEqual(r.accounts![5].account.id, 103)
				XCTAssertEqual(r.accounts![5].account.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.accounts![5].online, false)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetMessage() {
		createStub("get-message")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetMessage(topicId: 0, postId: 0)) { result in
			switch result {
			case .success(let r):
                XCTAssertEqual(r.exceedsAttachmentLimit, false)
                XCTAssertEqual(r.isPostEnabled, true)
                XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
                XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
                XCTAssertEqual(r.mySpace!.invitableRoles!.count, 3)
                XCTAssertEqual(r.mySpace!.invitableRoles![0], "ADMIN")
                XCTAssertEqual(r.mySpace!.invitableRoles![1], "USER")
                XCTAssertEqual(r.mySpace!.invitableRoles![2], "GUEST")
                XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 4)
                XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
                XCTAssertEqual(r.mySpace!.myPlan.numberOfAllowedAddresses, 0)
                XCTAssertNil(r.mySpace!.myPlan.trial)
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfAllowedAddresses, 10)
                XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Standard 10 Users")
                XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.standard10")
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 10737418240)
                XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2018-09-25 09:43:56 +0000")
                XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 14356)
                XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-27 09:37:27 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxx/photo/large")
                XCTAssertEqual(r.mySpace!.space.enabled, true)
                XCTAssertEqual(r.mySpace!.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.mySpace!.space.key, "xxxxxx")
                XCTAssertEqual(r.topic.name, "Coffee shop")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2018-11-06 07:56:42 +0000")
                XCTAssertEqual(r.topic.description, "A topic for getting off-topic")
                XCTAssertEqual(r.topic.suggestion, "Coffee shop")
                XCTAssertEqual(r.topic.updatedAt.description, "2017-12-21 02:41:00 +0000")
                XCTAssertEqual(r.topic.id, 4829)
                XCTAssertEqual(r.topic.createdAt.description, "2017-11-13 22:27:21 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, false)
                XCTAssertEqual(r.replies!.count, 1)
                XCTAssertEqual(r.replies![0].topicId, 4829)
                XCTAssertEqual(r.replies![0].account.name, "Stefanie")
                XCTAssertEqual(r.replies![0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.replies![0].account.isBot, false)
                XCTAssertEqual(r.replies![0].account.suggestion, "Stefanie")
                XCTAssertEqual(r.replies![0].account.updatedAt.description, "2018-08-18 01:42:19 +0000")
                XCTAssertEqual(r.replies![0].account.fullName, "Stefanie")
                XCTAssertEqual(r.replies![0].account.id, 2498)
                XCTAssertEqual(r.replies![0].account.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertEqual(r.replies![0].attachments!.count, 0)
                XCTAssertEqual(r.replies![0].links!.count, 0)
                XCTAssertNil(r.replies![0].replyTo)
                XCTAssertEqual(r.replies![0].mention!.id, 16415)
                XCTAssertEqual(r.replies![0].mention!.readAt!.description, "2017-11-14 07:36:56 +0000")
                XCTAssertEqual(r.replies![0].likes!.count, 0)
                XCTAssertEqual(r.replies![0].updatedAt.description, "2017-11-13 22:32:27 +0000")
                XCTAssertEqual(r.replies![0].talks!.count, 1)
                XCTAssertEqual(r.replies![0].talks![0].topicId, 4829)
                XCTAssertEqual(r.replies![0].talks![0].name, "FOOD")
                XCTAssertNil(r.replies![0].talks![0].backlog)
                XCTAssertEqual(r.replies![0].talks![0].suggestion, "FOOD")
                XCTAssertEqual(r.replies![0].talks![0].updatedAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.replies![0].talks![0].id, 2172)
                XCTAssertEqual(r.replies![0].talks![0].createdAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.replies![0].message, "@all I made a few too many batches of chocolate chip cookies last night (a travesty, I know!), so I brought some in to share. They're in the kitchen! :cookie: :cookie: :cookie: :cookie: :cookie: ")
                XCTAssertEqual(r.replies![0].id, 160930)
                XCTAssertEqual(r.replies![0].createdAt.description, "2017-11-13 22:32:27 +0000")
                XCTAssertEqual(r.post.topicId, 4829)
                XCTAssertEqual(r.post.account.name, "Will")
                XCTAssertEqual(r.post.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2497/profile_image.png?t=1510596200433")
                XCTAssertEqual(r.post.account.isBot, false)
                XCTAssertEqual(r.post.account.suggestion, "Will")
                XCTAssertEqual(r.post.account.updatedAt.description, "2018-09-28 20:22:05 +0000")
                XCTAssertEqual(r.post.account.fullName, "Will")
                XCTAssertEqual(r.post.account.id, 2497)
                XCTAssertEqual(r.post.account.createdAt.description, "2016-01-27 09:54:48 +0000")
                XCTAssertEqual(r.post.attachments!.count, 0)
                XCTAssertEqual(r.post.links!.count, 1)
                XCTAssertEqual(r.post.links![0].contentType, "text/html")
                XCTAssertEqual(r.post.links![0].description, "Discover & share this Cookie Monster GIF with everyone you know. GIPHY is how you search, share, discover, and create GIFs.")
                XCTAssertEqual(r.post.links![0].title, "Cookie Monster GIF - Find & Share on GIPHY")
                XCTAssertEqual(r.post.links![0].url.absoluteString, "https://media.giphy.com/media/bAlYQOugzX9sY/giphy.gif")
                XCTAssertEqual(r.post.links![0].imageUrl!.absoluteString, "https://media.giphy.com/media/bAlYQOugzX9sY/200.gif")
                XCTAssertEqual(r.post.links![0].updatedAt.description, "2018-08-18 02:49:34 +0000")
                /*
                // TODO: ADDME
                XCTAssertEqual(r.post.links![0].embed!.providerUrl.absoluteString, "https://giphy.com/")
                XCTAssertEqual(r.post.links![0].embed!.title, "Cookie Monster GIF - Find & Share on GIPHY")
                XCTAssertEqual(r.post.links![0].embed!.url.absoluteString, "https://media.giphy.com/media/bAlYQOugzX9sY/giphy.gif")
                XCTAssertEqual(r.post.links![0].embed!.authorName, "GIPHY")
                XCTAssertEqual(r.post.links![0].embed!.height, 180)
                XCTAssertEqual(r.post.links![0].embed!.width, 320)
                XCTAssertEqual(r.post.links![0].embed!.authorUrl.absoluteString, "https://giphy.com/")
                XCTAssertEqual(r.post.links![0].embed!.providerName, "GIPHY")
                XCTAssertEqual(r.post.links![0].embed!.type.rawValue, "photo")
                */
                XCTAssertEqual(r.post.links![0].id, 3550)
                XCTAssertEqual(r.post.links![0].createdAt.description, "2017-11-13 22:35:19 +0000")
                XCTAssertEqual(r.post.replyTo, 160930)
                XCTAssertNil(r.post.mention)
                XCTAssertEqual(r.post.likes!.count, 0)
                XCTAssertEqual(r.post.updatedAt.description, "2017-11-13 22:35:18 +0000")
                XCTAssertEqual(r.post.talks!.count, 1)
                XCTAssertEqual(r.post.talks![0].topicId, 4829)
                XCTAssertEqual(r.post.talks![0].name, "FOOD")
                XCTAssertNil(r.post.talks![0].backlog)
                XCTAssertEqual(r.post.talks![0].suggestion, "FOOD")
                XCTAssertEqual(r.post.talks![0].updatedAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.post.talks![0].id, 2172)
                XCTAssertEqual(r.post.talks![0].createdAt.description, "2017-11-13 22:38:14 +0000")
                XCTAssertEqual(r.post.message, "@Stefanie :dizzy: thank you for making my dreams come true https://media.giphy.com/media/bAlYQOugzX9sY/giphy.gif")
                XCTAssertEqual(r.post.id, 160931)
                XCTAssertEqual(r.post.createdAt.description, "2017-11-13 22:35:18 +0000")
                XCTAssertNil(r.team)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testUpdateMessage() {
		createStub("update-message")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(UpdateMessage(topicId: 0, postId: 0, message: "")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.topic.name, "Design")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2018-11-28 06:01:45 +0000")
                XCTAssertEqual(r.topic.description, "All about the world of visual design which include app ui/ux, website, news, tips and occasional banter among designers. Oh, and don't forget the weekend together.\n\nSome housekeeping:\n 1. Share your work and comment on others' work in a nice manners.\n 2. Report any issue to @Stefanie\n 3. Have fun typetalkin'! https://typetalk.com\n\nNote that this topic is open to everyone in the team!")
                XCTAssertEqual(r.topic.suggestion, "Design")
                XCTAssertEqual(r.topic.updatedAt.description, "2018-09-19 06:02:29 +0000")
                XCTAssertEqual(r.topic.id, 4483)
                XCTAssertEqual(r.topic.createdAt.description, "2017-03-21 20:04:45 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, false)
                XCTAssertEqual(r.mentions.count, 0)
                XCTAssertEqual(r.post.topicId, 4483)
                XCTAssertEqual(r.post.account.name, "Jessica")
                XCTAssertEqual(r.post.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.post.account.isBot, false)
                XCTAssertEqual(r.post.account.suggestion, "Jessica")
                XCTAssertEqual(r.post.account.updatedAt.description, "2018-11-28 05:59:16 +0000")
                XCTAssertEqual(r.post.account.fullName, "Jessica")
                XCTAssertEqual(r.post.account.id, 2500)
                XCTAssertEqual(r.post.account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.post.attachments!.count, 1)
                XCTAssertEqual(r.post.attachments![0].webUrl.absoluteString, "https://typetalk.com/topics/4483/posts/164018/attachments/1/wallpaper.jpg")
                XCTAssertEqual(r.post.attachments![0].attachment.fileKey, "c5082a1da3e99ecc97b8e5119781ac2b82e18dfa")
                XCTAssertEqual(r.post.attachments![0].attachment.contentType, "image/jpeg")
                XCTAssertEqual(r.post.attachments![0].attachment.fileSize, 14356)
                XCTAssertEqual(r.post.attachments![0].attachment.fileName, "wallpaper.jpg")
                XCTAssertEqual(r.post.attachments![0].thumbnails!.count, 3)
                XCTAssertEqual(r.post.attachments![0].thumbnails![0].width, 198)
                XCTAssertEqual(r.post.attachments![0].thumbnails![0].type.rawValue, "small")
                XCTAssertEqual(r.post.attachments![0].thumbnails![0].fileSize, 14356)
                XCTAssertEqual(r.post.attachments![0].thumbnails![0].height, 125)
                XCTAssertEqual(r.post.attachments![0].thumbnails![1].width, 198)
                XCTAssertEqual(r.post.attachments![0].thumbnails![1].type.rawValue, "medium")
                XCTAssertEqual(r.post.attachments![0].thumbnails![1].fileSize, 14356)
                XCTAssertEqual(r.post.attachments![0].thumbnails![1].height, 125)
                XCTAssertEqual(r.post.attachments![0].thumbnails![2].width, 198)
                XCTAssertEqual(r.post.attachments![0].thumbnails![2].type.rawValue, "large")
                XCTAssertEqual(r.post.attachments![0].thumbnails![2].fileSize, 14356)
                XCTAssertEqual(r.post.attachments![0].thumbnails![2].height, 125)
                XCTAssertEqual(r.post.attachments![0].apiUrl.absoluteString, "https://typetalk.com/api/v1/topics/4483/posts/164018/attachments/1/wallpaper.jpg")
                XCTAssertEqual(r.post.links!.count, 0)
                XCTAssertNil(r.post.replyTo)
                XCTAssertNil(r.post.mention)
                XCTAssertEqual(r.post.likes!.count, 0)
                XCTAssertEqual(r.post.updatedAt.description, "2018-11-28 06:01:45 +0000")
                XCTAssertEqual(r.post.talks!.count, 0)
                XCTAssertEqual(r.post.message, "How about this wallpaper?")
                XCTAssertEqual(r.post.id, 164018)
                XCTAssertEqual(r.post.createdAt.description, "2018-04-18 06:56:37 +0000")
                XCTAssertNil(r.directMessage)
                XCTAssertEqual(r.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxxxx/photo/large")
                XCTAssertEqual(r.space.enabled, true)
                XCTAssertEqual(r.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.space.key, "xxxxxxxxx")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testDeleteMessage() {
		createStub("delete-message")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(DeleteMessage(topicId: 0, postId: 0)) { result in

			switch result {
			case .success(let r):

                XCTAssertEqual(r.topicId, 208)
                XCTAssertEqual(r.account.name, "jessica")
                XCTAssertEqual(r.account.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.account.isBot, false)
                XCTAssertEqual(r.account.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.account.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.account.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.account.id, 100)
                XCTAssertEqual(r.account.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.attachments!.count, 0)
                XCTAssertEqual(r.links!.count, 0)
                XCTAssertNil(r.replyTo)
                XCTAssertNil(r.mention)
                XCTAssertEqual(r.likes!.count, 0)
                XCTAssertEqual(r.updatedAt.description, "2016-12-21 10:11:57 +0000")
                XCTAssertEqual(r.talks!.count, 0)
                XCTAssertEqual(r.message, "Let's party like it's 1999!")
                XCTAssertEqual(r.id, 333)
                XCTAssertEqual(r.createdAt.description, "2016-12-21 10:11:57 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testSearchMessages() {
		createStub("search-messages")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(SearchMessages(q: "", spaceKey: "")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.count, 32)
				XCTAssertEqual(r.posts.count, 1)
				XCTAssertEqual(r.posts[0].topicId, 53692)
				XCTAssertEqual(r.posts[0].account.name, "Michael")
				XCTAssertEqual(r.posts[0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/50117/profile_image.png?t=1504408579564")
				XCTAssertEqual(r.posts[0].account.isBot, false)
				XCTAssertEqual(r.posts[0].account.suggestion, "Michael Buck")
				XCTAssertEqual(r.posts[0].account.updatedAt.description, "2017-10-12 07:15:40 +0000")
				XCTAssertEqual(r.posts[0].account.fullName, "Michael Buck")
				XCTAssertEqual(r.posts[0].account.id, 50117)
				XCTAssertEqual(r.posts[0].account.createdAt.description, "2017-09-01 01:55:05 +0000")
				XCTAssertEqual(r.posts[0].attachments!.count, 0)
				XCTAssertEqual(r.posts[0].links!.count, 0)
				XCTAssertNil(r.posts[0].replyTo)
				XCTAssertNil(r.posts[0].topic!.description)
				XCTAssertEqual(r.posts[0].topic!.lastPostedAt!.description, "2017-10-12 06:20:40 +0000")
				XCTAssertEqual(r.posts[0].topic!.name, "Awesome project")
				XCTAssertEqual(r.posts[0].topic!.suggestion, "Awesome project")
				XCTAssertEqual(r.posts[0].topic!.updatedAt.description, "2017-10-12 06:22:28 +0000")
				XCTAssertEqual(r.posts[0].topic!.id, 53692)
				XCTAssertEqual(r.posts[0].topic!.createdAt.description, "2017-09-27 09:43:29 +0000")
				XCTAssertEqual(r.posts[0].topic!.isDirectMessage, false)
				//XCTAssertNil(r.posts[0].directMessage)
				XCTAssertEqual(r.posts[0].updatedAt.description, "2017-10-12 06:20:20 +0000")
				XCTAssertEqual(r.posts[0].message, "It is sunny today.")
				XCTAssertEqual(r.posts[0].id, 11842896)
				XCTAssertEqual(r.posts[0].createdAt.description, "2017-10-12 06:20:20 +0000")
				XCTAssertEqual(r.isLimited, false)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testLikeMessage() {
		createStub("like-message")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(LikeMessage(topicId: 0, postId: 0)) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.topic!.name, "Design")
                XCTAssertEqual(r.topic!.lastPostedAt!.description, "2018-09-25 04:42:47 +0000")
                XCTAssertEqual(r.topic!.description, "All about the world of visual design which include app ui/ux, website, news, tips and occasional banter among designers. Oh, and don't forget the weekend together.\n\nSome housekeeping:\n 1. Share your work and comment on others' work in a nice manners.\n 2. Report any issue to @Stefanie\n 3. Have fun typetalkin'! https://typetalk.com\n\nNote that this topic is open to everyone in the team!")
                XCTAssertEqual(r.topic!.suggestion, "Design")
                XCTAssertEqual(r.topic!.updatedAt.description, "2018-09-19 06:02:29 +0000")
                XCTAssertEqual(r.topic!.id, 4483)
                XCTAssertEqual(r.topic!.createdAt.description, "2017-03-21 20:04:45 +0000")
                XCTAssertEqual(r.topic!.isDirectMessage, false)
                XCTAssertNil(r.directMessage)
                XCTAssertEqual(r.post!.topicId, 4483)
                XCTAssertEqual(r.post!.account.name, "Will")
                XCTAssertEqual(r.post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2497/profile_image.png?t=1510596200433")
                XCTAssertEqual(r.post!.account.isBot, false)
                XCTAssertEqual(r.post!.account.suggestion, "Will")
                XCTAssertEqual(r.post!.account.updatedAt.description, "2018-11-13 00:26:14 +0000")
                XCTAssertEqual(r.post!.account.fullName, "Will")
                XCTAssertEqual(r.post!.account.id, 2497)
                XCTAssertEqual(r.post!.account.createdAt.description, "2016-01-27 09:54:48 +0000")
                XCTAssertEqual(r.post!.attachments!.count, 0)
                XCTAssertEqual(r.post!.links!.count, 0)
                XCTAssertEqual(r.post!.replyTo, 167210)
                XCTAssertEqual(r.post!.mention!.id, 16805)
                XCTAssertEqual(r.post!.mention!.readAt!.description, "2018-09-25 07:08:45 +0000")
                XCTAssertEqual(r.post!.likes!.count, 0)
                XCTAssertEqual(r.post!.updatedAt.description, "2018-09-25 04:42:47 +0000")
                XCTAssertEqual(r.post!.talks!.count, 0)
                XCTAssertEqual(r.post!.message, "Hi @Jessica ?")
                XCTAssertEqual(r.post!.id, 167373)
                XCTAssertEqual(r.post!.createdAt.description, "2018-09-25 04:42:47 +0000")
                XCTAssertEqual(r.like.comment, "")
                XCTAssertEqual(r.like.topicId, 4483)
                XCTAssertEqual(r.like.account!.name, "Jessica")
                XCTAssertEqual(r.like.account!.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.like.account!.isBot, false)
                XCTAssertEqual(r.like.account!.suggestion, "Jessica")
                XCTAssertEqual(r.like.account!.updatedAt.description, "2018-11-27 23:50:39 +0000")
                XCTAssertEqual(r.like.account!.fullName, "Jessica")
                XCTAssertEqual(r.like.account!.id, 2500)
                XCTAssertEqual(r.like.account!.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.like.postId, 167373)
                XCTAssertEqual(r.like.id, 20050)
                XCTAssertEqual(r.like.createdAt!.description, "2018-11-27 23:51:44 +0000")
                XCTAssertEqual(r.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxxx/photo/large")
                XCTAssertEqual(r.space.enabled, true)
                XCTAssertEqual(r.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.space.key, "xxxxxxxx")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testUnlikeMessage() {
		createStub("unlike-message")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(UnlikeMessage(topicId: 0, postId: 0)) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.like.comment, "")
                XCTAssertEqual(r.like.topicId, 4483)
                XCTAssertEqual(r.like.account!.name, "Jessica")
                XCTAssertEqual(r.like.account!.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.like.account!.isBot, false)
                XCTAssertEqual(r.like.account!.suggestion, "Jessica Lee")
                XCTAssertEqual(r.like.account!.updatedAt.description, "2018-12-25 10:42:43 +0000")
                XCTAssertEqual(r.like.account!.fullName, "Jessica Lee")
                XCTAssertEqual(r.like.account!.id, 2500)
                XCTAssertEqual(r.like.account!.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.like.postId, 167373)
                XCTAssertEqual(r.like.id, 20050)
                XCTAssertEqual(r.like.createdAt!.description, "2018-11-27 23:51:44 +0000")
                XCTAssertEqual(r.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxx/photo/large")
                XCTAssertEqual(r.space.enabled, true)
                XCTAssertEqual(r.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.space.key, "xxxxxx")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	/*func testFavoriteTopic() {
		createStub("favorite-topic")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(FavoriteTopic(topicId: 0)) { result in

			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topic.name, "VisualDesigners")
				XCTAssertEqual(r.topic.suggestion, "VisualDesigners")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 206)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.favorite, true)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testUnfavoriteTopic() {
		createStub("unfavorite-topic")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(UnfavoriteTopic(topicId: 0)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.topic.name, "VisualDesigners")
				XCTAssertEqual(r.topic.suggestion, "VisualDesigners")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 206)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-08 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.favorite, false)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}*/


	func testGetDirectMessages() {
		createStub("get-direct-messages")

		let expectation = self.expectation(description: "")
        TypetalkAPI.send(GetDirectMessages(spaceKey: "foo", accountName: "foo")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.hasNext, false)
                XCTAssertEqual(r.bookmark.postId, 168196)
                XCTAssertEqual(r.bookmark.updatedAt.description, "2018-11-26 01:09:13 +0000")
                XCTAssertEqual(r.mySpace.myRole, "ADMIN")
                XCTAssertEqual(r.mySpace.isPaymentAdmin, true)
                XCTAssertEqual(r.mySpace.invitableRoles!.count, 3)
                XCTAssertEqual(r.mySpace.invitableRoles![0], "ADMIN")
                XCTAssertEqual(r.mySpace.invitableRoles![1], "USER")
                XCTAssertEqual(r.mySpace.invitableRoles![2], "GUEST")
                XCTAssertEqual(r.mySpace.myPlan.numberOfUsers, 4)
                XCTAssertEqual(r.mySpace.myPlan.enabled, true)
                XCTAssertEqual(r.mySpace.myPlan.numberOfAllowedAddresses, 0)
                XCTAssertNil(r.mySpace.myPlan.trial)
                XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfUsers, 10)
                XCTAssertEqual(r.mySpace.myPlan.plan.limitNumberOfAllowedAddresses, 10)
                XCTAssertEqual(r.mySpace.myPlan.plan.name, "Standard 10 Users")
                XCTAssertEqual(r.mySpace.myPlan.plan.key, "typetalk.standard10")
                XCTAssertEqual(r.mySpace.myPlan.plan.limitTotalAttachmentSize, 10737418240)
                XCTAssertEqual(r.mySpace.myPlan.updatedAt.description, "2018-11-09 10:33:30 +0000")
                XCTAssertEqual(r.mySpace.myPlan.totalAttachmentSize, 14356)
                XCTAssertEqual(r.mySpace.myPlan.createdAt.description, "2016-01-27 09:37:27 +0000")
                XCTAssertEqual(r.mySpace.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxxx/photo/large")
                XCTAssertEqual(r.mySpace.space.enabled, true)
                XCTAssertEqual(r.mySpace.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.mySpace.space.key, "xxxxxxxx")
                XCTAssertEqual(r.posts.count, 3)
                XCTAssertEqual(r.posts[0].topicId, 3917)
                XCTAssertEqual(r.posts[0].account.name, "Stefanie")
                XCTAssertEqual(r.posts[0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.posts[0].account.isBot, false)
                XCTAssertEqual(r.posts[0].account.suggestion, "Stefanie")
                XCTAssertEqual(r.posts[0].account.updatedAt.description, "2018-11-09 10:29:47 +0000")
                XCTAssertEqual(r.posts[0].account.fullName, "Stefanie")
                XCTAssertEqual(r.posts[0].account.id, 2498)
                XCTAssertEqual(r.posts[0].account.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertEqual(r.posts[0].attachments!.count, 0)
                XCTAssertEqual(r.posts[0].links!.count, 0)
                XCTAssertNil(r.posts[0].replyTo)
                XCTAssertNil(r.posts[0].mention)
                XCTAssertEqual(r.posts[0].likes!.count, 0)
                XCTAssertEqual(r.posts[0].updatedAt.description, "2018-04-27 09:12:25 +0000")
                XCTAssertEqual(r.posts[0].talks!.count, 0)
                XCTAssertEqual(r.posts[0].message, "Hey")
                XCTAssertEqual(r.posts[0].id, 164783)
                XCTAssertEqual(r.posts[0].createdAt.description, "2018-04-27 09:12:25 +0000")
                XCTAssertEqual(r.posts[1].topicId, 3917)
                XCTAssertEqual(r.posts[1].account.name, "Stefanie")
                XCTAssertEqual(r.posts[1].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.posts[1].account.isBot, false)
                XCTAssertEqual(r.posts[1].account.suggestion, "Stefanie")
                XCTAssertEqual(r.posts[1].account.updatedAt.description, "2018-11-09 10:29:47 +0000")
                XCTAssertEqual(r.posts[1].account.fullName, "Stefanie")
                XCTAssertEqual(r.posts[1].account.id, 2498)
                XCTAssertEqual(r.posts[1].account.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertEqual(r.posts[1].attachments!.count, 0)
                XCTAssertEqual(r.posts[1].links!.count, 0)
                XCTAssertNil(r.posts[1].replyTo)
                XCTAssertNil(r.posts[1].mention)
                XCTAssertEqual(r.posts[1].likes!.count, 0)
                XCTAssertEqual(r.posts[1].updatedAt.description, "2018-04-27 09:13:02 +0000")
                XCTAssertEqual(r.posts[1].talks!.count, 0)
                XCTAssertEqual(r.posts[1].message, "Can I ask you a question?")
                XCTAssertEqual(r.posts[1].id, 164784)
                XCTAssertEqual(r.posts[1].createdAt.description, "2018-04-27 09:13:02 +0000")
                XCTAssertEqual(r.posts[2].topicId, 3917)
                XCTAssertEqual(r.posts[2].account.name, "Jessica")
                XCTAssertEqual(r.posts[2].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.posts[2].account.isBot, false)
                XCTAssertEqual(r.posts[2].account.suggestion, "Jessica")
                XCTAssertEqual(r.posts[2].account.updatedAt.description, "2018-11-26 05:12:25 +0000")
                XCTAssertEqual(r.posts[2].account.fullName, "Jessica")
                XCTAssertEqual(r.posts[2].account.id, 2500)
                XCTAssertEqual(r.posts[2].account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.posts[2].attachments!.count, 0)
                XCTAssertEqual(r.posts[2].links!.count, 0)
                XCTAssertNil(r.posts[2].replyTo)
                XCTAssertNil(r.posts[2].mention)
                XCTAssertEqual(r.posts[2].likes!.count, 0)
                XCTAssertEqual(r.posts[2].updatedAt.description, "2018-11-26 01:09:12 +0000")
                XCTAssertEqual(r.posts[2].talks!.count, 0)
                XCTAssertEqual(r.posts[2].message, "Sure!")
                XCTAssertEqual(r.posts[2].id, 168196)
                XCTAssertEqual(r.posts[2].createdAt.description, "2018-11-26 01:09:12 +0000")
                XCTAssertEqual(r.topic.name, "Jessica,StefHull")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2018-11-26 01:09:12 +0000")
                XCTAssertEqual(r.topic.suggestion, "Jessica,StefHull")
                XCTAssertEqual(r.topic.updatedAt.description, "2016-08-17 08:30:58 +0000")
                XCTAssertEqual(r.topic.id, 3917)
                XCTAssertEqual(r.topic.createdAt.description, "2016-07-06 02:51:03 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, true)
                XCTAssertNil(r.directMessage.status!.mobile)
                XCTAssertNil(r.directMessage.status!.web)
                XCTAssertEqual(r.directMessage.status!.presence, "away")
                XCTAssertEqual(r.directMessage.account.name, "Stefanie")
                XCTAssertEqual(r.directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.directMessage.account.isBot, false)
                XCTAssertEqual(r.directMessage.account.suggestion, "Stefanie")
                XCTAssertEqual(r.directMessage.account.updatedAt.description, "2018-11-09 10:29:47 +0000")
                XCTAssertEqual(r.directMessage.account.fullName, "Stefanie")
                XCTAssertEqual(r.directMessage.account.id, 2498)
                XCTAssertEqual(r.directMessage.account.createdAt.description, "2016-01-27 09:55:09 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testPostDirectMessage() {
		createStub("post-direct-message")

		let expectation = self.expectation(description: "")
        TypetalkAPI.send(PostDirectMessage(spaceKey: "foo", accountName: "foo", message: "bar")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxxx/photo/large")
                XCTAssertEqual(r.space.enabled, true)
                XCTAssertEqual(r.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.space.key, "xxxxxxxx")
                XCTAssertEqual(r.topic.name, "Jessica,StefHull")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2018-11-26 01:09:12 +0000")
                XCTAssertEqual(r.topic.description, "")
                XCTAssertEqual(r.topic.suggestion, "Jessica,StefHull")
                XCTAssertEqual(r.topic.updatedAt.description, "2016-08-17 08:30:58 +0000")
                XCTAssertEqual(r.topic.id, 3917)
                XCTAssertEqual(r.topic.createdAt.description, "2016-07-06 02:51:03 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, true)
                XCTAssertEqual(r.directMessage.account.name, "Stefanie")
                XCTAssertEqual(r.directMessage.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.directMessage.account.isBot, false)
                XCTAssertEqual(r.directMessage.account.suggestion, "Stefanie")
                XCTAssertEqual(r.directMessage.account.updatedAt.description, "2018-11-09 10:29:47 +0000")
                XCTAssertEqual(r.directMessage.account.fullName, "Stefanie")
                XCTAssertEqual(r.directMessage.account.id, 2498)
                XCTAssertEqual(r.directMessage.account.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertEqual(r.exceedsAttachmentLimit, false)
                XCTAssertEqual(r.mentions.count, 0)
                XCTAssertEqual(r.post.topicId, 3917)
                XCTAssertEqual(r.post.account.name, "Jessica")
                XCTAssertEqual(r.post.account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.post.account.isBot, false)
                XCTAssertEqual(r.post.account.suggestion, "Jessica")
                XCTAssertEqual(r.post.account.updatedAt.description, "2018-11-26 01:07:27 +0000")
                XCTAssertEqual(r.post.account.fullName, "Jessica")
                XCTAssertEqual(r.post.account.id, 2500)
                XCTAssertEqual(r.post.account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertEqual(r.post.attachments!.count, 0)
                XCTAssertEqual(r.post.links!.count, 0)
                XCTAssertNil(r.post.replyTo)
                XCTAssertNil(r.post.mention)
                XCTAssertEqual(r.post.likes!.count, 0)
                XCTAssertEqual(r.post.updatedAt.description, "2018-11-26 01:09:12 +0000")
                XCTAssertEqual(r.post.talks!.count, 0)
                XCTAssertEqual(r.post.message, "Sure!")
                XCTAssertEqual(r.post.id, 168196)
                XCTAssertEqual(r.post.createdAt.description, "2018-11-26 01:09:12 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	/*func testGetNotifications() {
		createStub("get-notifications")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetNotifications()) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.mentions?.count, 2)
				XCTAssertEqual(r.mentions![0].post!.topicId, 203)
				XCTAssertEqual(r.mentions![0].post!.account.name, "moss")
				XCTAssertEqual(r.mentions![0].post!.account.imageUrl.absoluteString, "http://typetalk.local:8484/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.mentions![0].post!.account.isBot, false)
				XCTAssertEqual(r.mentions![0].post!.account.suggestion, "Moss")
				XCTAssertEqual(r.mentions![0].post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions![0].post!.account.fullName, "Moss")
				XCTAssertEqual(r.mentions![0].post!.account.id, 102)
				XCTAssertEqual(r.mentions![0].post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions![0].post!.attachments!.count, 0)
				XCTAssertEqual(r.mentions![0].post!.links?.count, 0)
				XCTAssertNil(r.mentions![0].post!.replyTo)
				XCTAssertEqual(r.mentions![0].post!.topic!.description, "")
				XCTAssertEqual(r.mentions![0].post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions![0].post!.topic!.name, "Techies")
				XCTAssertEqual(r.mentions![0].post!.topic!.suggestion, "Techies")
				XCTAssertEqual(r.mentions![0].post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions![0].post!.topic!.id, 203)
				XCTAssertEqual(r.mentions![0].post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions![0].post!.topic!.isDirectMessage, false)
				//XCTAssertNil(r.mentions![0].post!.directMessage)
				XCTAssertEqual(r.mentions![0].post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions![0].post!.message, "@jessica Help me!")
				XCTAssertEqual(r.mentions![0].post!.id, 309)
				XCTAssertEqual(r.mentions![0].post!.createdAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions![0].id, 501)
				XCTAssertNil(r.mentions![0].readAt)
				XCTAssertEqual(r.mentions![1].post!.topicId, 202)
				XCTAssertEqual(r.mentions![1].post!.account.name, "ahorowitz")
				XCTAssertEqual(r.mentions![1].post!.account.imageUrl.absoluteString, "http://typetalk.local:8484/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.mentions![1].post!.account.isBot, false)
				XCTAssertEqual(r.mentions![1].post!.account.suggestion, "AHorowitz")
				XCTAssertEqual(r.mentions![1].post!.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions![1].post!.account.fullName, "AHorowitz")
				XCTAssertEqual(r.mentions![1].post!.account.id, 101)
				XCTAssertEqual(r.mentions![1].post!.account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions![1].post!.attachments!.count, 0)
				XCTAssertEqual(r.mentions![1].post!.links!.count, 0)
				XCTAssertNil(r.mentions![1].post!.replyTo)
				XCTAssertEqual(r.mentions![1].post!.topic!.description, "")
				XCTAssertEqual(r.mentions![1].post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions![1].post!.topic!.name, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions![1].post!.topic!.suggestion, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions![1].post!.topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions![1].post!.topic!.id, 202)
				XCTAssertEqual(r.mentions![1].post!.topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions![1].post!.topic!.isDirectMessage, false)
				//XCTAssertNil(r.mentions![1].post!.directMessage)
				XCTAssertEqual(r.mentions![1].post!.updatedAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions![1].post!.message, "@jessica What do you think about this?")
				XCTAssertEqual(r.mentions![1].post!.id, 308)
				XCTAssertEqual(r.mentions![1].post!.createdAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions![1].id, 500)
				XCTAssertEqual(r.mentions![1].readAt!.description, "2014-06-30 15:00:00 +0000")
				XCTAssertEqual(r.invites.topics?.count, 2)
				XCTAssertEqual(r.invites.topics![0].account!.name, "jessica")
				XCTAssertEqual(r.invites.topics![0].account!.imageUrl.absoluteString, "http://typetalk.local:8484/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.invites.topics![0].account!.isBot, false)
				XCTAssertEqual(r.invites.topics![0].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics![0].account!.id, 100)
				XCTAssertEqual(r.invites.topics![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].sender!.name, "brad")
				XCTAssertEqual(r.invites.topics![0].sender!.imageUrl.absoluteString, "http://typetalk.local:8484/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.invites.topics![0].sender!.isBot, false)
				XCTAssertEqual(r.invites.topics![0].sender!.suggestion, "BradMarshalls")
				XCTAssertEqual(r.invites.topics![0].sender!.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].sender!.fullName, "BradMarshalls")
				XCTAssertEqual(r.invites.topics![0].sender!.id, 105)
				XCTAssertEqual(r.invites.topics![0].sender!.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].topic!.description, "")
				XCTAssertEqual(r.invites.topics![0].topic!.lastPostedAt!.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].topic!.name, "Development")
				XCTAssertEqual(r.invites.topics![0].topic!.suggestion, "Development")
				XCTAssertEqual(r.invites.topics![0].topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].topic!.id, 210)
				XCTAssertEqual(r.invites.topics![0].topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].topic!.isDirectMessage, false)
				XCTAssertEqual(r.invites.topics![0].updatedAt!.description, "2014-07-04 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![0].message, "It is a new project. Join us!")
				XCTAssertEqual(r.invites.topics![0].id, 601)
				XCTAssertEqual(r.invites.topics![0].createdAt!.description, "2014-07-04 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].account!.name, "jessica")
				XCTAssertEqual(r.invites.topics![1].account!.imageUrl.absoluteString, "http://typetalk.local:8484/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.invites.topics![1].account!.isBot, false)
				XCTAssertEqual(r.invites.topics![1].account!.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics![1].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].account!.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.invites.topics![1].account!.id, 100)
				XCTAssertEqual(r.invites.topics![1].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].sender!.name, "chelseab")
				XCTAssertEqual(r.invites.topics![1].sender!.imageUrl.absoluteString, "http://typetalk.local:8484/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.invites.topics![1].sender!.isBot, false)
				XCTAssertEqual(r.invites.topics![1].sender!.suggestion, "ChelseaB")
				XCTAssertEqual(r.invites.topics![1].sender!.updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].sender!.fullName, "ChelseaB")
				XCTAssertEqual(r.invites.topics![1].sender!.id, 106)
				XCTAssertEqual(r.invites.topics![1].sender!.createdAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].topic!.description, "")
				XCTAssertEqual(r.invites.topics![1].topic!.lastPostedAt!.description, "2014-07-01 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].topic!.name, "Web Site")
				XCTAssertEqual(r.invites.topics![1].topic!.suggestion, "Web Site")
				XCTAssertEqual(r.invites.topics![1].topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].topic!.id, 209)
				XCTAssertEqual(r.invites.topics![1].topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].topic!.isDirectMessage, false)
				XCTAssertEqual(r.invites.topics![1].updatedAt!.description, "2014-07-03 02:32:29 +0000")
				XCTAssertEqual(r.invites.topics![1].message, "It is a new project. Join us!")
				XCTAssertEqual(r.invites.topics![1].id, 600)
				XCTAssertEqual(r.invites.topics![1].createdAt!.description, "2014-07-03 02:32:29 +0000")
				XCTAssertEqual(r.invites.teams!.count, 0)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}*/


	func testGetNotificationStatus() {
		createStub("get-notification-status")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetNotificationStatus()) { result in
			switch result {
			case .success(let r):
                XCTAssertEqual(r.notificationSettings.doNotDisturb.scheduled.start, "22:00")
                XCTAssertEqual(r.notificationSettings.doNotDisturb.scheduled.end, "07:00")
                XCTAssertEqual(r.notificationSettings.doNotDisturb.scheduled.enabled, true)
                XCTAssertEqual(r.notificationSettings.doNotDisturb.isSuppressed, false)
                XCTAssertNil(r.notificationSettings.doNotDisturb.manual.remainingTimeInMinutes)
                XCTAssertEqual(r.notificationSettings.favoriteTopicMobile, true)
                XCTAssertEqual(r.statuses.count, 1)
                XCTAssertEqual(r.statuses[0].access!.unopened, 1)
                XCTAssertEqual(r.statuses[0].mySpace!.myRole, "ADMIN")
                XCTAssertEqual(r.statuses[0].mySpace!.isPaymentAdmin, true)
                XCTAssertEqual(r.statuses[0].mySpace!.invitableRoles!.count, 3)
                XCTAssertEqual(r.statuses[0].mySpace!.invitableRoles![0], "ADMIN")
                XCTAssertEqual(r.statuses[0].mySpace!.invitableRoles![1], "USER")
                XCTAssertEqual(r.statuses[0].mySpace!.invitableRoles![2], "GUEST")
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.numberOfUsers, 4)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.enabled, true)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.numberOfAllowedAddresses, 0)
                XCTAssertNil(r.statuses[0].mySpace!.myPlan.trial)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.plan.limitNumberOfUsers, 10)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.plan.limitNumberOfAllowedAddresses, 10)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.plan.name, "Standard 10 Users")
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.plan.key, "typetalk.standard10")
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.plan.limitTotalAttachmentSize, 10737418240)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.updatedAt.description, "2018-09-10 02:24:16 +0000")
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.totalAttachmentSize, 14356)
                XCTAssertEqual(r.statuses[0].mySpace!.myPlan.createdAt.description, "2016-01-27 09:37:27 +0000")
                XCTAssertEqual(r.statuses[0].mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxxxx/photo/large")
                XCTAssertEqual(r.statuses[0].mySpace!.space.enabled, true)
                XCTAssertEqual(r.statuses[0].mySpace!.space.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.statuses[0].mySpace!.space.key, "xxxxxxxxx")
                XCTAssertEqual(r.statuses[0].like!.receive!.readLikeId, 19811)
                XCTAssertEqual(r.statuses[0].like!.receive!.hasUnread, false)
                XCTAssertEqual(r.statuses[0].unreads!.topicIds.count, 1)
                XCTAssertEqual(r.statuses[0].unreads!.topicIds[0], 4483)
                XCTAssertEqual(r.statuses[0].unreads!.dmTopicIds.count, 1)
                XCTAssertEqual(r.statuses[0].unreads!.dmTopicIds[0], 6248)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testOpenNotification() {
		createStub("open-notification")

		let expectation = self.expectation(description: "")
        TypetalkAPI.send(OpenNotification(spaceKey: "foo")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.access!.unopened, 0)
                XCTAssertEqual(r.space!.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/xxxxxxxx/photo/large")
                XCTAssertEqual(r.space!.enabled, true)
                XCTAssertEqual(r.space!.name, "Awesome Tech Inc.")
                XCTAssertEqual(r.space!.key, "xxxxxxxx")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testSaveReadTopic() {
		createStub("save-read-topic")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(SaveReadTopic(topicId: 0)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.unread.count, 0)
				XCTAssertEqual(r.unread.topicId, 208)
				XCTAssertEqual(r.unread.postId, 307)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetMentions() {
		createStub("get-mentions")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetMentions(spaceKey: "")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.mentions.count, 2)
				XCTAssertEqual(r.mentions[0].post!.topicId, 203)
				XCTAssertEqual(r.mentions[0].post!.account.name, "moss")
				XCTAssertEqual(r.mentions[0].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.mentions[0].post!.account.isBot, false)
				XCTAssertEqual(r.mentions[0].post!.account.suggestion, "Moss")
				XCTAssertEqual(r.mentions[0].post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post!.account.fullName, "Moss")
				XCTAssertEqual(r.mentions[0].post!.account.id, 102)
				XCTAssertEqual(r.mentions[0].post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post!.attachments!.count, 0)
				XCTAssertEqual(r.mentions[0].post!.links!.count, 0)
				XCTAssertNil(r.mentions[0].post!.replyTo)
				XCTAssertNil(r.mentions[0].post!.topic!.description)
				XCTAssertEqual(r.mentions[0].post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post!.topic!.name, "Techies")
				XCTAssertEqual(r.mentions[0].post!.topic!.suggestion, "Techies")
				XCTAssertEqual(r.mentions[0].post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post!.topic!.id, 203)
				XCTAssertEqual(r.mentions[0].post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post!.topic!.isDirectMessage, false)
				//XCTAssertNil(r.mentions[0].post!.directMessage)
				XCTAssertEqual(r.mentions[0].post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions[0].post!.message, "@jessica Help me!")
				XCTAssertEqual(r.mentions[0].post!.id, 309)
				XCTAssertEqual(r.mentions[0].post!.createdAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mentions[0].id, 501)
				XCTAssertNil(r.mentions[0].readAt)
				XCTAssertEqual(r.mentions[1].post!.topicId, 202)
				XCTAssertEqual(r.mentions[1].post!.account.name, "ahorowitz")
				XCTAssertEqual(r.mentions[1].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.mentions[1].post!.account.isBot, false)
				XCTAssertEqual(r.mentions[1].post!.account.suggestion, "AHorowitz")
				XCTAssertEqual(r.mentions[1].post!.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post!.account.fullName, "AHorowitz")
				XCTAssertEqual(r.mentions[1].post!.account.id, 101)
				XCTAssertEqual(r.mentions[1].post!.account.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post!.attachments!.count, 0)
				XCTAssertEqual(r.mentions[1].post!.links!.count, 0)
				XCTAssertNil(r.mentions[1].post!.replyTo)
				XCTAssertNil(r.mentions[1].post!.topic!.description)
				XCTAssertEqual(r.mentions[1].post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post!.topic!.name, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions[1].post!.topic!.suggestion, "Arts & Crafts Club")
				XCTAssertEqual(r.mentions[1].post!.topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post!.topic!.id, 202)
				XCTAssertEqual(r.mentions[1].post!.topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post!.topic!.isDirectMessage, false)
				//XCTAssertNil(r.mentions[1].post!.directMessage)
				XCTAssertEqual(r.mentions[1].post!.updatedAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions[1].post!.message, "@jessica What do you think about this?")
				XCTAssertEqual(r.mentions[1].post!.id, 308)
				XCTAssertEqual(r.mentions[1].post!.createdAt.description, "2014-07-01 03:32:29 +0000")
				XCTAssertEqual(r.mentions[1].id, 500)
				XCTAssertEqual(r.mentions[1].readAt!.description, "2014-06-30 15:00:00 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testSaveReadMention() {
		createStub("save-read-mention")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(SaveReadMention(mentionId: 0)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.mention.post!.topicId, 203)
				XCTAssertEqual(r.mention.post!.account.name, "moss")
				XCTAssertEqual(r.mention.post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.mention.post!.account.isBot, false)
				XCTAssertEqual(r.mention.post!.account.suggestion, "Moss")
				XCTAssertEqual(r.mention.post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mention.post!.account.fullName, "Moss")
				XCTAssertEqual(r.mention.post!.account.id, 102)
				XCTAssertEqual(r.mention.post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.mention.post!.attachments!.count, 0)
				XCTAssertEqual(r.mention.post!.links!.count, 0)
				XCTAssertNil(r.mention.post!.replyTo)
				XCTAssertNil(r.mention.post!.topic!.description)
				XCTAssertEqual(r.mention.post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.mention.post!.topic!.name, "Techies")
				XCTAssertEqual(r.mention.post!.topic!.suggestion, "Techies")
				XCTAssertEqual(r.mention.post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mention.post!.topic!.id, 203)
				XCTAssertEqual(r.mention.post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
				XCTAssertEqual(r.mention.post!.topic!.isDirectMessage, false)
				//XCTAssertNil(r.mention.post!.directMessage)
				XCTAssertEqual(r.mention.post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mention.post!.message, "@jessica Help me!")
				XCTAssertEqual(r.mention.post!.id, 309)
				XCTAssertEqual(r.mention.post!.createdAt.description, "2014-07-02 03:32:29 +0000")
				XCTAssertEqual(r.mention.id, 501)
				XCTAssertEqual(r.mention.readAt!.description, "2016-12-21 10:12:13 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testCreateTopic() {
		createStub("create-topic")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(CreateTopic(name: "foo", spaceKey: "bar")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.integrations!.count, 0)
                XCTAssertNil(r.remainingInvitations)
                XCTAssertEqual(r.groups!.count, 1)
                XCTAssertEqual(r.groups![0].memberCount, 4)
                XCTAssertEqual(r.groups![0].group.key, "groupkey01")
                XCTAssertEqual(r.groups![0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
                XCTAssertEqual(r.groups![0].group.suggestion, "Joe Tech Inc. All")
                XCTAssertEqual(r.groups![0].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(r.groups![0].group.id, 1100)
                XCTAssertEqual(r.groups![0].group.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(r.groups![0].group.name, "Joe Tech Inc. All")
                XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
                XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
                XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 7)
                XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
                XCTAssertNil(r.mySpace!.myPlan.trial)
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
                XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Free Plan")
                XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.free")
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 1073741824)
                XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2016-01-20 02:32:29 +0000")
                XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 0)
                XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
                XCTAssertEqual(r.mySpace!.space.enabled, true)
                XCTAssertEqual(r.mySpace!.space.name, "Joe Tech Inc.")
                XCTAssertEqual(r.mySpace!.space.key, "abcdefghij")
                XCTAssertEqual(r.accountsForApi!.count, 0)
                XCTAssertEqual(r.teams!.count, 0)
                XCTAssertEqual(r.topic.description, "")
                XCTAssertNil(r.topic.lastPostedAt)
                XCTAssertEqual(r.topic.name, "Test topic")
                XCTAssertEqual(r.topic.suggestion, "Test topic")
                XCTAssertEqual(r.topic.updatedAt.description, "2016-12-21 10:12:14 +0000")
                XCTAssertEqual(r.topic.id, 223)
                XCTAssertEqual(r.topic.createdAt.description, "2016-12-21 10:12:14 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, false)
                XCTAssertEqual(r.accounts!.count, 1)
                XCTAssertEqual(r.accounts![0].name, "chelseab")
                XCTAssertEqual(r.accounts![0].imageUrl.absoluteString, "https://typetalk.com/accounts/106/profile_image.png?t=1404095549000")
                XCTAssertEqual(r.accounts![0].isBot, false)
                XCTAssertEqual(r.accounts![0].suggestion, "ChelseaB")
                XCTAssertEqual(r.accounts![0].updatedAt.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.accounts![0].fullName, "ChelseaB")
                XCTAssertEqual(r.accounts![0].id, 106)
                XCTAssertEqual(r.accounts![0].createdAt.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.invitingAccounts!.count, 0)
                XCTAssertEqual(r.invites!.count, 0)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testUpdateTopic() {
		createStub("update-topic")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(UpdateTopic(topicId: 0, name: "")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.integrations!.count, 0)
				XCTAssertNil(r.remainingInvitations)
				XCTAssertEqual(r.groups!.count, 1)
				XCTAssertEqual(r.groups![0].memberCount, 4)
				XCTAssertEqual(r.groups![0].group.key, "groupkey01")
                XCTAssertEqual(r.groups![0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
				XCTAssertEqual(r.groups![0].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups![0].group.id, 1100)
				XCTAssertEqual(r.groups![0].group.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups![0].group.name, "Joe Tech Inc. All")
				XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
				XCTAssertNil(r.mySpace!.myPlan.trial)
				XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2016-12-21 10:12:14 +0000")
				XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace!.space.enabled, true)
				XCTAssertEqual(r.mySpace!.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace!.space.key, "abcdefghij")
				XCTAssertEqual(r.accountsForApi!.count, 0)
				XCTAssertEqual(r.teams!.count, 0)
				XCTAssertEqual(r.topic.description, "Test topic description")
				XCTAssertNil(r.topic.lastPostedAt)
				XCTAssertEqual(r.topic.name, "Update test topic")
				XCTAssertEqual(r.topic.suggestion, "Update test topic")
				XCTAssertEqual(r.topic.updatedAt.description, "2016-12-21 10:12:15 +0000")
				XCTAssertEqual(r.topic.id, 223)
				XCTAssertEqual(r.topic.createdAt.description, "2016-12-21 10:12:14 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.accounts!.count, 1)
				XCTAssertEqual(r.accounts![0].name, "chelseab")
				XCTAssertEqual(r.accounts![0].imageUrl.absoluteString, "https://typetalk.com/accounts/106/profile_image.png?t=1404095549000")
				XCTAssertEqual(r.accounts![0].isBot, false)
				XCTAssertEqual(r.accounts![0].suggestion, "ChelseaB")
				XCTAssertEqual(r.accounts![0].updatedAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.accounts![0].fullName, "ChelseaB")
				XCTAssertEqual(r.accounts![0].id, 106)
				XCTAssertEqual(r.accounts![0].createdAt.description, "2014-06-30 02:32:29 +0000")
				XCTAssertEqual(r.invitingAccounts!.count, 0)
				XCTAssertEqual(r.invites!.count, 0)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testDeleteTopic() {
		createStub("delete-topic")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(DeleteTopic(topicId: 0)) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.myTopic.topicId, 6196)
                XCTAssertEqual(r.myTopic.kind, "grouped")
                XCTAssertNil(r.myTopic.exTopicGroupId)
                XCTAssertEqual(r.myTopic.topicGroupId, 1642)
                XCTAssertEqual(r.myTopic.updatedAt.description, "2018-09-19 05:02:16 +0000")
                XCTAssertEqual(r.myTopic.orderNo, 0)
                XCTAssertEqual(r.myTopic.id, 8708)
                XCTAssertEqual(r.myTopic.createdAt.description, "2018-09-19 05:02:16 +0000")
                XCTAssertEqual(r.myTopic.accountId, 2500)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetTopicDetails() {
		createStub("get-topic-details")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetTopicDetails(topicId: 0)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.integrations!.count, 0)
				XCTAssertNil(r.remainingInvitations)
				XCTAssertEqual(r.groups!.count, 1)
				XCTAssertEqual(r.groups![0].memberCount, 4)
				XCTAssertEqual(r.groups![0].group.key, "groupkey01")
                XCTAssertEqual(r.groups![0].group.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/groups/groupkey01/photo/medium")
				XCTAssertEqual(r.groups![0].group.suggestion, "Joe Tech Inc. All")
				XCTAssertEqual(r.groups![0].group.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups![0].group.id, 1100)
				XCTAssertEqual(r.groups![0].group.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.groups![0].group.name, "Joe Tech Inc. All")
				XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 7)
				XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
				XCTAssertNil(r.mySpace!.myPlan.trial)
				XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2016-12-21 10:12:16 +0000")
				XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace!.space.enabled, true)
				XCTAssertEqual(r.mySpace!.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace!.space.key, "abcdefghij")
				XCTAssertEqual(r.accountsForApi!.count, 0)
				XCTAssertEqual(r.teams!.count, 0)
				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.accounts!.count, 2)
				XCTAssertEqual(r.accounts![0].name, "brad")
                XCTAssertEqual(r.accounts![0].imageUrl.absoluteString, "https://typetalk.com/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.accounts![0].isBot, false)
				XCTAssertEqual(r.accounts![0].suggestion, "BradMarshalls")
				XCTAssertEqual(r.accounts![0].updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts![0].fullName, "BradMarshalls")
				XCTAssertEqual(r.accounts![0].id, 105)
				XCTAssertEqual(r.accounts![0].createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.accounts![1].name, "cooper")
                XCTAssertEqual(r.accounts![1].imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.accounts![1].isBot, false)
				XCTAssertEqual(r.accounts![1].suggestion, "CooperDaChopper")
				XCTAssertEqual(r.accounts![1].updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.accounts![1].fullName, "CooperDaChopper")
				XCTAssertEqual(r.accounts![1].id, 104)
				XCTAssertEqual(r.accounts![1].createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.invitingAccounts!.count, 0)
				XCTAssertEqual(r.invites!.count, 0)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}

    func testUpdateTopicMembers() {
        createStub("update-topic-members")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(UpdateTopicMembers(topicId: 0)) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.integrations!.count, 0)
                XCTAssertNil(r.remainingInvitations)
                XCTAssertEqual(r.groups!.count, 0)
                XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
                XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
                XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 7)
                XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
                XCTAssertNil(r.mySpace!.myPlan.trial)
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
                XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Free Plan")
                XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.free")
                XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 1073741824)
                XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2016-12-21 10:12:16 +0000")
                XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 0)
                XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
                XCTAssertEqual(r.mySpace!.space.enabled, true)
                XCTAssertEqual(r.mySpace!.space.name, "Joe Tech Inc.")
                XCTAssertEqual(r.mySpace!.space.key, "abcdefghij")
                XCTAssertEqual(r.accountsForApi!.count, 0)
                XCTAssertEqual(r.teams!.count, 0)
                XCTAssertEqual(r.topic.description, "")
                XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
                XCTAssertEqual(r.topic.name, "IT Peeps")
                XCTAssertEqual(r.topic.suggestion, "IT Peeps")
                XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(r.topic.id, 208)
                XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(r.topic.isDirectMessage, false)
                XCTAssertEqual(r.accounts!.count, 3)
                XCTAssertEqual(r.accounts![0].name, "brad")
                XCTAssertEqual(r.accounts![0].imageUrl.absoluteString, "https://typetalk.com/accounts/105/profile_image.png?t=1404009149000")
                XCTAssertEqual(r.accounts![0].isBot, false)
                XCTAssertEqual(r.accounts![0].suggestion, "BradMarshalls")
                XCTAssertEqual(r.accounts![0].updatedAt.description, "2014-06-29 02:32:29 +0000")
                XCTAssertEqual(r.accounts![0].fullName, "BradMarshalls")
                XCTAssertEqual(r.accounts![0].id, 105)
                XCTAssertEqual(r.accounts![0].createdAt.description, "2014-06-29 02:32:29 +0000")
                XCTAssertEqual(r.accounts![1].name, "cooper")
                XCTAssertEqual(r.accounts![1].imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
                XCTAssertEqual(r.accounts![1].isBot, false)
                XCTAssertEqual(r.accounts![1].suggestion, "CooperDaChopper")
                XCTAssertEqual(r.accounts![1].updatedAt.description, "2014-06-28 02:32:29 +0000")
                XCTAssertEqual(r.accounts![1].fullName, "CooperDaChopper")
                XCTAssertEqual(r.accounts![1].id, 104)
                XCTAssertEqual(r.accounts![1].createdAt.description, "2014-06-28 02:32:29 +0000")
                XCTAssertEqual(r.accounts![2].name, "jessica")
                XCTAssertEqual(r.accounts![2].imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.accounts![2].isBot, false)
                XCTAssertEqual(r.accounts![2].suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.accounts![2].updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.accounts![2].fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.accounts![2].id, 100)
                XCTAssertEqual(r.accounts![2].createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.invitingAccounts!.count, 0)
                XCTAssertEqual(r.invites!.count, 0)

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }

	func testGetSpaces() {
		createStub("get-spaces")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetSpaces()) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.mySpaces.count, 2)
				XCTAssertEqual(r.mySpaces[0].myRole, "ADMIN")
				XCTAssertEqual(r.mySpaces[0].isPaymentAdmin, true)
				XCTAssertEqual(r.mySpaces[0].myPlan.numberOfUsers, 6)
				XCTAssertEqual(r.mySpaces[0].myPlan.enabled, true)
				XCTAssertNil(r.mySpaces[0].myPlan.trial)
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpaces[0].myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpaces[0].myPlan.updatedAt.description, "2016-12-21 10:12:18 +0000")
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
				XCTAssertEqual(r.mySpaces[1].myPlan.trial!.endDate, "2017-01-04")
				XCTAssertEqual(r.mySpaces[1].myPlan.trial!.daysLeft, 15)
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.name, "Starter Plan")
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.key, "typetalk.starter")
				XCTAssertEqual(r.mySpaces[1].myPlan.plan.limitTotalAttachmentSize, 10737418240)
				XCTAssertEqual(r.mySpaces[1].myPlan.updatedAt.description, "2016-12-21 01:11:43 +0000")
				XCTAssertEqual(r.mySpaces[1].myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpaces[1].myPlan.createdAt.description, "2016-12-06 01:11:43 +0000")
                XCTAssertEqual(r.mySpaces[1].space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/0123456789/photo/large")
				XCTAssertEqual(r.mySpaces[1].space.enabled, true)
				XCTAssertEqual(r.mySpaces[1].space.name, "Nu team")
				XCTAssertEqual(r.mySpaces[1].space.key, "0123456789")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}

	func testGetSpaceMembers() {
		createStub("get-space-members")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetSpaceMembers(spaceKey: "foo")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.accounts.count, 7)
                XCTAssertEqual(r.accounts[0].name, "ahorowitz")
                XCTAssertEqual(r.accounts[0].imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
                XCTAssertEqual(r.accounts[0].isBot, false)
                XCTAssertEqual(r.accounts[0].suggestion, "AHorowitz")
                XCTAssertEqual(r.accounts[0].updatedAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.accounts[0].fullName, "AHorowitz")
                XCTAssertEqual(r.accounts[0].id, 101)
                XCTAssertEqual(r.accounts[0].createdAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.accounts[1].name, "brad")
                XCTAssertEqual(r.accounts[1].imageUrl.absoluteString, "https://typetalk.com/accounts/105/profile_image.png?t=1404009149000")
                XCTAssertEqual(r.accounts[1].isBot, false)
                XCTAssertEqual(r.accounts[1].suggestion, "BradMarshalls")
                XCTAssertEqual(r.accounts[1].updatedAt.description, "2014-06-29 02:32:29 +0000")
                XCTAssertEqual(r.accounts[1].fullName, "BradMarshalls")
                XCTAssertEqual(r.accounts[1].id, 105)
                XCTAssertEqual(r.accounts[1].createdAt.description, "2014-06-29 02:32:29 +0000")
                XCTAssertEqual(r.accounts[2].name, "chelseab")
                XCTAssertEqual(r.accounts[2].imageUrl.absoluteString, "https://typetalk.com/accounts/106/profile_image.png?t=1404095549000")
                XCTAssertEqual(r.accounts[2].isBot, false)
                XCTAssertEqual(r.accounts[2].suggestion, "ChelseaB")
                XCTAssertEqual(r.accounts[2].updatedAt.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.accounts[2].fullName, "ChelseaB")
                XCTAssertEqual(r.accounts[2].id, 106)
                XCTAssertEqual(r.accounts[2].createdAt.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.accounts[3].name, "cooper")
                XCTAssertEqual(r.accounts[3].imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
                XCTAssertEqual(r.accounts[3].isBot, false)
                XCTAssertEqual(r.accounts[3].suggestion, "CooperDaChopper")
                XCTAssertEqual(r.accounts[3].updatedAt.description, "2014-06-28 02:32:29 +0000")
                XCTAssertEqual(r.accounts[3].fullName, "CooperDaChopper")
                XCTAssertEqual(r.accounts[3].id, 104)
                XCTAssertEqual(r.accounts[3].createdAt.description, "2014-06-28 02:32:29 +0000")
                XCTAssertEqual(r.accounts[4].name, "jessica")
                XCTAssertEqual(r.accounts[4].imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.accounts[4].isBot, false)
                XCTAssertEqual(r.accounts[4].suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.accounts[4].updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.accounts[4].fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.accounts[4].id, 100)
                XCTAssertEqual(r.accounts[4].createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.accounts[5].name, "moss")
                XCTAssertEqual(r.accounts[5].imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
                XCTAssertEqual(r.accounts[5].isBot, false)
                XCTAssertEqual(r.accounts[5].suggestion, "Moss")
                XCTAssertEqual(r.accounts[5].updatedAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.accounts[5].fullName, "Moss")
                XCTAssertEqual(r.accounts[5].id, 102)
                XCTAssertEqual(r.accounts[5].createdAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.accounts[6].name, "stefhull")
                XCTAssertEqual(r.accounts[6].imageUrl.absoluteString, "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000")
                XCTAssertEqual(r.accounts[6].isBot, false)
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
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetFriends() {
		createStub("get-friends")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetFriends(q: "", spaceKey: "")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.count, 4)
                XCTAssertEqual(r.accounts.count, 4)
                XCTAssertNil(r.accounts[0].status!.mobile)
                XCTAssertNil(r.accounts[0].status!.web)
                XCTAssertEqual(r.accounts[0].status!.presence, "away")
                XCTAssertEqual(r.accounts[0].account.name, "Jessica")
                XCTAssertEqual(r.accounts[0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2500/profile_image.png?t=1454061730873")
                XCTAssertEqual(r.accounts[0].account.isBot, false)
                XCTAssertEqual(r.accounts[0].account.suggestion, "Jessica")
                XCTAssertEqual(r.accounts[0].account.updatedAt.description, "2018-05-07 02:13:27 +0000")
                XCTAssertEqual(r.accounts[0].account.fullName, "Jessica")
                XCTAssertEqual(r.accounts[0].account.id, 2500)
                XCTAssertEqual(r.accounts[0].account.createdAt.description, "2016-01-27 09:55:35 +0000")
                XCTAssertNil(r.accounts[1].status!.mobile)
                XCTAssertNil(r.accounts[1].status!.web)
                XCTAssertEqual(r.accounts[1].status!.presence, "away")
                XCTAssertEqual(r.accounts[1].account.name, "Moss")
                XCTAssertEqual(r.accounts[1].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2499/profile_image.png?t=1453891379196")
                XCTAssertEqual(r.accounts[1].account.isBot, false)
                XCTAssertEqual(r.accounts[1].account.suggestion, "Moss")
                XCTAssertEqual(r.accounts[1].account.updatedAt.description, "2018-04-02 19:18:45 +0000")
                XCTAssertEqual(r.accounts[1].account.fullName, "Moss")
                XCTAssertEqual(r.accounts[1].account.id, 2499)
                XCTAssertEqual(r.accounts[1].account.createdAt.description, "2016-01-27 09:55:23 +0000")
                XCTAssertNil(r.accounts[2].status!.mobile)
                XCTAssertNil(r.accounts[2].status!.web)
                XCTAssertEqual(r.accounts[2].status!.presence, "away")
                XCTAssertEqual(r.accounts[2].account.name, "Stefanie")
                XCTAssertEqual(r.accounts[2].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2498/profile_image.png?t=1453891479138")
                XCTAssertEqual(r.accounts[2].account.isBot, false)
                XCTAssertEqual(r.accounts[2].account.suggestion, "Stefanie")
                XCTAssertEqual(r.accounts[2].account.updatedAt.description, "2018-04-27 09:12:10 +0000")
                XCTAssertEqual(r.accounts[2].account.fullName, "Stefanie")
                XCTAssertEqual(r.accounts[2].account.id, 2498)
                XCTAssertEqual(r.accounts[2].account.createdAt.description, "2016-01-27 09:55:09 +0000")
                XCTAssertNil(r.accounts[3].status!.mobile)
                XCTAssertNil(r.accounts[3].status!.web)
                XCTAssertEqual(r.accounts[3].status!.presence, "away")
                XCTAssertEqual(r.accounts[3].account.name, "Will")
                XCTAssertEqual(r.accounts[3].account.imageUrl.absoluteString, "https://typetalk.com/accounts/2497/profile_image.png?t=1510596200433")
                XCTAssertEqual(r.accounts[3].account.isBot, false)
                XCTAssertEqual(r.accounts[3].account.suggestion, "Will")
                XCTAssertEqual(r.accounts[3].account.updatedAt.description, "2018-04-02 19:11:48 +0000")
                XCTAssertEqual(r.accounts[3].account.fullName, "Will")
                XCTAssertEqual(r.accounts[3].account.id, 2497)
                XCTAssertEqual(r.accounts[3].account.createdAt.description, "2016-01-27 09:54:48 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	/*func testSearchAccounts() {
		createStub("search-accounts")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(SearchAccounts(nameOrEmailAddress: "foo")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.name, "moss")
				XCTAssertEqual(r.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.isBot, false)
				XCTAssertEqual(r.suggestion, "Moss")
				XCTAssertEqual(r.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.fullName, "Moss")
				XCTAssertEqual(r.id, 102)
				XCTAssertEqual(r.createdAt.description, "2014-06-26 02:32:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}*/


	func testGetTalks() {
		createStub("get-talks")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetTalks(topicId: 0)) { result in
			switch result {
			case .success(let r):

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
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetTalk() {
		createStub("get-talk")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetTalk(topicId: 0, talkId: 1)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.hasNext, false)
				XCTAssertEqual(r.mySpace!.myRole, "ADMIN")
				XCTAssertEqual(r.mySpace!.isPaymentAdmin, true)
				XCTAssertEqual(r.mySpace!.myPlan.numberOfUsers, 6)
				XCTAssertEqual(r.mySpace!.myPlan.enabled, true)
				XCTAssertNil(r.mySpace!.myPlan.trial)
				XCTAssertEqual(r.mySpace!.myPlan.plan.limitNumberOfUsers, 10)
				XCTAssertEqual(r.mySpace!.myPlan.plan.name, "Free Plan")
				XCTAssertEqual(r.mySpace!.myPlan.plan.key, "typetalk.free")
				XCTAssertEqual(r.mySpace!.myPlan.plan.limitTotalAttachmentSize, 1073741824)
				XCTAssertEqual(r.mySpace!.myPlan.updatedAt.description, "2016-12-21 10:12:18 +0000")
				XCTAssertEqual(r.mySpace!.myPlan.totalAttachmentSize, 0)
				XCTAssertEqual(r.mySpace!.myPlan.createdAt.description, "2016-01-10 02:32:29 +0000")
                XCTAssertEqual(r.mySpace!.space.imageUrl.absoluteString, "https://apps.nulab-inc.com/spaces/abcdefghij/photo/large")
				XCTAssertEqual(r.mySpace!.space.enabled, true)
				XCTAssertEqual(r.mySpace!.space.name, "Joe Tech Inc.")
				XCTAssertEqual(r.mySpace!.space.key, "abcdefghij")
				XCTAssertEqual(r.posts!.count, 2)
				XCTAssertEqual(r.posts![0].topicId, 208)
				XCTAssertEqual(r.posts![0].account.name, "cooper")
				XCTAssertEqual(r.posts![0].account.imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.posts![0].account.isBot, false)
				XCTAssertEqual(r.posts![0].account.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.posts![0].account.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts![0].account.fullName, "CooperDaChopper")
				XCTAssertEqual(r.posts![0].account.id, 104)
				XCTAssertEqual(r.posts![0].account.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts![0].attachments!.count, 0)
				XCTAssertEqual(r.posts![0].links!.count, 0)
				XCTAssertNil(r.posts![0].replyTo)
				XCTAssertNil(r.posts![0].mention)
				XCTAssertEqual(r.posts![0].likes!.count, 0)
				XCTAssertEqual(r.posts![0].updatedAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts![0].talks!.count, 2)
				XCTAssertEqual(r.posts![0].talks![0].topicId, 208)
				XCTAssertEqual(r.posts![0].talks![0].name, "2nd talk")
				XCTAssertNil(r.posts![0].talks![0].backlog)
				XCTAssertEqual(r.posts![0].talks![0].suggestion, "2nd talk")
				XCTAssertEqual(r.posts![0].talks![0].updatedAt.description, "2014-07-02 03:55:29 +0000")
				XCTAssertEqual(r.posts![0].talks![0].id, 901)
				XCTAssertEqual(r.posts![0].talks![0].createdAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts![0].talks![1].topicId, 208)
				XCTAssertEqual(r.posts![0].talks![1].name, "About us")
				XCTAssertNil(r.posts![0].talks![1].backlog)
				XCTAssertEqual(r.posts![0].talks![1].suggestion, "About us")
				XCTAssertEqual(r.posts![0].talks![1].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts![0].talks![1].id, 900)
				XCTAssertEqual(r.posts![0].talks![1].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.posts![0].message, "And I'm a 32 year old IT-man who works in a basement. Word.")
				XCTAssertEqual(r.posts![0].id, 305)
				XCTAssertEqual(r.posts![0].createdAt.description, "2014-06-30 14:32:29 +0000")
				XCTAssertEqual(r.posts![1].topicId, 208)
				XCTAssertEqual(r.posts![1].account.name, "jessica")
				XCTAssertEqual(r.posts![1].account.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
				XCTAssertEqual(r.posts![1].account.isBot, false)
				XCTAssertEqual(r.posts![1].account.suggestion, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts![1].account.updatedAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].account.fullName, "Jessica Fitzherbert")
				XCTAssertEqual(r.posts![1].account.id, 100)
				XCTAssertEqual(r.posts![1].account.createdAt.description, "2014-06-24 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].attachments?.count, 0)
				XCTAssertEqual(r.posts![1].links?.count, 0)
				XCTAssertEqual(r.posts![1].replyTo, 305)
				XCTAssertNil(r.posts![1].mention)
				XCTAssertEqual(r.posts![1].likes?.count, 5)
				XCTAssertNil(r.posts![1].likes![0].comment)
				XCTAssertEqual(r.posts![1].likes![0].topicId, 208)
				XCTAssertEqual(r.posts![1].likes![0].account!.name, "ahorowitz")
				XCTAssertEqual(r.posts![1].likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
				XCTAssertEqual(r.posts![1].likes![0].account!.isBot, false)
				XCTAssertEqual(r.posts![1].likes![0].account!.suggestion, "AHorowitz")
				XCTAssertEqual(r.posts![1].likes![0].account!.updatedAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![0].account!.fullName, "AHorowitz")
				XCTAssertEqual(r.posts![1].likes![0].account!.id, 101)
				XCTAssertEqual(r.posts![1].likes![0].account!.createdAt.description, "2014-06-25 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![0].postId, 306)
				XCTAssertEqual(r.posts![1].likes![0].id, 403)
				XCTAssertEqual(r.posts![1].likes![0].createdAt!.description, "2016-12-21 01:11:42 +0000")
				XCTAssertNil(r.posts![1].likes![1].comment)
				XCTAssertEqual(r.posts![1].likes![1].topicId, 208)
				XCTAssertEqual(r.posts![1].likes![1].account!.name, "moss")
				XCTAssertEqual(r.posts![1].likes![1].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
				XCTAssertEqual(r.posts![1].likes![1].account!.isBot, false)
				XCTAssertEqual(r.posts![1].likes![1].account!.suggestion, "Moss")
				XCTAssertEqual(r.posts![1].likes![1].account!.updatedAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![1].account!.fullName, "Moss")
				XCTAssertEqual(r.posts![1].likes![1].account!.id, 102)
				XCTAssertEqual(r.posts![1].likes![1].account!.createdAt.description, "2014-06-26 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![1].postId, 306)
				XCTAssertEqual(r.posts![1].likes![1].id, 404)
				XCTAssertEqual(r.posts![1].likes![1].createdAt!.description, "2016-12-21 01:11:42 +0000")
				XCTAssertNil(r.posts![1].likes![2].comment)
				XCTAssertEqual(r.posts![1].likes![2].topicId, 208)
				XCTAssertEqual(r.posts![1].likes![2].account!.name, "stefhull")
				XCTAssertEqual(r.posts![1].likes![2].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000")
				XCTAssertEqual(r.posts![1].likes![2].account!.isBot, false)
				XCTAssertEqual(r.posts![1].likes![2].account!.suggestion, "StefHull")
				XCTAssertEqual(r.posts![1].likes![2].account!.updatedAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![2].account!.fullName, "StefHull")
				XCTAssertEqual(r.posts![1].likes![2].account!.id, 103)
				XCTAssertEqual(r.posts![1].likes![2].account!.createdAt.description, "2014-06-27 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![2].postId, 306)
				XCTAssertEqual(r.posts![1].likes![2].id, 405)
				XCTAssertEqual(r.posts![1].likes![2].createdAt!.description, "2016-12-21 01:11:42 +0000")
				XCTAssertNil(r.posts![1].likes![3].comment)
				XCTAssertEqual(r.posts![1].likes![3].topicId, 208)
				XCTAssertEqual(r.posts![1].likes![3].account!.name, "cooper")
				XCTAssertEqual(r.posts![1].likes![3].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/104/profile_image.png?t=1403922749000")
				XCTAssertEqual(r.posts![1].likes![3].account!.isBot, false)
				XCTAssertEqual(r.posts![1].likes![3].account!.suggestion, "CooperDaChopper")
				XCTAssertEqual(r.posts![1].likes![3].account!.updatedAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![3].account!.fullName, "CooperDaChopper")
				XCTAssertEqual(r.posts![1].likes![3].account!.id, 104)
				XCTAssertEqual(r.posts![1].likes![3].account!.createdAt.description, "2014-06-28 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![3].postId, 306)
				XCTAssertEqual(r.posts![1].likes![3].id, 406)
				XCTAssertEqual(r.posts![1].likes![3].createdAt!.description, "2016-12-21 01:11:42 +0000")
				XCTAssertNil(r.posts![1].likes![4].comment)
				XCTAssertEqual(r.posts![1].likes![4].topicId, 208)
				XCTAssertEqual(r.posts![1].likes![4].account!.name, "brad")
				XCTAssertEqual(r.posts![1].likes![4].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/105/profile_image.png?t=1404009149000")
				XCTAssertEqual(r.posts![1].likes![4].account!.isBot, false)
				XCTAssertEqual(r.posts![1].likes![4].account!.suggestion, "BradMarshalls")
				XCTAssertEqual(r.posts![1].likes![4].account!.updatedAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![4].account!.fullName, "BradMarshalls")
				XCTAssertEqual(r.posts![1].likes![4].account!.id, 105)
				XCTAssertEqual(r.posts![1].likes![4].account!.createdAt.description, "2014-06-29 02:32:29 +0000")
				XCTAssertEqual(r.posts![1].likes![4].postId, 306)
				XCTAssertEqual(r.posts![1].likes![4].id, 407)
				XCTAssertEqual(r.posts![1].likes![4].createdAt!.description, "2016-12-21 01:11:42 +0000")
				XCTAssertEqual(r.posts![1].updatedAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.posts![1].talks!.count, 1)
				XCTAssertEqual(r.posts![1].talks![0].topicId, 208)
				XCTAssertEqual(r.posts![1].talks![0].name, "About us")
				XCTAssertNil(r.posts![1].talks![0].backlog)
				XCTAssertEqual(r.posts![1].talks![0].suggestion, "About us")
				XCTAssertEqual(r.posts![1].talks![0].updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.posts![1].talks![0].id, 900)
				XCTAssertEqual(r.posts![1].talks![0].createdAt.description, "2014-07-02 03:42:29 +0000")
				XCTAssertEqual(r.posts![1].message, "Oh. What time of the month? The weekend?")
				XCTAssertEqual(r.posts![1].id, 306)
				XCTAssertEqual(r.posts![1].createdAt.description, "2014-07-01 01:32:29 +0000")
				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				//XCTAssertNil(r.directMessage)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "About us")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "About us")
				XCTAssertEqual(r.talk.updatedAt.description, "2014-07-02 03:52:29 +0000")
				XCTAssertEqual(r.talk.id, 900)
				XCTAssertEqual(r.talk.createdAt.description, "2014-07-02 03:42:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testCreateTalk() {
		createStub("create-talk")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(CreateTalk(topicId: 0, talkName: "foo", postIds: [])) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.postIds.count, 2)
				XCTAssertEqual(r.postIds[0], 300)
				XCTAssertEqual(r.postIds[1], 301)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "Feedback new design")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "Feedback new design")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-12-21 10:12:22 +0000")
				XCTAssertEqual(r.talk.id, 902)
				XCTAssertEqual(r.talk.createdAt.description, "2016-12-21 10:12:22 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testUpdateTalk() {
		createStub("update-talk")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(UpdateTalk(topicId: 0, talkId: 1, talkName: "foo")) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "Feedback new site design")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "Feedback new site design")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-12-21 10:12:23 +0000")
				XCTAssertEqual(r.talk.id, 902)
				XCTAssertEqual(r.talk.createdAt.description, "2016-12-21 10:12:22 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testDeleteTalk() {
		createStub("delete-talk")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(DeleteTalk(topicId: 0, talkId: 1)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "Feedback new site design")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "Feedback new site design")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-12-21 10:12:23 +0000")
				XCTAssertEqual(r.talk.id, 902)
				XCTAssertEqual(r.talk.createdAt.description, "2016-12-21 10:12:22 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testAddMessageToTalk() {
		createStub("add-message-to-talk")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(AddMessageToTalk(topicId: 0, talkId: 1, postIds: [])) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.postIds.count, 2)
				XCTAssertEqual(r.postIds[0], 300)
				XCTAssertEqual(r.postIds[1], 301)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "About us")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "About us")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-12-21 10:12:24 +0000")
				XCTAssertEqual(r.talk.id, 900)
				XCTAssertEqual(r.talk.createdAt.description, "2014-07-02 03:42:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}

	func testRemoveMessageFromTalk() {
		createStub("remove-message-from-talk")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(RemoveMessageFromTalk(topicId: 0, talkId: 0, postIds: [])) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.topic.description, "")
				XCTAssertEqual(r.topic.lastPostedAt!.description, "2016-12-21 10:12:02 +0000")
				XCTAssertEqual(r.topic.name, "IT Peeps")
				XCTAssertEqual(r.topic.suggestion, "IT Peeps")
				XCTAssertEqual(r.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.id, 208)
				XCTAssertEqual(r.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
				XCTAssertEqual(r.topic.isDirectMessage, false)
				XCTAssertEqual(r.postIds.count, 2)
				XCTAssertEqual(r.postIds[0], 300)
				XCTAssertEqual(r.postIds[1], 301)
				XCTAssertEqual(r.talk.topicId, 208)
				XCTAssertEqual(r.talk.name, "About us")
				XCTAssertNil(r.talk.backlog)
				XCTAssertEqual(r.talk.suggestion, "About us")
				XCTAssertEqual(r.talk.updatedAt.description, "2016-12-21 10:12:25 +0000")
				XCTAssertEqual(r.talk.id, 900)
				XCTAssertEqual(r.talk.createdAt.description, "2014-07-02 03:42:29 +0000")

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetReceivedLikes() {
        createStub("get-received-likes")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetReceivedLikes(spaceKey: "")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.likedPosts.count, 2)
                XCTAssertEqual(r.likedPosts[0].topic!.description, "")
                XCTAssertEqual(r.likedPosts[0].topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.name, "Techies")
                XCTAssertEqual(r.likedPosts[0].topic!.suggestion, "Techies")
                XCTAssertEqual(r.likedPosts[0].topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.id, 203)
                XCTAssertEqual(r.likedPosts[0].topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.isDirectMessage, false)
                XCTAssertEqual(r.likedPosts[0].post!.topicId, 203)
                XCTAssertEqual(r.likedPosts[0].post!.account.name, "moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
                XCTAssertEqual(r.likedPosts[0].post!.account.isBot, false)
                XCTAssertEqual(r.likedPosts[0].post!.account.suggestion, "Moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.account.fullName, "Moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.id, 102)
                XCTAssertEqual(r.likedPosts[0].post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.attachments!.count, 0)
                XCTAssertEqual(r.likedPosts[0].post!.links!.count, 0)
                XCTAssertNil(r.likedPosts[0].post!.replyTo)
                XCTAssertEqual(r.likedPosts[0].post!.likes!.count, 1)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].comment, "")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].topicId, 203)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.name, "jessica")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.isBot, false)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.id, 100)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].postId, 309)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].id, 605)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].createdAt!.description, "2016-12-21 10:12:06 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.talks!.count, 0)
                XCTAssertEqual(r.likedPosts[0].post!.message, "@jessica Help me!")
                XCTAssertEqual(r.likedPosts[0].post!.id, 309)
                XCTAssertEqual(r.likedPosts[0].post!.createdAt.description, "2014-07-02 03:32:29 +0000")
                XCTAssertNil(r.likedPosts[0].directMessage)
                XCTAssertEqual(r.likedPosts[1].topic!.description, "")
                XCTAssertEqual(r.likedPosts[1].topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.name, "Arts & Crafts Club")
                XCTAssertEqual(r.likedPosts[1].topic!.suggestion, "Arts & Crafts Club")
                XCTAssertEqual(r.likedPosts[1].topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.id, 202)
                XCTAssertEqual(r.likedPosts[1].topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.isDirectMessage, false)
                XCTAssertEqual(r.likedPosts[1].post!.topicId, 202)
                XCTAssertEqual(r.likedPosts[1].post!.account.name, "ahorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
                XCTAssertEqual(r.likedPosts[1].post!.account.isBot, false)
                XCTAssertEqual(r.likedPosts[1].post!.account.suggestion, "AHorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.account.fullName, "AHorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.id, 101)
                XCTAssertEqual(r.likedPosts[1].post!.account.createdAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.attachments!.count, 0)
                XCTAssertEqual(r.likedPosts[1].post!.links!.count, 0)
                XCTAssertNil(r.likedPosts[1].post!.replyTo)
                XCTAssertEqual(r.likedPosts[1].post!.likes!.count, 1)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].comment, "")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].topicId, 202)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.name, "jessica")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.isBot, false)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.id, 100)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].postId, 308)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].id, 604)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].createdAt!.description, "2016-12-21 10:12:06 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.updatedAt.description, "2014-07-01 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.talks!.count, 0)
                XCTAssertEqual(r.likedPosts[1].post!.message, "@jessica What do you think about this?")
                XCTAssertEqual(r.likedPosts[1].post!.id, 308)
                XCTAssertEqual(r.likedPosts[1].post!.createdAt.description, "2014-07-01 03:32:29 +0000")
                XCTAssertNil(r.likedPosts[1].directMessage)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testGetGivenLikes() {
        createStub("get-given-likes")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(GetGivenLikes(spaceKey: "")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.likedPosts.count, 2)
                XCTAssertEqual(r.likedPosts[0].topic!.description, "")
                XCTAssertEqual(r.likedPosts[0].topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.name, "Techies")
                XCTAssertEqual(r.likedPosts[0].topic!.suggestion, "Techies")
                XCTAssertEqual(r.likedPosts[0].topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.id, 203)
                XCTAssertEqual(r.likedPosts[0].topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.isDirectMessage, false)
                XCTAssertEqual(r.likedPosts[0].post!.topicId, 203)
                XCTAssertEqual(r.likedPosts[0].post!.account.name, "moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
                XCTAssertEqual(r.likedPosts[0].post!.account.isBot, false)
                XCTAssertEqual(r.likedPosts[0].post!.account.suggestion, "Moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.account.fullName, "Moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.id, 102)
                XCTAssertEqual(r.likedPosts[0].post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.attachments!.count, 0)
                XCTAssertEqual(r.likedPosts[0].post!.links!.count, 0)
                XCTAssertNil(r.likedPosts[0].post!.replyTo)
                XCTAssertEqual(r.likedPosts[0].post!.likes!.count, 1)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].comment, "")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].topicId, 203)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.name, "jessica")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.isBot, false)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.id, 100)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].postId, 309)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].id, 605)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].createdAt!.description, "2016-12-21 10:12:06 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.talks!.count, 0)
                XCTAssertEqual(r.likedPosts[0].post!.message, "@jessica Help me!")
                XCTAssertEqual(r.likedPosts[0].post!.id, 309)
                XCTAssertEqual(r.likedPosts[0].post!.createdAt.description, "2014-07-02 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].myLike.comment, "")
                XCTAssertEqual(r.likedPosts[0].myLike.id, 605)
                XCTAssertEqual(r.likedPosts[0].myLike.createdAt.description, "2016-12-21 10:12:06 +0000")
                XCTAssertNil(r.likedPosts[0].directMessage)
                XCTAssertEqual(r.likedPosts[1].topic!.description, "")
                XCTAssertEqual(r.likedPosts[1].topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.name, "Arts & Crafts Club")
                XCTAssertEqual(r.likedPosts[1].topic!.suggestion, "Arts & Crafts Club")
                XCTAssertEqual(r.likedPosts[1].topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.id, 202)
                XCTAssertEqual(r.likedPosts[1].topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.isDirectMessage, false)
                XCTAssertEqual(r.likedPosts[1].post!.topicId, 202)
                XCTAssertEqual(r.likedPosts[1].post!.account.name, "ahorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
                XCTAssertEqual(r.likedPosts[1].post!.account.isBot, false)
                XCTAssertEqual(r.likedPosts[1].post!.account.suggestion, "AHorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.account.fullName, "AHorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.id, 101)
                XCTAssertEqual(r.likedPosts[1].post!.account.createdAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.attachments!.count, 0)
                XCTAssertEqual(r.likedPosts[1].post!.links!.count, 0)
                XCTAssertNil(r.likedPosts[1].post!.replyTo)
                XCTAssertEqual(r.likedPosts[1].post!.likes!.count, 1)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].comment, "")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].topicId, 202)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.name, "jessica")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.isBot, false)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.id, 100)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].postId, 308)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].id, 604)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].createdAt!.description, "2016-12-21 10:12:06 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.updatedAt.description, "2014-07-01 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.talks!.count, 0)
                XCTAssertEqual(r.likedPosts[1].post!.message, "@jessica What do you think about this?")
                XCTAssertEqual(r.likedPosts[1].post!.id, 308)
                XCTAssertEqual(r.likedPosts[1].post!.createdAt.description, "2014-07-01 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].myLike.comment, "")
                XCTAssertEqual(r.likedPosts[1].myLike.id, 604)
                XCTAssertEqual(r.likedPosts[1].myLike.createdAt.description, "2016-12-21 10:12:06 +0000")
                XCTAssertNil(r.likedPosts[1].directMessage)
				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testDiscoverLikes() {
        createStub("discover-likes")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(DiscoverLikes(spaceKey: "")) { result in
			switch result {
			case .success(let r):

                XCTAssertEqual(r.likedPosts.count, 2)
                XCTAssertEqual(r.likedPosts[0].topic!.name, "Techies")
                XCTAssertEqual(r.likedPosts[0].topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.suggestion, "Techies")
                XCTAssertEqual(r.likedPosts[0].topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.id, 203)
                XCTAssertEqual(r.likedPosts[0].topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].topic!.isDirectMessage, false)
                XCTAssertEqual(r.likedPosts[0].post!.topicId, 203)
                XCTAssertEqual(r.likedPosts[0].post!.account.name, "moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/102/profile_image.png?t=1403749949000")
                XCTAssertEqual(r.likedPosts[0].post!.account.isBot, false)
                XCTAssertEqual(r.likedPosts[0].post!.account.suggestion, "Moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.account.fullName, "Moss")
                XCTAssertEqual(r.likedPosts[0].post!.account.id, 102)
                XCTAssertEqual(r.likedPosts[0].post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.attachments!.count, 0)
                XCTAssertEqual(r.likedPosts[0].post!.links!.count, 0)
                XCTAssertNil(r.likedPosts[0].post!.replyTo)
                XCTAssertEqual(r.likedPosts[0].post!.likes!.count, 1)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].comment, "")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].topicId, 203)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.name, "jessica")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.isBot, false)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.id, 100)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].postId, 309)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].id, 605)
                XCTAssertEqual(r.likedPosts[0].post!.likes![0].createdAt!.description, "2016-12-21 10:12:06 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[0].post!.talks!.count, 0)
                XCTAssertEqual(r.likedPosts[0].post!.message, "@jessica Help me!")
                XCTAssertEqual(r.likedPosts[0].post!.id, 309)
                XCTAssertEqual(r.likedPosts[0].post!.createdAt.description, "2014-07-02 03:32:29 +0000")
                XCTAssertNil(r.likedPosts[0].directMessage)
                XCTAssertEqual(r.likedPosts[1].topic!.description, "")
                XCTAssertEqual(r.likedPosts[1].topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.name, "Arts & Crafts Club")
                XCTAssertEqual(r.likedPosts[1].topic!.suggestion, "Arts & Crafts Club")
                XCTAssertEqual(r.likedPosts[1].topic!.updatedAt.description, "2014-06-04 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.id, 202)
                XCTAssertEqual(r.likedPosts[1].topic!.createdAt.description, "2014-06-04 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].topic!.isDirectMessage, false)
                XCTAssertEqual(r.likedPosts[1].post!.topicId, 202)
                XCTAssertEqual(r.likedPosts[1].post!.account.name, "ahorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.imageUrl.absoluteString, "https://typetalk.com/accounts/101/profile_image.png?t=1403663549000")
                XCTAssertEqual(r.likedPosts[1].post!.account.isBot, false)
                XCTAssertEqual(r.likedPosts[1].post!.account.suggestion, "AHorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.updatedAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.account.fullName, "AHorowitz")
                XCTAssertEqual(r.likedPosts[1].post!.account.id, 101)
                XCTAssertEqual(r.likedPosts[1].post!.account.createdAt.description, "2014-06-25 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.attachments!.count, 0)
                XCTAssertEqual(r.likedPosts[1].post!.links!.count, 0)
                XCTAssertNil(r.likedPosts[1].post!.replyTo)
                XCTAssertEqual(r.likedPosts[1].post!.likes!.count, 1)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].comment, "")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].topicId, 202)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.name, "jessica")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.imageUrl.absoluteString, "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.isBot, false)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.id, 100)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].postId, 308)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].id, 604)
                XCTAssertEqual(r.likedPosts[1].post!.likes![0].createdAt!.description, "2016-12-21 10:12:06 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.updatedAt.description, "2014-07-01 03:32:29 +0000")
                XCTAssertEqual(r.likedPosts[1].post!.talks!.count, 0)
                XCTAssertEqual(r.likedPosts[1].post!.message, "@jessica What do you think about this?")
                XCTAssertEqual(r.likedPosts[1].post!.id, 308)
                XCTAssertEqual(r.likedPosts[1].post!.createdAt.description, "2014-07-01 03:32:29 +0000")
                XCTAssertNil(r.likedPosts[1].directMessage)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}


	func testSaveReadLikes() {
		createStub("save-read-likes")

		let expectation = self.expectation(description: "")
		TypetalkAPI.send(SaveReadLikes(spaceKey: "", likeId: 0)) { result in
			switch result {
			case .success(let r):

				XCTAssertEqual(r.like.receive!.readLikeId, 605)
				XCTAssertEqual(r.like.receive!.hasUnread, false)

				expectation.fulfill()
			case .failure(let error):
				XCTFail("\(error)")
			}
		}

		waitForExpectations(timeout: 3) { (error) in
			XCTAssertNil(error, error.debugDescription)
		}
	}



    func testCreateTopicGroup() {
        createStub("create-topic-group")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(CreateTopicGroup(spaceKey: "", name: "foo")) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroup.id, 1724)
                XCTAssertEqual(r.myTopicGroup.name, "Design Project")
                XCTAssertEqual(r.myTopics.myTopic.topicId, 4483)
                XCTAssertEqual(r.myTopics.myTopic.kind, "grouped")
                XCTAssertEqual(r.myTopics.myTopic.exTopicGroupId, 1720)
                XCTAssertEqual(r.myTopics.myTopic.topicGroupId, 1724)
                XCTAssertEqual(r.myTopics.myTopic.updatedAt.description, "2018-10-29 02:44:14 +0000")
                XCTAssertEqual(r.myTopics.myTopic.orderNo, 0)
                XCTAssertEqual(r.myTopics.myTopic.id, 8762)
                XCTAssertEqual(r.myTopics.myTopic.createdAt.description, "2018-09-25 09:42:49 +0000")
                XCTAssertEqual(r.myTopics.myTopic.accountId, 2500)

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }


    func testUpdateTopicGroup() {
        createStub("update-topic-group")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(UpdateTopicGroup(spaceKey: "", myTopicGroupId: 0, name: "foo", sortType: .recent, isMuted: false)) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.myTopicGroup.isMuted, true)
                XCTAssertEqual(r.myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroup.id, 1656)
                XCTAssertEqual(r.myTopicGroup.name, "Awesome topic group")

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }


    func testDeleteTopicGroup() {
        createStub("delete-topic-group")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(DeleteTopicGroup(spaceKey: "", myTopicGroupId: 0)) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroup.id, 1655)
                XCTAssertEqual(r.myTopicGroup.name, "Awesome Topic Group")

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }


    func testGetMyTopics() {
        createStub("get-my-topics")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(GetMyTopics(spaceKey: "")) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.pinnedTopics.count, 1)
                XCTAssertEqual(r.pinnedTopics[0].topic.name, "Design")
                XCTAssertEqual(r.pinnedTopics[0].topic.lastPostedAt!.description, "2018-09-25 04:42:47 +0000")
                XCTAssertEqual(r.pinnedTopics[0].topic.suggestion, "Design")
                XCTAssertEqual(r.pinnedTopics[0].topic.updatedAt.description, "2018-09-19 06:02:29 +0000")
                XCTAssertEqual(r.pinnedTopics[0].topic.id, 4483)
                XCTAssertEqual(r.pinnedTopics[0].topic.createdAt.description, "2017-03-21 20:04:45 +0000")
                XCTAssertEqual(r.pinnedTopics[0].topic.isDirectMessage, false)
                XCTAssertEqual(r.pinnedTopics[0].exTopicGroupId, 1642)
                XCTAssertEqual(r.pinnedTopics[0].unread.count, 0)
                XCTAssertEqual(r.pinnedTopics[0].unread.topicId, 4483)
                XCTAssertEqual(r.pinnedTopics[0].unread.postId, 167373)
                XCTAssertEqual(r.pinnedTopics[0].unread.isOverCountLimit, false)
                XCTAssertEqual(r.pinnedTopics[0].createdAt.description, "2018-09-25 09:42:49 +0000")
                XCTAssertEqual(r.favoritesOnboarding, false)
                XCTAssertEqual(r.myTopicGroups.count, 5)
                XCTAssertEqual(r.myTopicGroups[0].myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroups[0].myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroups[0].myTopicGroup.id, 1638)
                XCTAssertEqual(r.myTopicGroups[0].myTopicGroup.name, "Important")
                XCTAssertEqual(r.myTopicGroups[0].myTopics.count, 0)
                XCTAssertEqual(r.myTopicGroups[1].myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroups[1].myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroups[1].myTopicGroup.id, 1639)
                XCTAssertEqual(r.myTopicGroups[1].myTopicGroup.name, "Marketing")
                XCTAssertEqual(r.myTopicGroups[1].myTopics.count, 0)
                XCTAssertEqual(r.myTopicGroups[2].myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroups[2].myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroups[2].myTopicGroup.id, 1642)
                XCTAssertEqual(r.myTopicGroups[2].myTopicGroup.name, "Design")
                XCTAssertEqual(r.myTopicGroups[2].myTopics.count, 5)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.name, "Visual Design")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.lastPostedAt!.description, "2018-09-28 10:46:10 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.suggestion, "Visual Design")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.updatedAt.description, "2018-09-10 02:21:46 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.id, 6196)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.createdAt.description, "2018-09-10 02:21:46 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].topic.isDirectMessage, false)
                XCTAssertNil(r.myTopicGroups[2].myTopics[0].exTopicGroupId)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].unread.count, 0)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].unread.topicId, 6196)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].unread.postId, 167418)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].unread.isOverCountLimit, false)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[0].createdAt.description, "2018-09-19 05:02:16 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].topic.name, "Announcements for Designers")
                XCTAssertNil(r.myTopicGroups[2].myTopics[1].topic.lastPostedAt)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].topic.suggestion, "Announcements for Designers")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].topic.updatedAt.description, "2018-09-10 02:24:16 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].topic.id, 6199)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].topic.createdAt.description, "2018-09-10 02:24:16 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].topic.isDirectMessage, false)
                XCTAssertNil(r.myTopicGroups[2].myTopics[1].exTopicGroupId)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].unread.count, 0)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].unread.topicId, 6199)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].unread.postId, 167206)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].unread.isOverCountLimit, false)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[1].createdAt.description, "2018-09-19 05:02:30 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].topic.name, "UX Team")
                XCTAssertNil(r.myTopicGroups[2].myTopics[2].topic.lastPostedAt)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].topic.suggestion, "UX Team")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].topic.updatedAt.description, "2018-09-10 02:23:40 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].topic.id, 6198)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].topic.createdAt.description, "2018-09-10 02:23:40 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].topic.isDirectMessage, false)
                XCTAssertNil(r.myTopicGroups[2].myTopics[2].exTopicGroupId)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].unread.count, 0)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].unread.topicId, 6198)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].unread.postId, 167206)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].unread.isOverCountLimit, false)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[2].createdAt.description, "2018-09-19 05:02:40 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].topic.name, "Mondrian Website")
                XCTAssertNil(r.myTopicGroups[2].myTopics[3].topic.lastPostedAt)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].topic.suggestion, "Mondrian Website")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].topic.updatedAt.description, "2018-09-10 02:22:35 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].topic.id, 6197)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].topic.createdAt.description, "2018-09-10 02:22:35 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].topic.isDirectMessage, false)
                XCTAssertNil(r.myTopicGroups[2].myTopics[3].exTopicGroupId)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].unread.count, 0)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].unread.topicId, 6197)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].unread.postId, 167206)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].unread.isOverCountLimit, false)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[3].createdAt.description, "2018-09-19 05:03:23 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].topic.name, "Designers")
                XCTAssertNil(r.myTopicGroups[2].myTopics[4].topic.lastPostedAt)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].topic.suggestion, "Designers")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].topic.updatedAt.description, "2018-09-10 02:21:20 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].topic.id, 6195)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].topic.createdAt.description, "2018-09-10 02:21:20 +0000")
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].topic.isDirectMessage, false)
                XCTAssertNil(r.myTopicGroups[2].myTopics[4].exTopicGroupId)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].unread.count, 0)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].unread.topicId, 6195)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].unread.postId, 167206)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].unread.isOverCountLimit, false)
                XCTAssertEqual(r.myTopicGroups[2].myTopics[4].createdAt.description, "2018-09-19 05:02:32 +0000")
                XCTAssertEqual(r.myTopicGroups[3].myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroups[3].myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroups[3].myTopicGroup.id, 1640)
                XCTAssertEqual(r.myTopicGroups[3].myTopicGroup.name, "After Work")
                XCTAssertEqual(r.myTopicGroups[3].myTopics.count, 0)
                XCTAssertEqual(r.myTopicGroups[4].myTopicGroup.isMuted, false)
                XCTAssertEqual(r.myTopicGroups[4].myTopicGroup.sortType, .recent)
                XCTAssertEqual(r.myTopicGroups[4].myTopicGroup.id, 1641)
                XCTAssertEqual(r.myTopicGroups[4].myTopicGroup.name, "Apps")
                XCTAssertEqual(r.myTopicGroups[4].myTopics.count, 0)
                XCTAssertEqual(r.joinedTopics.count, 1)
                XCTAssertEqual(r.joinedTopics[0].topic.name, "New project")
                XCTAssertNil(r.joinedTopics[0].topic.lastPostedAt)
                XCTAssertEqual(r.joinedTopics[0].topic.suggestion, "New project")
                XCTAssertEqual(r.joinedTopics[0].topic.updatedAt.description, "2018-11-09 00:35:59 +0000")
                XCTAssertEqual(r.joinedTopics[0].topic.id, 6931)
                XCTAssertEqual(r.joinedTopics[0].topic.createdAt.description, "2018-11-09 00:35:59 +0000")
                XCTAssertEqual(r.joinedTopics[0].topic.isDirectMessage, false)
                XCTAssertNil(r.joinedTopics[0].exTopicGroupId)
                XCTAssertEqual(r.joinedTopics[0].unread.count, 0)
                XCTAssertEqual(r.joinedTopics[0].unread.topicId, 6931)
                XCTAssertEqual(r.joinedTopics[0].unread.postId, 168021)
                XCTAssertEqual(r.joinedTopics[0].unread.isOverCountLimit, false)
                XCTAssertEqual(r.joinedTopics[0].createdAt.description, "2018-11-09 00:35:59 +0000")

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }


    func testAddTopicToGroup() {
        createStub("add-topic-to-group")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(AddTopicToGroup(spaceKey: "", myTopicGroupId: 0, topicId: 0)) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.myTopic.topicId, 4483)
                XCTAssertEqual(r.myTopic.kind, "grouped")
                XCTAssertEqual(r.myTopic.exTopicGroupId, 1640)
                XCTAssertEqual(r.myTopic.topicGroupId, 1642)
                XCTAssertEqual(r.myTopic.updatedAt.description, "2018-11-09 00:35:39 +0000")
                XCTAssertEqual(r.myTopic.orderNo, 0)
                XCTAssertEqual(r.myTopic.id, 8762)
                XCTAssertEqual(r.myTopic.createdAt.description, "2018-09-25 09:42:49 +0000")
                XCTAssertEqual(r.myTopic.accountId, 2500)

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }


    func testDeleteMyTopic() {
        createStub("delete-my-topic")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(DeleteMyTopic(spaceKey: "", topicId: 0)) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.myTopic.topicId, 3538)
                XCTAssertEqual(r.myTopic.kind, "grouped")
                XCTAssertEqual(r.myTopic.topicGroupId, 1639)
                XCTAssertEqual(r.myTopic.updatedAt.description, "2018-09-21 02:23:11 +0000")
                XCTAssertEqual(r.myTopic.orderNo, 0)
                XCTAssertEqual(r.myTopic.id, 8759)
                XCTAssertEqual(r.myTopic.createdAt.description, "2018-09-21 02:23:11 +0000")
                XCTAssertEqual(r.myTopic.accountId, 2500)

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }


    func testPinTopic() {
        createStub("pin-topic")

        let expectation = self.expectation(description: "")
        TypetalkAPI.send(PinTopic(spaceKey: "", topicId: 0)) { result in
            switch result {
            case .success(let r):

                XCTAssertEqual(r.pinnedTopics.count, 1)
                XCTAssertEqual(r.pinnedTopics[0].myTopic.topicId, 3562)
                XCTAssertEqual(r.pinnedTopics[0].myTopic.kind, "pinned")
                XCTAssertEqual(r.pinnedTopics[0].myTopic.exTopicGroupId, 1702)
                XCTAssertNil(r.pinnedTopics[0].myTopic.topicGroupId)
                XCTAssertEqual(r.pinnedTopics[0].myTopic.updatedAt.description, "2018-11-09 01:02:39 +0000")
                XCTAssertEqual(r.pinnedTopics[0].myTopic.orderNo, 1)
                XCTAssertEqual(r.pinnedTopics[0].myTopic.id, 13138)
                XCTAssertEqual(r.pinnedTopics[0].myTopic.createdAt.description, "2018-11-09 01:02:39 +0000")
                XCTAssertEqual(r.pinnedTopics[0].myTopic.accountId, 2488)

                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }

        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }

}
