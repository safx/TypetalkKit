//
//  NotificationTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//


import XCTest
import TypetalkKit

class NotificationTests: TestCase {
    
    func testExample() {
        var error: NSError? = nil
        let model = Notifications(dictionary: json("model_notifications"), error: &error)
        
        XCTAssertEqual(countElements(model.mentions), 2)
        let mention = model.mentions[1]
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
        
        XCTAssertEqual(countElements(model.teamInvites), 2)
        let team = model.teamInvites[1]
        XCTAssertEqual(team.id, 800)
        XCTAssertEqual(team.team!.id, 702)
        XCTAssertEqual(team.team!.name, "Cycling team")
        XCTAssertEqual(team.sender!.id, 106)
        XCTAssertEqual(team.sender!.name, "chelseab")
        XCTAssertEqual(team.account!.id, 100)
        XCTAssertEqual(team.account!.name, "jessica")
        
        XCTAssertEqual(countElements(model.topicInvites), 2)
        let topic = model.topicInvites[1]
        XCTAssertEqual(topic.id, 600)
        XCTAssertEqual(topic.topic!.id, 209)
        XCTAssertEqual(topic.topic!.name, "Web Site")
        XCTAssertEqual(topic.sender!.id, 106)
        XCTAssertEqual(topic.sender!.name, "chelseab")
        XCTAssertEqual(topic.account!.id, 100)
        XCTAssertEqual(topic.account!.name, "jessica")        
    }
}
