//
//  RouterTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
import TypetalkKit

class RouterTests: XCTestCase {
    
    func testGetProfile() {
        let req = Router.GetProfile.URLRequest("foobar")
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/profile")
        XCTAssertEqual(req.valueForHTTPHeaderField("Authorization")!, "Bearer foobar")
    }
    
    func testGetTopics() {
        let req = Router.GetTopics.URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics")
    }
    
    func testGetMessages() {
        let req = Router.GetMessages(312, GetMessagesForm(count: nil, from: nil, direction: nil)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/312")
    }
    func testGetMessages2() {
        let req = Router.GetMessages(312, GetMessagesForm(count: 98, from: nil, direction: nil)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/312?count=98")
    }
    func testGetMessages3() {
        let req = Router.GetMessages(312, GetMessagesForm(count: nil, from: 178, direction: nil)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/312?from=178")
    }
    func testGetMessages4() {
        let req = Router.GetMessages(312, GetMessagesForm(count: nil, from: nil, direction: MessageDirection.Backward)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/312?direction=backward")
    }

    func testPostMessages() {
        let req = Router.PostMessage(758, PostMessageForm(message: "It's a test message!", replyTo: nil, fileKeys: [], talkIds: [])).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/758")
    }
    func testPostMessages2() {
        let req = Router.PostMessage(38, PostMessageForm(message: "XYZ", replyTo: 987, fileKeys: [], talkIds: [])).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("replyTo=987").location, NSNotFound)
    }
    func testPostMessages3() {
        let req = Router.PostMessage(38, PostMessageForm(message: "XYZ", replyTo: nil, fileKeys: ["ABCDEF"], talkIds: [])).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("fileKeys%5B%5D=ABCDEF").location, NSNotFound)
    }
    func testPostMessages4() {
        let req = Router.PostMessage(38, PostMessageForm(message: "XYZ", replyTo: nil, fileKeys: [], talkIds: [678,321])).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/38")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("message=XYZ").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("talkIds%5B%5D=678").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("talkIds%5B%5D=321").location, NSNotFound)
    }

    func testUploadAttachment() {
        let req = Router.UploadAttachment(185).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/185/attachments")
    }

    func testGetTopicMembers() {
        let req = Router.GetTopicMembers(777).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/777/members/status")
    }

    func testGetMessage() {
        let req = Router.GetMessage(1234, 789).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/1234/posts/789")
    }

    func testDeleteMessage() {
        let req = Router.DeleteMessage(4321, 987).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/4321/posts/987")
    }

    func testLikeMessage() {
        let req = Router.LikeMessage(1234, 789).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/1234/posts/789/like")
    }

    func testUnlikeMessage() {
        let req = Router.UnlikeMessage(4321, 987).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/4321/posts/987/like")
    }

    func testFavoriteTopic() {
        let req = Router.FavoriteTopic(3334).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/3334/favorite")
    }

    func testUnfavoriteTopic() {
        let req = Router.UnfavoriteTopic(9943).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/9943/favorite")
    }

    func testGetNotifications() {
        let req = Router.GetNotifications.URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/notifications")
    }

    func testGetNotificationStatus() {
        let req = Router.GetNotificationStatus.URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/notifications/status")
    }

    func testOpenNotification() {
        let req = Router.OpenNotification.URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/notifications")
    }

    func testSaveReadTopic() {
        let req = Router.SaveReadTopic(643, nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/bookmarks")
    }
    func testSaveReadTopic2() {
        let req = Router.SaveReadTopic(643, nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/bookmarks")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("topicId=643").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("postId=").location, NSNotFound)
    }
    func testSaveReadTopic3() {
        let req = Router.SaveReadTopic(345, 987).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/bookmarks")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("topicId=345").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("postId=987").location, NSNotFound)
    }
    
    func testGetMentions() {
        let req = Router.GetMentions(nil, nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/mentions")
    }
    func testGetMentions2() {
        let req = Router.GetMentions(123, nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/mentions?from=123")
    }
    func testGetMentions3() {
        let req = Router.GetMentions(nil, true).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/mentions?unread=1")
    }

    func testSaveReadMention() {
        let req = Router.SaveReadMention(9851).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/mentions/9851")
    }

    func testAcceptTeamInvite() {
        let req = Router.AcceptTeamInvite(543, 976).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/teams/543/members/invite/976/accept")
    }

    func testDeclineTeamInvite() {
        let req = Router.DeclineTeamInvite(123, 4566).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/teams/123/members/invite/4566/decline")
    }

    func testAcceptTopicInvite() {
        let req = Router.AcceptTopicInvite(453, 796).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/453/members/invite/796/accept")
    }
    
    func testDeclineTopicInvite() {
        let req = Router.DeclineTopicInvite(231, 546).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/231/members/invite/546/decline")
    }
    
    func testCreateTopic() {
        let req = Router.CreateTopic(CreateTopicForm(name: "test topic", teamId: nil, inviteMembers: [], inviteMessage: "")).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics")
    }
    func testCreateTopic2() {
        let req = Router.CreateTopic(CreateTopicForm(name: "FooBar", teamId: nil, inviteMembers: [], inviteMessage: "")).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=FooBar").location, NSNotFound)
    }
    func testCreateTopic3() {
        let req = Router.CreateTopic(CreateTopicForm(name: "FooBar", teamId: 919, inviteMembers: [], inviteMessage: "SomeMessage")).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=FooBar").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("teamId=919").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMessage=SomeMessage").location, NSNotFound)
    }
    func testCreateTopic4() {
        let req = Router.CreateTopic(CreateTopicForm(name: "FooBar", teamId: nil, inviteMembers: ["Yamada", "Tanaka"], inviteMessage: "")).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=FooBar").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMembers%5B%5D=Yamada").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMembers%5B%5D=Tanaka").location, NSNotFound)
    }
    
    func testUpdateTopic() {
        let req = Router.UpdateTopic(3154, nil, nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/3154")
    }
    func testUpdateTopic2() {
        let req = Router.UpdateTopic(3154, "NewTopicName", nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/3154")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("name=NewTopicName").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("teamId=").location, NSNotFound)
    }
    func testUpdateTopic3() {
        let req = Router.UpdateTopic(3154, nil, 1111).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "PUT")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/3154")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("name=").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("teamId=1111").location, NSNotFound)
    }

    func testDeleteTopic() {
        let req = Router.DeleteTopic(194).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "DELETE")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/194")
    }

    func testGetTopicDetails() {
        let req = Router.GetTopicDetails(914).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/914/details")
    }

    func testInviteTopicMember() {
        let req = Router.InviteTopicMember(345, [], "").URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/345/members/invite")
    }
    func testInviteTopicMember2() {
        let req = Router.InviteTopicMember(345, ["Foo", "Bar"], "").URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/345/members/invite")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("inviteMembers%5B%5D=Foo").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMembers%5B%5D=Bar").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("inviteMessage=").location, NSNotFound)
    }
    func testInviteTopicMember3() {
        let req = Router.InviteTopicMember(345, [], "HelloWorld").URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/345/members/invite")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("inviteMembers%5B%5D=").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("inviteMessage=HelloWorld").location, NSNotFound)
    }

    func testRemoveTopicMember() {
        let req = Router.RemoveTopicMember(953, [], []).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/953/members/remove")
    }
    func testRemoveTopicMember2() {
        let req = Router.RemoveTopicMember(953, [123,789], []).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/953/members/remove")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertNotEqual(q.rangeOfString("removeInviteIds%5B%5D=123").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("removeInviteIds%5B%5D=789").location, NSNotFound)
        XCTAssertEqual(q.rangeOfString("removeMemberIds%5B%5D=").location, NSNotFound)
    }
    func testRemoveTopicMember3() {
        let req = Router.RemoveTopicMember(953, [], [543,678]).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "POST")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/953/members/remove")
        let q = NSString(data: req.HTTPBody!, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual(q.rangeOfString("removeInviteIds%5B%5D=").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("removeMemberIds%5B%5D=543").location, NSNotFound)
        XCTAssertNotEqual(q.rangeOfString("removeMemberIds%5B%5D=678").location, NSNotFound)
    }

    func testGetTeams() {
        let req = Router.GetTeams.URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/teams")
    }

    func testGetFriends() {
        let req = Router.GetFriends.URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/search/friends")
    }

    func testSearchAccounts() {
        let req = Router.SearchAccounts("Foobar").URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/search/accounts?nameOrEmailAddress=Foobar")
    }

    func testGetTalks() {
        let req = Router.GetTalks(4256).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/4256/talks")
    }

    func testGetTalk() {
        let req = Router.GetTalk(135, 468, GetTalkForm(count: nil, from: nil, direction: nil)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/135/talks/468/posts")
    }
    func testGetTalk2() {
        let req = Router.GetTalk(135, 468, GetTalkForm(count: 551, from: nil, direction: nil)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?count=551")
    }
    func testGetTalk3() {
        let req = Router.GetTalk(135, 468, GetTalkForm(count: nil, from: 911, direction: nil)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?from=911")
    }
    func testGetTalk4() {
        let req = Router.GetTalk(135, 468, GetTalkForm(count: nil, from: nil, direction: MessageDirection.Forward)).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/135/talks/468/posts?direction=forward")
    }

    func testDownloadAttachment() {
        let req = Router.DownloadAttachment(111, 222, 333, "ReadMe.md", nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachment2() {
        let req = Router.DownloadAttachment(300, 400, 100, "image.png", AttachmentType.Large).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }
    
    func testDownloadAttachmentWithURL() {
        let req = Router.DownloadAttachmentWithURL(NSURL(string: "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")!, nil).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/111/posts/222/attachments/333/ReadMe.md")
    }
    func testDownloadAttachmentWithURL2() {
        let req = Router.DownloadAttachmentWithURL(NSURL(string: "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png")!, AttachmentType.Large).URLRequest
        XCTAssertEqual(req.HTTPMethod!, "GET")
        XCTAssertEqual(req.URLString, "https://typetalk.in/api/v1/topics/300/posts/400/attachments/100/image.png?type=large")
    }
}
