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
        let req = GetProfile().buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/profile")
        XCTAssertEqual(req.valueForHTTPHeaderField("Authorization")!, "Bearer atfoo")
    }

    func testGetTopics() {
        let req = GetTopics().buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics")
    }

    func testGetMessages() {
        let req = GetMessages(topicId: 312, count: nil, from: nil, direction: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/312")
    }

    func testGetMessages2() {
        let req = GetMessages(topicId: 312, count: 98, from: nil, direction: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/312?count=98")
    }

    func testGetMessages3() {
        let req = GetMessages(topicId: 312, count: nil, from: 178, direction: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/312?from=178")
    }

    func testGetMessages4() {
        let req = GetMessages(topicId: 312, count: nil, from: nil, direction: MessageDirection.Backward).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/312?direction=backward")
    }

    func testPostMessages() {
        let req = PostMessage(topicId: 758, message: "It's a test message!", replyTo: nil, fileKeys: [], talkIds: []).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/758")
    }

    func testPostMessages2() {
        let req = PostMessage(topicId: 38, message: "XYZ", replyTo: 987, fileKeys: [], talkIds: []).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("replyTo=987").location, NSNotFound)
    }

    func testPostMessages3() {
        let req = PostMessage(topicId: 38, message: "XYZ", replyTo: nil, fileKeys: ["ABCDEF"], talkIds: []).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("fileKeys%5B%5D=ABCDEF").location, NSNotFound)
    }

    func testPostMessages4() {
        let req = PostMessage(topicId: 38, message: "XYZ", replyTo: nil, fileKeys: [], talkIds: [678,321]).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("talkIds%5B%5D=678").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("talkIds%5B%5D=321").location, NSNotFound)
    }

    func testUploadAttachment() {
        let req = UploadAttachment(topicId: 185, name: "foobar.jpg", contents: NSData()).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/185/attachments")
    }

    func testDownloadAttachment() {
        let req = DownloadAttachment(topicId: 111, postId: 222, attachmentId: 333, filename: "ReadMe.md", type: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachment2() {
        let req = DownloadAttachment(topicId: 300, postId: 400, attachmentId: 100, filename: "image.png", type: AttachmentType.Large).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }

    func testDownloadAttachmentWithURL() {
        let req = DownloadAttachment(url: NSURL(string: "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")!)!.buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachmentWithURL2() {
        let req = DownloadAttachment(url: NSURL(string: "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png")!, attachmentType: .Large)!.buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }

    func testGetTopicMembers() {
        let req = GetTopicMembers(topicId: 777).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/777/members/status")
    }

    func testUpdateMessages() {
        let req = UpdateMessage(topicId: 758, postId: 123, message: "It's a test message!").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/758/posts/123")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("message=It%27s%20a%20test%20message%21").location, 0)
    }

    func testGetMessage() {
        let req = GetMessage(topicId: 1234, postId: 789).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/1234/posts/789")
    }

    func testDeleteMessage() {
        let req = DeleteMessage(topicId: 4321, postId: 987).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/4321/posts/987")
    }

    func testLikeMessage() {
        let req = LikeMessage(topicId: 1234, postId: 789).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/1234/posts/789/like")
    }

    func testUnlikeMessage() {
        let req = UnlikeMessage(topicId: 4321, postId: 987).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/4321/posts/987/like")
    }

    func testFavoriteTopic() {
        let req = FavoriteTopic(topicId: 3334).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/3334/favorite")
    }

    func testUnfavoriteTopic() {
        let req = UnfavoriteTopic(topicId: 9943).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/9943/favorite")
    }

    func testGetNotifications() {
        let req = GetNotifications().buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/notifications")
    }

    func testGetNotificationStatus() {
        let req = GetNotificationStatus().buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/notifications/status")
    }

    func testOpenNotification() {
        let req = OpenNotification().buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/notifications")
    }

    func testSaveReadTopic() {
        let req = SaveReadTopic(topicId: 643, postId: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/bookmarks")
    }
    func testSaveReadTopic2() {
        let req = SaveReadTopic(topicId: 643, postId: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/bookmarks")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("topicId=643").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("postId=").location, NSNotFound)
    }
    func testSaveReadTopic3() {
        let req = SaveReadTopic(topicId: 345, postId: 987).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/bookmarks")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("topicId=345").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("postId=987").location, NSNotFound)
    }

    func testGetMentions() {
        let req = GetMentions(from: nil, unread: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/mentions")
    }
    func testGetMentions2() {
        let req = GetMentions(from: 123, unread: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/mentions?from=123")
    }
    func testGetMentions3() {
        let req = GetMentions(from: nil, unread: true).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/mentions?unread=1")
    }

    func testSaveReadMention() {
        let req = SaveReadMention(mentionId: 9851).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/mentions/9851")
    }

    func testCreateTopic() {
        let req = CreateTopic(name: "test topic", teamId: nil, inviteMembers: [], inviteMessage: "").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics")
    }
    func testCreateTopic2() {
        let req = CreateTopic(name: "FooBar", teamId: nil, inviteMembers: [], inviteMessage: "").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=FooBar").location, NSNotFound)
    }
    func testCreateTopic3() {
        let req = CreateTopic(name: "FooBar", teamId: 919, inviteMembers: [], inviteMessage: "SomeMessage").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=FooBar").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("teamId=919").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMessage=SomeMessage").location, NSNotFound)
    }
    func testCreateTopic4() {
        let req = CreateTopic(name: "FooBar", teamId: nil, inviteMembers: ["Yamada", "Tanaka"], inviteMessage: "").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=FooBar").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMembers%5B%5D=Yamada").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMembers%5B%5D=Tanaka").location, NSNotFound)
    }

    func testUpdateTopic() {
        let req = UpdateTopic(topicId: 3154, name: nil, teamId: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/3154")
    }
    func testUpdateTopic2() {
        let req = UpdateTopic(topicId: 3154, name: "NewTopicName", teamId: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/3154")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=NewTopicName").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("teamId=").location, NSNotFound)
    }
    func testUpdateTopic3() {
        let req = UpdateTopic(topicId: 3154, name: nil, teamId: 1111).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/3154")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("name=").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("teamId=1111").location, NSNotFound)
    }

    func testDeleteTopic() {
        let req = DeleteTopic(topicId: 194).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/194")
    }

    func testGetTopicDetails() {
        let req = GetTopicDetails(topicId: 914).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/914/details")
    }

    func testGetFriends() {
        let req = GetFriends().buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/search/friends")
    }

    func testSearchAccounts() {
        let req = SearchAccounts(nameOrEmailAddress: "Foobar").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/search/accounts?nameOrEmailAddress=Foobar")
    }

    func testGetTalks() {
        let req = GetTalks(topicId: 4256).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/4256/talks")
    }

    func testGetTalk() {
        let req = GetTalk(topicId: 135, talkId: 468, count: nil, from: nil, direction: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts")
    }
    func testGetTalk2() {
        let req = GetTalk(topicId: 135, talkId: 468, count: 551, from: nil, direction: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?count=551")
    }
    func testGetTalk3() {
        let req = GetTalk(topicId: 135, talkId: 468, count: nil, from: 911, direction: nil).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?from=911")
    }
    func testGetTalk4() {
        let req = GetTalk(topicId: 135, talkId: 468, count: nil, from: nil, direction: MessageDirection.Forward).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?direction=forward")
    }

    func testCreateTalk() {
        let req = CreateTalk(topicId: 135, talkName: "Sample!!!", postIds: []).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("talkName=Sample%21%21%21").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("postIds%5B%5D=").location, NSNotFound)
    }
    func testCreateTalk2() {
        let req = CreateTalk(topicId: 965, talkName: "SampleTalk", postIds: [999,758]).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/965/talks")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("talkName=SampleTalk").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("postIds%5B%5D=999").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("postIds%5B%5D=758").location, NSNotFound)
    }

    func testUpdateTalk() {
        let req = UpdateTalk(topicId: 135, talkId: 648, talkName: "Sample!!!").buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/648")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("talkName=Sample%21%21%21").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("postIds%5B%5D=").location, NSNotFound)
    }

    func testDeleteTalk() {
        let req = DeleteTalk(topicId: 135, talkId: 648).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/648")
    }

    func testAddMessageToTalk() {
        let req = AddMessageToTalk(topicId: 135, talkId: 987, postIds: []).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/987/posts")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("postIds%5B%5D=").location, NSNotFound)
    }
    func testAddMessageToTalk2() {
        let req = AddMessageToTalk(topicId: 965, talkId: 987, postIds: [123,758]).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/965/talks/987/posts")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("postIds%5B%5D=123").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("postIds%5B%5D=758").location, NSNotFound)
    }

    func testRemoveMessageFromTalk() {
        let req = RemoveMessageFromTalk(topicId: 135, talkId: 987, postIds: []).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/135/talks/987/posts")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("postIds%5B%5D=").location, NSNotFound)
    }
    func testRemoveMessageFromTalk2() {
        let req = RemoveMessageFromTalk(topicId: 965, talkId: 987, postIds: [123,758]).buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/topics/965/talks/987/posts")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("postIds%5B%5D=123").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("postIds%5B%5D=758").location, NSNotFound)
    }

    /*func testStreaming() {
        let req = Streaming.buildURLRequest().value!
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URL!.absoluteString, "https://typetalk.in/api/v1/streaming")
    }*/
}
