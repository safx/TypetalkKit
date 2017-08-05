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
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/profile")
        XCTAssertEqual(req.value(forHTTPHeaderField:
            "Authorization")!, "Bearer atfoo")
    }

    func testGetTopics() {
        let req = try! GetTopics().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics")
    }

    func testGetMessages() {
        let req = try! GetMessages(topicId: 312).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/312")
    }

    func testGetMessages2() {
        let req = try! GetMessages(topicId: 312, count: 98).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/312?count=98")
    }

    func testGetMessages3() {
        let req = try! GetMessages(topicId: 312, from: 178).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/312?from=178")
    }

    func testGetMessages4() {
        let req = try! GetMessages(topicId: 312, direction: .backward).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/312?direction=backward")
    }

    func testPostMessages() {
        let req = try! PostMessage(topicId: 758, message: "It's a test message!", replyTo: nil, fileKeys: [], talkIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/758")
    }

    func testPostMessages2() {
        let req = try! PostMessage(topicId: 38, message: "XYZ", replyTo: 987, fileKeys: [], talkIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "replyTo=987").location, NSNotFound)
    }

    func testPostMessages3() {
        let req = try! PostMessage(topicId: 38, message: "XYZ", replyTo: nil, fileKeys: ["ABCDEF"], talkIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "fileKeys%5B%5D=ABCDEF").location, NSNotFound)
    }

    func testPostMessages4() {
        let req = try! PostMessage(topicId: 38, message: "XYZ", replyTo: nil, fileKeys: [], talkIds: [678,321]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "talkIds%5B%5D=678").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "talkIds%5B%5D=321").location, NSNotFound)
    }

    func testUploadAttachment() {
        let req = try! UploadAttachment(topicId: 185, name: "foobar.jpg", contents: Data()).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/185/attachments")
    }

    func testDownloadAttachment() {
        let req = try! DownloadAttachment(topicId: 111, postId: 222, attachmentId: 333, filename: "ReadMe.md", type: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachment2() {
        let req = try! DownloadAttachment(topicId: 300, postId: 400, attachmentId: 100, filename: "image.png", type: AttachmentType.large).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }

    func testDownloadAttachmentWithURL() {
        let req = try! DownloadAttachment(url: URL(string: "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")!)!.buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachmentWithURL2() {
        let req = try! DownloadAttachment(url: URL(string: "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png")!, attachmentType: .large)!.buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }

    func testGetTopicMembers() {
        let req = try! GetTopicMembers(topicId: 777).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/777/members/status")
    }

    func testUpdateMessages() {
        let req = try! UpdateMessage(topicId: 758, postId: 123, message: "It's a test message!").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/758/posts/123")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertEqual(q.range(of: "message=It%27s%20a%20test%20message%21").location, 0)
    }

    func testGetMessage() {
        let req = try! GetMessage(topicId: 1234, postId: 789).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/1234/posts/789")
    }

    func testDeleteMessage() {
        let req = try! DeleteMessage(topicId: 4321, postId: 987).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/4321/posts/987")
    }

    func testLikeMessage() {
        let req = try! LikeMessage(topicId: 1234, postId: 789).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/1234/posts/789/like")
    }

    func testUnlikeMessage() {
        let req = try! UnlikeMessage(topicId: 4321, postId: 987).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/4321/posts/987/like")
    }

    func testFavoriteTopic() {
        let req = try! FavoriteTopic(topicId: 3334).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/3334/favorite")
    }

    func testUnfavoriteTopic() {
        let req = try! UnfavoriteTopic(topicId: 9943).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/9943/favorite")
    }

    func testGetNotifications() {
        let req = try! GetNotifications().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/notifications")
    }

    func testGetNotificationStatus() {
        let req = try! GetNotificationStatus().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/notifications/status")
    }

    func testOpenNotification() {
        let req = try! OpenNotification().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/notifications")
    }

    func testSaveReadTopic() {
        let req = try! SaveReadTopic(topicId: 643, postId: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/bookmarks")
    }
    func testSaveReadTopic2() {
        let req = try! SaveReadTopic(topicId: 643, postId: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/bookmarks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "topicId=643").location, NSNotFound)
        XCTAssertEqual(q.range(of: "postId=").location, NSNotFound)
    }
    func testSaveReadTopic3() {
        let req = try! SaveReadTopic(topicId: 345, postId: 987).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/bookmarks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "topicId=345").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "postId=987").location, NSNotFound)
    }

    func testGetMentions() {
        let req = try! GetMentions(from: nil, unread: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/mentions")
    }
    func testGetMentions2() {
        let req = try! GetMentions(from: 123, unread: nil).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/mentions?from=123")
    }
    func testGetMentions3() {
        let req = try! GetMentions(from: nil, unread: true).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/mentions?unread=1")
    }

    func testSaveReadMention() {
        let req = try! SaveReadMention(mentionId: 9851).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/mentions/9851")
    }

    func testCreateTopic() {
        let req = try! CreateTopic(name: "test topic", spaceKey: "coffee").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "spaceKey=coffee").location, NSNotFound)
    }
    func testCreateTopic2() {
        let req = try! CreateTopic(name: "FooBar", spaceKey: "coffee").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "name=FooBar").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "spaceKey=coffee").location, NSNotFound)
    }
    func testCreateTopic3() {
        let req = try! CreateTopic(name: "FooBar", spaceKey: "coffee", addAccountIds: [101, 9999], addGroupIds: [17, 58]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "name=FooBar").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "spaceKey=coffee").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "addAccountIds%5B%5D=101").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "addAccountIds%5B%5D=9999").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "addGroupIds%5B%5D=17").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "addGroupIds%5B%5D=58").location, NSNotFound)
    }

    func testUpdateTopic() {
        let req = try! UpdateTopic(topicId: 3154).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/3154")
    }
    func testUpdateTopic2() {
        let req = try! UpdateTopic(topicId: 3154, name: "NewTopicName").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/3154")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "name=NewTopicName").location, NSNotFound)
        XCTAssertEqual(q.range(of: "teamId=").location, NSNotFound)
    }
    func testUpdateTopic3() {
        let req = try! UpdateTopic(topicId: 3154, description: "Foo bar").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/3154")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertEqual(q.range(of: "name=").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "description=Foo%20bar").location, NSNotFound)
    }

    func testDeleteTopic() {
        let req = try! DeleteTopic(topicId: 194).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/194")
    }

    func testGetTopicDetails() {
        let req = try! GetTopicDetails(topicId: 914).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/914/details")
    }

    func testGetFriends() {
        let req = try! GetFriends().buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/search/friends")
    }

    func testSearchAccounts() {
        let req = try! SearchAccounts(nameOrEmailAddress: "Foobar").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/search/accounts?nameOrEmailAddress=Foobar")
    }

    func testGetTalks() {
        let req = try! GetTalks(topicId: 4256).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/4256/talks")
    }

    func testGetTalk() {
        let req = try! GetTalk(topicId: 135, talkId: 468).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts")
    }
    func testGetTalk2() {
        let req = try! GetTalk(topicId: 135, talkId: 468, count: 551).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?count=551")
    }
    func testGetTalk3() {
        let req = try! GetTalk(topicId: 135, talkId: 468, from: 911).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?from=911")
    }
    func testGetTalk4() {
        let req = try! GetTalk(topicId: 135, talkId: 468, direction: MessageDirection.forward).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?direction=forward")
    }

    func testCreateTalk() {
        let req = try! CreateTalk(topicId: 135, talkName: "Sample!!!", postIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "talkName=Sample%21%21%21").location, NSNotFound)
        XCTAssertEqual(q.range(of: "postIds%5B%5D=").location, NSNotFound)
    }
    func testCreateTalk2() {
        let req = try! CreateTalk(topicId: 965, talkName: "SampleTalk", postIds: [999,758]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/965/talks")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "talkName=SampleTalk").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "postIds%5B%5D=999").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "postIds%5B%5D=758").location, NSNotFound)
    }

    func testUpdateTalk() {
        let req = try! UpdateTalk(topicId: 135, talkId: 648, talkName: "Sample!!!").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "PUT")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/648")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "talkName=Sample%21%21%21").location, NSNotFound)
        XCTAssertEqual(q.range(of: "postIds%5B%5D=").location, NSNotFound)
    }

    func testDeleteTalk() {
        let req = try! DeleteTalk(topicId: 135, talkId: 648).buildURLRequest()
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/648")
    }

    func testAddMessageToTalk() {
        let req = try! AddMessageToTalk(topicId: 135, talkId: 987, postIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/987/posts")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertEqual(q.range(of: "postIds%5B%5D=").location, NSNotFound)
    }
    func testAddMessageToTalk2() {
        let req = try! AddMessageToTalk(topicId: 965, talkId: 987, postIds: [123,758]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/965/talks/987/posts")
        let q = NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        XCTAssertNotEqual(q.range(of: "postIds%5B%5D=123").location, NSNotFound)
        XCTAssertNotEqual(q.range(of: "postIds%5B%5D=758").location, NSNotFound)
    }

    func testRemoveMessageFromTalk() {
        let req = try! RemoveMessageFromTalk(topicId: 135, talkId: 987, postIds: []).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/987/posts")
    }
    func testRemoveMessageFromTalk2() {
        let req = try! RemoveMessageFromTalk(topicId: 965, talkId: 987, postIds: [123,758]).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "DELETE")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/topics/965/talks/987/posts?postIds%5B%5D=123&postIds%5B%5D=758")
    }

    /*func testStreaming() {
        let req = Streaming.buildURLRequest().value!
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/api/v1/streaming")
    }*/
}
