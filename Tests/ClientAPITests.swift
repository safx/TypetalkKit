//
//  ClientAPITests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/12.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest
import Alamofire
import TypetalkKit



class ClientAPITests: XCTestCase {
    // Direct creating a test client here causes to compilation error.
    var client: Client = Client.sharedClient
    
    override func setUp() {
        super.setUp()

        client = Client { (router) -> NSURLRequest in
            return router.URLRequestForTests
        }
    }

    func testGetProfile() {
        let expectation = expectationWithDescription("")
        
        client.getProfile { (response, error) -> Void in
            if let account = response {
                XCTAssertEqual(account.id, 100)
                XCTAssertEqual(account.name, "jessica")
                XCTAssertEqual(account.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(account.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(account.imageUrl.absoluteString!, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(account.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(account.updatedAt.description, "2014-06-24 02:32:29 +0000")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetTopics() {
        let expectation = expectationWithDescription("")
        
        client.getTopics { (response, error) -> Void in
            if let topics = response {
                let last = topics[8]
                XCTAssertEqual(last.topic!.id, 206)
                XCTAssertEqual(last.topic!.name, "VisualDesigners")
                XCTAssertEqual(last.topic!.suggestion, "VisualDesigners")
                XCTAssertEqual(last.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(last.topic!.createdAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertEqual(last.topic!.updatedAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertFalse(last.favorite)
                XCTAssertNil(last.unread)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetMessages() {
        let expectation = expectationWithDescription("")
        
        client.getMessages(0) { (response, error) -> Void in
            if let messages = response {
                let last = messages.posts[7]
                XCTAssertEqual(last.id, 307)
                XCTAssertEqual(last.topicId, 208)
                XCTAssertEqual(last.replyTo!, 306)
                XCTAssertEqual(last.message, "Hope it doesn't sound arrogant but I'm the greatest man in the world!")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testPostMessage() {
        let expectation = expectationWithDescription("")
        
        client.postMessage(0, message: "", replyTo: 0, fileKeys: [], talkIds: []) { (response, error) -> Void in
            if let res = response {
                let topic = res.topic!
                let post = res.post!
                XCTAssertEqual(topic.id, 208)
                XCTAssertEqual(topic.name, "IT Peeps")
                XCTAssertEqual(topic.suggestion, "IT Peeps")
                
                XCTAssertEqual(post.id, 333)
                XCTAssertNil(post.replyTo)
                XCTAssertNil(post.mention)
                XCTAssertEqual(post.message, "Let's party like it's 1999!")
                XCTAssertTrue(post.attachments.isEmpty)
                XCTAssertTrue(post.likes.isEmpty)
                XCTAssertTrue(post.talks.isEmpty)
                XCTAssertTrue(post.links.isEmpty)
                
                XCTAssertEqual(post.account!.id, 100)
                XCTAssertEqual(post.account!.name, "jessica")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testUploadAttachment() {
        let expectation = expectationWithDescription("")
        
        client.uploadAttachment(0, fileName: "", fileContent: NSData()) { (response, error) -> Void in
            if let attachment = response {
                XCTAssertEqual(attachment.fileKey, "0569fedc62f37e48779ee285fe04f0ff4057e0d0")
                XCTAssertEqual(attachment.fileName, "sample.jpg")
                XCTAssertEqual(attachment.fileSize, 472263)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetTopicMembers() {
        let expectation = expectationWithDescription("")
        
        client.getTopicMembers(0) { (response, error) -> Void in
            if let res = response {
                XCTAssertEqual(res.pendings.count, 1)
                
                let last = res.accounts[5]
                XCTAssertEqual(last.account!.id, 103)
                XCTAssertEqual(last.account!.name, "stefhull")
                XCTAssertEqual(last.account!.fullName, "StefHull")
                XCTAssertEqual(last.account!.suggestion, "StefHull")
                XCTAssertEqual(last.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
                XCTAssertEqual(last.account!.createdAt.description, "2014-06-27 02:32:29 +0000")
                XCTAssertEqual(last.online, false)
                
                XCTAssertEqual(res.pendings.count, 1)
                
                let pending = res.pendings[0]
                XCTAssertEqual(pending.account!.id, 106)
                XCTAssertEqual(pending.account!.name, "chelseab")
                XCTAssertEqual(pending.account!.fullName, "ChelseaB")
                XCTAssertEqual(pending.account!.suggestion, "ChelseaB")
                XCTAssertEqual(pending.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
                XCTAssertEqual(pending.account!.createdAt.description, "2014-06-30 02:32:29 +0000")
                XCTAssertNil(pending.mailAddress)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetMessage() {
        let expectation = expectationWithDescription("")
        
        client.getMessage(0, postId: 0) { (response, error) -> Void in
            if let message = response {
                XCTAssertEqual(message.team!.id, 700)
                XCTAssertEqual(message.team!.name, "Nulab Inc.")
                XCTAssertEqual(message.team!.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
                XCTAssertEqual(message.team!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(message.team!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                XCTAssertEqual(message.topic!.id, 208)
                XCTAssertEqual(message.topic!.name, "IT Peeps")
                XCTAssertEqual(message.topic!.suggestion, "IT Peeps")
                XCTAssertEqual(message.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(message.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(message.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                XCTAssertEqual(message.post!.id, 307)
                XCTAssertEqual(message.post!.topicId, 208)
                XCTAssertEqual(message.post!.replyTo!, 306)
                XCTAssertEqual(countElements(message.post!.likes), 1)
                
                XCTAssertEqual(countElements(message.replies), 2)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testDeleteMessage() {
        let expectation = expectationWithDescription("")
        
        client.deleteMessage(0, postId: 0) { (response, error) -> Void in
            if let post = response {
                XCTAssertEqual(post.id, 333)
                XCTAssertNil(post.replyTo)
                XCTAssertNil(post.mention)
                XCTAssertEqual(post.message, "Let's party like it's 1999!")
                XCTAssertTrue(post.attachments.isEmpty)
                XCTAssertEqual(post.account!.id, 100)
                XCTAssertEqual(post.account!.name, "jessica")
                XCTAssertEqual(countElements(post.attachments), 0)
                XCTAssertTrue(post.likes.isEmpty)
                XCTAssertTrue(post.talks.isEmpty)
                XCTAssertTrue(post.links.isEmpty)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testLikeMessage() {
        let expectation = expectationWithDescription("")
        
        client.likeMessage(0, postId: 0) { (response, error) -> Void in
            if let post = response {
                XCTAssertEqual(post.id, 604)
                XCTAssertEqual(post.postId, 305)
                XCTAssertEqual(post.topicId, 208)
                XCTAssertEqual(post.comment!, "")
                XCTAssertEqual(post.account!.id, 100)
                XCTAssertEqual(post.account!.name, "jessica")
                XCTAssertEqual(post.account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(post.account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(post.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(post.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(post.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testUnlikeMessage() {
        let expectation = expectationWithDescription("")
        
        client.unlikeMessage(0, postId: 0) { (response, error) -> Void in
            if let post = response {
                XCTAssertEqual(post.id, 604)
                XCTAssertEqual(post.postId, 305)
                XCTAssertEqual(post.topicId, 208)
                XCTAssertEqual(post.comment!, "")
                XCTAssertEqual(post.account!.id, 100)
                XCTAssertEqual(post.account!.name, "jessica")
                XCTAssertEqual(post.account!.fullName, "Jessica Fitzherbert")
                XCTAssertEqual(post.account!.suggestion, "Jessica Fitzherbert")
                XCTAssertEqual(post.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
                XCTAssertEqual(post.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
                XCTAssertEqual(post.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testFavoriteTopic() {
        let expectation = expectationWithDescription("")
        
        client.favoriteTopic(0) { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 206)
                XCTAssertEqual(topic.topic!.name, "VisualDesigners")
                XCTAssertEqual(topic.topic!.suggestion, "VisualDesigners")
                XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-08 02:32:29 +0000")
                
                XCTAssertTrue(topic.favorite)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testUnfavoriteTopic() {
        let expectation = expectationWithDescription("")
        
        client.unfavoriteTopic(0) { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 206)
                XCTAssertEqual(topic.topic!.name, "VisualDesigners")
                XCTAssertEqual(topic.topic!.suggestion, "VisualDesigners")
                XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-08 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-08 02:32:29 +0000")
                
                XCTAssertFalse(topic.favorite)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetNotifications() {
        let expectation = expectationWithDescription("")
        
        client.getNotifications { (response, error) -> Void in
            if let notifications = response {
                XCTAssertEqual(countElements(notifications.mentions), 2)
                let mention = notifications.mentions[1]
                XCTAssertEqual(mention.id, 500)
                XCTAssertEqual(mention.readAt!.description, "2014-06-30 15:00:00 +0000")
                XCTAssertEqual(mention.post!.id, 308)
                XCTAssertEqual(mention.post!.topicId, 202)
                XCTAssertEqual(mention.post!.topic!.id, 202)
                XCTAssertEqual(mention.post!.topic!.name, "Arts & Crafts Club")
                XCTAssertNil(mention.post!.replyTo)
                XCTAssertEqual(mention.post!.message, "@jessica What do you think about this?")
                XCTAssertEqual(mention.post!.account!.id, 101)
                XCTAssertEqual(mention.post!.account!.name, "ahorowitz")
                
                XCTAssertEqual(countElements(notifications.teamInvites), 2)
                let team = notifications.teamInvites[1]
                XCTAssertEqual(team.id, 800)
                XCTAssertEqual(team.team!.id, 702)
                XCTAssertEqual(team.team!.name, "Cycling team")
                XCTAssertEqual(team.sender!.id, 106)
                XCTAssertEqual(team.sender!.name, "chelseab")
                XCTAssertEqual(team.account!.id, 100)
                XCTAssertEqual(team.account!.name, "jessica")
                
                XCTAssertEqual(countElements(notifications.topicInvites), 2)
                let topic = notifications.topicInvites[1]
                XCTAssertEqual(topic.id, 600)
                XCTAssertEqual(topic.topic!.id, 209)
                XCTAssertEqual(topic.topic!.name, "Web Site")
                XCTAssertEqual(topic.sender!.id, 106)
                XCTAssertEqual(topic.sender!.name, "chelseab")
                XCTAssertEqual(topic.account!.id, 100)
                XCTAssertEqual(topic.account!.name, "jessica")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetNotificationStatus() {
        let expectation = expectationWithDescription("")
        
        client.getNotificationStatus { (response, error) -> Void in
            if let status = response {
                XCTAssertEqual(status.unreadMentions!, 1)
                XCTAssertEqual(status.unopenedAccess!, 1)
                XCTAssertEqual(status.pendingTeamInvite!, 2)
                XCTAssertEqual(status.pendingTopicInvite!, 2)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testOpenNotification() {
        let expectation = expectationWithDescription("")
        
        client.openNotification { (response, error) -> Void in
            if let status = response {
                XCTAssertEqual(status.unopenedAccess!, 0)
                XCTAssertNil(status.unreadMentions)
                XCTAssertNil(status.pendingTeamInvite)
                XCTAssertNil(status.pendingTopicInvite)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testSaveReadTopic() {
        let expectation = expectationWithDescription("")
        
        client.saveReadTopic(0, postId: 0) { (response, error) -> Void in
            if let unread = response {
                XCTAssertEqual(unread.topicId, 208)
                XCTAssertEqual(unread.postId, 307)
                XCTAssertEqual(unread.count, 0)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetMentions() {
        let expectation = expectationWithDescription("")
        
        client.getMentions(0, unread: nil) { (response, error) -> Void in
            if let mentions = response {
                XCTAssertEqual(countElements(mentions), 2)
                let mention = mentions[0]
                
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
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSaveReadMention() {
        let expectation = expectationWithDescription("")
        
        client.saveReadMention(0) { (response, error) -> Void in
            if let mention = response {
                XCTAssertEqual(mention.id, 501)
                XCTAssertEqual(mention.post!.id, 309)
                XCTAssertEqual(mention.post!.topicId, 203)
                XCTAssertEqual(mention.readAt!.description, "2014-07-25 03:38:52 +0000")
                XCTAssertEqual(mention.post!.topic!.id, 203)
                XCTAssertEqual(mention.post!.topic!.name, "Techies")
                XCTAssertEqual(mention.post!.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(mention.post!.topic!.createdAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertEqual(mention.post!.topic!.updatedAt.description, "2014-06-05 02:32:29 +0000")
                XCTAssertNil(mention.post!.replyTo)
                XCTAssertEqual(mention.post!.message, "@jessica Help me!")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testAcceptTeamInvite() {
        let expectation = expectationWithDescription("")
        
        client.acceptTeamInvite(0, inviteId: 0) { (response, error) -> Void in
            if let res = response {
                let topics = res.topics
                let invite = res.invite!
                XCTAssertEqual(countElements(topics), 2)
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
                
                XCTAssertEqual(invite.role, "member")
                XCTAssertEqual(invite.message, "Hello. Please join us.")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testDeclineTeamInvite() {
        let expectation = expectationWithDescription("")
        
        client.declineTeamInvite(0, inviteId: 0) { (response, error) -> Void in
            if let invite = response {
                XCTAssertEqual(invite.id, 801)
                XCTAssertEqual(invite.team!.id, 703)
                XCTAssertEqual(invite.team!.name, "WP Team")
                XCTAssertEqual(invite.sender!.id, 105)
                XCTAssertEqual(invite.sender!.name, "brad")
                XCTAssertEqual(invite.account!.id, 100)
                XCTAssertEqual(invite.account!.name, "jessica")
                
                XCTAssertEqual(invite.role, "admin")
                XCTAssertEqual(invite.message, "This team is for new project.")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testAcceptTopicInvite() {
        let expectation = expectationWithDescription("")
        
        client.acceptTopicInvite(0, inviteId: 0) { (response, error) -> Void in
            if let invite = response {
                XCTAssertEqual(invite.id, 600)
                XCTAssertEqual(invite.topic!.id, 209)
                XCTAssertEqual(invite.topic!.name, "Web Site")
                XCTAssertEqual(invite.sender!.id, 106)
                XCTAssertEqual(invite.sender!.name, "chelseab")
                XCTAssertEqual(invite.account!.id, 100)
                XCTAssertEqual(invite.account!.name, "jessica")
                XCTAssertEqual(invite.message, "It is a new project. Join us!")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDeclineTopicInvite() {
        let expectation = expectationWithDescription("")
        
        client.declineTopicInvite(0, inviteId: 0) { (response, error) -> Void in
            if let invite = response {
                XCTAssertEqual(invite.id, 601)
                XCTAssertEqual(invite.topic!.id, 210)
                XCTAssertEqual(invite.topic!.name, "Development")
                XCTAssertEqual(invite.sender!.id, 105)
                XCTAssertEqual(invite.sender!.name, "brad")
                XCTAssertEqual(invite.account!.id, 100)
                XCTAssertEqual(invite.account!.name, "jessica")
                XCTAssertEqual(invite.message, "It is a new project. Join us!")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testCreateTopic() {
        let expectation = expectationWithDescription("")
        
        client.createTopic("", teamId: nil, inviteMembers: [], inviteMessage: "") { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 222)
                XCTAssertEqual(topic.topic!.name, "Test topic")
                XCTAssertEqual(topic.topic!.suggestion, "Test topic")
                XCTAssertNil(topic.topic!.lastPostedAt)
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-07-25 03:38:55 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-07-25 03:38:55 +0000")
                
                XCTAssertEqual(countElements(topic.teams), 1)
                let team = topic.teams[0]
                XCTAssertEqual(team.team!.id, 700)
                XCTAssertEqual(team.team!.name, "Nulab Inc.")
                XCTAssertEqual(team.team!.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
                XCTAssertEqual(team.team!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(team.team!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testUpdateTopic() {
        let expectation = expectationWithDescription("")
        
        client.updateTopic(0, name: "", teamId: nil) { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 222)
                XCTAssertEqual(topic.topic!.name, "Update test topic")
                XCTAssertEqual(topic.topic!.suggestion, "Update test topic")
                XCTAssertNil(topic.topic!.lastPostedAt)
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-07-25 03:38:55 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-07-25 03:38:56 +0000")
                
                XCTAssertEqual(countElements(topic.teams), 0)
                XCTAssertEqual(countElements(topic.accounts), 1)
                XCTAssertEqual(countElements(topic.invites), 2)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testDeleteTopic() {
        let expectation = expectationWithDescription("")
        
        client.deleteTopic(0) { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.id, 222)
                XCTAssertEqual(topic.name, "Update test topic")
                XCTAssertEqual(topic.suggestion, "Update test topic")
                XCTAssertNil(topic.lastPostedAt)
                XCTAssertEqual(topic.createdAt.description, "2014-07-25 03:38:55 +0000")
                XCTAssertEqual(topic.updatedAt.description, "2014-07-25 03:38:56 +0000")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTopicDetails() {
        let expectation = expectationWithDescription("")
        
        client.getTopicDetails(0) { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 208)
                XCTAssertEqual(topic.topic!.name, "IT Peeps")
                XCTAssertEqual(topic.topic!.suggestion, "IT Peeps")
                XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                XCTAssertEqual(countElements(topic.teams), 1)
                XCTAssertEqual(countElements(topic.accounts), 2)
                XCTAssertEqual(countElements(topic.invites), 2)

                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testInviteTopicMember() {
        let expectation = expectationWithDescription("")
        
        client.inviteTopicMember(0, inviteName: [], inviteMessage: "") { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 207)
                XCTAssertEqual(topic.topic!.name, "Art Directors")
                XCTAssertEqual(topic.topic!.suggestion, "Art Directors")
                XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-09 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-09 02:32:29 +0000")
                
                XCTAssertEqual(countElements(topic.teams), 0)
                XCTAssertEqual(countElements(topic.accounts), 1)
                XCTAssertEqual(countElements(topic.invites), 2)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testRemoveTopicMember() {
        let expectation = expectationWithDescription("")
        
        client.removeTopicMember(0, removeInviteIds: [], removeMemberIds: []) { (response, error) -> Void in
            if let topic = response {
                XCTAssertEqual(topic.topic!.id, 208)
                XCTAssertEqual(topic.topic!.name, "IT Peeps")
                XCTAssertEqual(topic.topic!.suggestion, "IT Peeps")
                XCTAssertEqual(topic.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(topic.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(topic.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                XCTAssertEqual(countElements(topic.teams), 1)
                XCTAssertEqual(countElements(topic.accounts), 0)
                XCTAssertEqual(countElements(topic.invites), 0)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetTerms() {
        let expectation = expectationWithDescription("")

        client.getTeams { (response, error) -> Void in
            if let teams = response {
                XCTAssertEqual(countElements(teams), 3)
                let first = teams[0]
                XCTAssertEqual(first.memberCount, 4)
                XCTAssertEqual(first.team!.id, 700)
                XCTAssertEqual(first.team!.name, "Nulab Inc.")
                XCTAssertEqual(first.team!.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
                XCTAssertEqual(first.team!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(first.team!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func testGetFriends() {
        let expectation = expectationWithDescription("")

        client.getFriends { (response, error) -> Void in
            if let accounts = response {
                XCTAssertEqual(countElements(accounts), 5)
                let last = accounts[4]
                XCTAssertEqual(last.id, 103)
                XCTAssertEqual(last.name, "stefhull")
                XCTAssertEqual(last.fullName, "StefHull")
                XCTAssertEqual(last.suggestion, "StefHull")
                XCTAssertEqual(last.imageUrl.absoluteString!, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
                XCTAssertEqual(last.createdAt.description, "2014-06-27 02:32:29 +0000")
                XCTAssertEqual(last.updatedAt.description, "2014-06-27 02:32:29 +0000")

                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testSearchAccounts() {
        let expectation = expectationWithDescription("")
        
        client.searchAccounts("") { (response, error) -> Void in
            if let account = response {
                XCTAssertEqual(account.id, 102)
                XCTAssertEqual(account.name, "moss")
                XCTAssertEqual(account.fullName, "Moss")
                XCTAssertEqual(account.suggestion, "Moss")
                XCTAssertEqual(account.imageUrl.absoluteString!, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
                XCTAssertEqual(account.createdAt.description, "2014-06-26 02:32:29 +0000")
                XCTAssertEqual(account.updatedAt.description, "2014-06-26 02:32:29 +0000")

                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTalks() {
        let expectation = expectationWithDescription("")
        
        client.getTalks(0) { (response, error) -> Void in
            if let talks = response {
                XCTAssertEqual(countElements(talks), 2)
                let last = talks[1]
                XCTAssertEqual(last.id, 900)
                XCTAssertEqual(last.topicId, 208)
                XCTAssertEqual(last.name, "About us")
                XCTAssertEqual(last.suggestion, "About us")
                XCTAssertEqual(last.createdAt.description, "2014-07-02 03:42:29 +0000")
                XCTAssertEqual(last.updatedAt.description, "2014-07-02 03:52:29 +0000")

                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testGetTalk() {
        let expectation = expectationWithDescription("")

        client.getTalk(0, talkId: 0, count: nil, from: nil, direction: nil) { (response, error) -> Void in
            if let talk = response {
                XCTAssertEqual(talk.topic!.id, 208)
                XCTAssertEqual(talk.topic!.name, "IT Peeps")
                XCTAssertEqual(talk.topic!.suggestion, "IT Peeps")
                XCTAssertEqual(talk.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
                XCTAssertEqual(talk.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
                XCTAssertEqual(talk.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")
                
                XCTAssertEqual(talk.talk!.id, 900)
                XCTAssertEqual(talk.talk!.topicId, 208)
                XCTAssertEqual(talk.talk!.name, "About us")
                XCTAssertEqual(talk.talk!.createdAt.description, "2014-07-02 03:42:29 +0000")
                XCTAssertEqual(talk.talk!.updatedAt.description, "2014-07-02 03:52:29 +0000")
                
                XCTAssertEqual(countElements(talk.posts), 2)
                let last = talk.posts[1]
                XCTAssertEqual(last.id, 306)
                XCTAssertEqual(last.topicId, 208)
                XCTAssertEqual(last.replyTo!, 305)
                XCTAssertEqual(last.message, "Oh. What time of the month? The weekend?")
                
                XCTAssertEqual(talk.hasNext, false)
                
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(3) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}

