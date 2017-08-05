//
//  NotificationTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//


import XCTest
@testable import TypetalkKit

class NotificationTests: XCTestCase {
    
    func testExample() {
        let model = try! decode(Notifications.self, fromJsonFile: "model_notifications")
        
        XCTAssertEqual((model.mentions)?.count, 2)
        let mention = model.mentions![1]
        XCTAssertEqual(mention.id, 500)
        XCTAssertEqual(mention.readAt!.description, "2014-06-30 15:00:00 +0000")
        XCTAssertEqual(mention.post!.id, 308)
        XCTAssertEqual(mention.post!.topicId, 202)
        XCTAssertNil(mention.post!.replyTo)
        XCTAssertEqual(mention.post!.message, "@jessica What do you think about this?")
        XCTAssertEqual(mention.post!.account.id, 101)
        XCTAssertEqual(mention.post!.account.name, "ahorowitz")
        
        XCTAssertEqual((model.invites.teams)?.count, 0)
        
        XCTAssertEqual((model.invites.topics)?.count, 2)
        let topic = model.invites.topics![1]
        XCTAssertEqual(topic.id, 600)
        XCTAssertEqual(topic.sender!.id, 106)
        XCTAssertEqual(topic.sender!.name, "chelseab")
        XCTAssertEqual(topic.account!.id, 100)
        XCTAssertEqual(topic.account!.name, "jessica")
    }
}
