//
//  RouterTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
import Result
@testable import TypetalkKit

class RouterTests: XCTestCase {

    override func setUp() {
        TypetalkAPI.setDummyAccessTokenForTest()
    }

    func testGetProfile() {
        let req = try! GetProfile().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/profile")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Authorization")!, "Bearer atfoo")
    }

    func testGetFriendProfile() {
        let req = try! GetFriendProfile(accountName: "Foobar").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/accounts/profile/Foobar")
    }

    func testGetOnlineStatus() {
        let req = try! GetOnlineStatus(accountIds: [123, 456]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v1/accounts/status")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("accountIds%5B%5D=123"))
        XCTAssertTrue(q.contains("accountIds%5B%5D=456"))
    }

    func testGetTopics() {
        let req = try! GetTopics(spaceKey: "foo").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v2/topics?spaceKey=foo")
    }

    func testDmGetTopics() {
        let req = try! GetDmTopics().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/messages")
    }
    func testGetMessages() {
        let req = try! GetMessages(topicId: 312).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/312")
    }
    func testGetMessages2() {
        let req = try! GetMessages(topicId: 312, count: 98).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/312?count=98")
    }
    func testGetMessages3() {
        let req = try! GetMessages(topicId: 312, from: 178).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/312?from=178")
    }
    func testGetMessages4() {
        let req = try! GetMessages(topicId: 312, direction: .backward).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/312?direction=backward")
    }

    func testPostMessages() {
        let req = try! PostMessage(topicId: 758, message: "It's a test message!", replyTo: nil, fileKeys: [], talkIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/758")
    }
    func testPostMessages2() {
        let req = try! PostMessage(topicId: 38, message: "XYZ", replyTo: 987, fileKeys: [], talkIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/38")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("message=XYZ"))
        XCTAssertTrue(q.contains("replyTo=987"))
    }
    func testPostMessages3() {
        let req = try! PostMessage(topicId: 38, message: "XYZ", replyTo: nil, fileKeys: ["ABCDEF"], talkIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/38")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("message=XYZ"))
        XCTAssertTrue(q.contains("fileKeys%5B%5D=ABCDEF"))
    }
    func testPostMessages4() {
        let req = try! PostMessage(topicId: 38, message: "XYZ", replyTo: nil, fileKeys: [], talkIds: [678,321]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/38")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("message=XYZ"))
        XCTAssertTrue(q.contains("talkIds%5B%5D=678"))
        XCTAssertTrue(q.contains("talkIds%5B%5D=321"))
    }

    func testUploadAttachment() {
        let req = try! UploadAttachment(topicId: 185, file: Data()).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/185/attachments")
    }

    func testDownloadAttachment() {
        let req = try! DownloadAttachment(topicId: 111, postId: 222, attachmentId: 333, filename: "ReadMe.md", type: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachment2() {
        let req = try! DownloadAttachment(topicId: 300, postId: 400, attachmentId: 100, filename: "image.png", type: AttachmentType.large).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }

    func testDownloadAttachmentWithURL() {
        let req = try! DownloadAttachment(url: URL(string: "https://typetalk.com/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")!)!.buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachmentWithURL2() {
        let req = try! DownloadAttachment(url: URL(string: "https://typetalk.com/api/v1/topics/300/posts/400/attachments/100/image.png")!, attachmentType: .large)!.buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }

    func testGetTopicMembers() {
        let req = try! GetTopicMembers(topicId: 777).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/777/members/status")
    }

    func testGetMessage() {
        let req = try! GetMessage(topicId: 1234, postId: 789).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/1234/posts/789")
    }

    func testUpdateMessage() {
        let req = try! UpdateMessage(topicId: 758, postId: 123, message: "It's a test message!").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/758/posts/123")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("message=It%27s%20a%20test%20message%21"))
    }

    func testDeleteMessage() {
        let req = try! DeleteMessage(topicId: 4321, postId: 987).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/4321/posts/987")
    }

    func testSearchMessages() {
        let req = try! SearchMessages(q: "emacs", spaceKey: "myspace").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/search/posts")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("q=emacs"))
        XCTAssertTrue(q.contains("spaceKey=myspace"))
    }
    // TODO check addtional params

    func testLikeMessage() {
        let req = try! LikeMessage(topicId: 1234, postId: 789).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/1234/posts/789/like")
    }

    func testUnlikeMessage() {
        let req = try! UnlikeMessage(topicId: 4321, postId: 987).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/4321/posts/987/like")
    }

    func testFavoriteTopic() {
        let req = try! FavoriteTopic(topicId: 3334).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/3334/favorite")
    }

    func testUnfavoriteTopic() {
        let req = try! UnfavoriteTopic(topicId: 9943).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/9943/favorite")
    }

    func testGetDirectMessages() {
        let req = try! GetDirectMessages(accountName: "foobar").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/messages/@foobar")
    }
    // TODO check addtional params

    func testPostDirectMessage() {
        let req = try! PostDirectMessage(accountName: "foobar", message: "hello!").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/messages/@foobar")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("message=hello%21"))
    }
    // TODO check addtional params

    /*DELETEME func testGetNotifications() {
        let req = try! GetNotifications().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/notifications")
    }*/

    func testGetNotificationStatus() {
        let req = try! GetNotificationStatus().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v2/notifications/status")
    }

    func testOpenNotification() {
        let req = try! OpenNotification().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v2/notifications")
    }

    func testSaveReadTopic() {
        let req = try! SaveReadTopic(topicId: 643, postId: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/bookmarks")
    }
    func testSaveReadTopic2() {
        let req = try! SaveReadTopic(topicId: 643, postId: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/bookmarks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("topicId=643"))
        XCTAssertFalse(q.contains("postId="))
    }
    func testSaveReadTopic3() {
        let req = try! SaveReadTopic(topicId: 345, postId: 987).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/bookmarks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("topicId=345"))
        XCTAssertTrue(q.contains("postId=987"))
    }

    func testGetMentions() {
        let req = try! GetMentions(spaceKey: "foo", from: nil, unread: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v2/mentions?spaceKey=foo")
    }
    func testGetMentions2() {
        let req = try! GetMentions(spaceKey: "foo", from: 123, unread: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/mentions")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("spaceKey=foo"))
        XCTAssertTrue(q.contains("from=123"))
    }
    func testGetMentions3() {
        let req = try! GetMentions(spaceKey: "foo", from: nil, unread: true).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/mentions")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("spaceKey=foo"))
        XCTAssertTrue(q.contains("unread=1"))
    }

    func testSaveReadMention() {
        let req = try! SaveReadMention(mentionId: 9851).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/mentions/9851")
    }

    func testCreateTopic() {
        let req = try! CreateTopic(name: "test topic", spaceKey: "coffee").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("spaceKey=coffee"))
    }
    func testCreateTopic2() {
        let req = try! CreateTopic(name: "FooBar", spaceKey: "coffee").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("name=FooBar"))
        XCTAssertTrue(q.contains("spaceKey=coffee"))
    }
    func testCreateTopic3() {
        let req = try! CreateTopic(name: "FooBar", spaceKey: "coffee", addAccountIds: [101, 9999], addGroupIds: [17, 58]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("name=FooBar"))
        XCTAssertTrue(q.contains("spaceKey=coffee"))
        XCTAssertTrue(q.contains("addAccountIds%5B%5D=101"))
        XCTAssertTrue(q.contains("addAccountIds%5B%5D=9999"))
        XCTAssertTrue(q.contains("addGroupIds%5B%5D=17"))
        XCTAssertTrue(q.contains("addGroupIds%5B%5D=58"))
    }

    func testUpdateTopic() {
        let req = try! UpdateTopic(topicId: 3154, name: "NewTopicName").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/3154")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("name=NewTopicName"))
        XCTAssertFalse(q.contains("teamId="))
    }
    func testUpdateTopic2() {
        let req = try! UpdateTopic(topicId: 3154, name: "MySampleTopic", description: "Foo bar").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/3154")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("name=MySampleTopic"))
        XCTAssertTrue(q.contains("description=Foo%20bar"))
    }

    func testDeleteTopic() {
        let req = try! DeleteTopic(topicId: 194).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/194")
    }

    func testGetTopicDetails() {
        let req = try! GetTopicDetails(topicId: 914).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/914/details")
    }

    func testUpdateTopicMembers() {
        // TODO
    }

    func testGetSpaces() {
        let req = try! GetSpaces().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/spaces")
    }
    func testGetSpaces2() {
        let req = try! GetSpaces(excludesGuest: true).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/spaces?excludesGuest=1")
    }

    func testGetSpaceMembers() {
        let req = try! GetSpaceMembers(spaceKey: "foo").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/spaces/foo/members")
    }

    func testGetFriends() {
        let req = try! GetFriends(q: "Tom", spaceKey: "sample").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v3/search/friends")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("spaceKey=sample"))
        XCTAssertTrue(q.contains("q=Tom"))
    }

    func testSearchAccounts() {
        let req = try! SearchAccounts(nameOrEmailAddress: "Foobar").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/search/accounts?nameOrEmailAddress=Foobar")
    }

    func testGetTalks() {
        let req = try! GetTalks(topicId: 4256).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/4256/talks")
    }

    func testGetTalk() {
        let req = try! GetTalk(topicId: 135, talkId: 468).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/468/posts")
    }
    func testGetTalk2() {
        let req = try! GetTalk(topicId: 135, talkId: 468, count: 551).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/468/posts?count=551")
    }
    func testGetTalk3() {
        let req = try! GetTalk(topicId: 135, talkId: 468, from: 911).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/468/posts?from=911")
    }
    func testGetTalk4() {
        let req = try! GetTalk(topicId: 135, talkId: 468, direction: MessageDirection.forward).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/468/posts?direction=forward")
    }

    func testCreateTalk() {
        let req = try! CreateTalk(topicId: 135, talkName: "Sample!!!", postIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("talkName=Sample%21%21%21"))
        XCTAssertFalse(q.contains("postIds%5B%5D="))
    }
    func testCreateTalk2() {
        let req = try! CreateTalk(topicId: 965, talkName: "SampleTalk", postIds: [999,758]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/965/talks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("talkName=SampleTalk"))
        XCTAssertTrue(q.contains("postIds%5B%5D=999"))
        XCTAssertTrue(q.contains("postIds%5B%5D=758"))
    }

    func testUpdateTalk() {
        let req = try! UpdateTalk(topicId: 135, talkId: 648, talkName: "Sample!!!").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/648")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("talkName=Sample%21%21%21"))
        XCTAssertFalse(q.contains("postIds%5B%5D="))
    }

    func testDeleteTalk() {
        let req = try! DeleteTalk(topicId: 135, talkId: 648).buildURLRequest()
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/648")
    }

    func testAddMessageToTalk() {
        let req = try! AddMessageToTalk(topicId: 135, talkId: 987, postIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/987/posts")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertFalse(q.contains("postIds%5B%5D="))
    }
    func testAddMessageToTalk2() {
        let req = try! AddMessageToTalk(topicId: 965, talkId: 987, postIds: [123,758]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/965/talks/987/posts")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("postIds%5B%5D=123"))
        XCTAssertTrue(q.contains("postIds%5B%5D=758"))
    }

    func testRemoveMessageFromTalk() {
        let req = try! RemoveMessageFromTalk(topicId: 135, talkId: 987, postIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/135/talks/987/posts")
    }
    func testRemoveMessageFromTalk2() {
        let req = try! RemoveMessageFromTalk(topicId: 965, talkId: 987, postIds: [123,758]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/topics/965/talks/987/posts?postIds%5B%5D=123&postIds%5B%5D=758")
    }

    func testGetLikesReceive() {
        let req = try! GetLikesReceive(spaceKey: "myspace").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/likes/receive")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("spaceKey=myspace"))
    }

    func testGetLikesGive() {
        let req = try! GetLikesGive(spaceKey: "myspace").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/likes/give")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("spaceKey=myspace"))
    }

    func testGetLikesDiscover() {
        let req = try! GetLikesDiscover(spaceKey: "myspace").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/likes/discover")
        let q = req.url!.query!
        XCTAssertTrue(q.contains("spaceKey=myspace"))
    }

    func testSaveReadLikes() {
        let req = try! SaveReadLikes(spaceKey: "myspace", likeId: 44).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.host, "typetalk.com")
        XCTAssertEqual(req.url!.path, "/api/v2/likes/receive/bookmark/save")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertTrue(q.contains("spaceKey=myspace"))
        XCTAssertTrue(q.contains("likeId=44"))
    }


    /*func testStreaming() {
        let req = Streaming.buildURLRequest().value!
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.com/api/v1/streaming")
    }*/
}
