//
//  TopicWithAccountsTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/04.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class TopicWithAccountsTests: XCTestCase {
    
    func testExample() {
        let model = try! TopicWithAccounts.parseJSON(json("model_topic_with_accounts"))
        
        XCTAssertEqual(model.topic.id, 208)
        XCTAssertEqual(model.topic.name, "IT Peeps")
        XCTAssertEqual(model.topic.suggestion, "IT Peeps")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2014-06-10 02:32:29 +0000")

        XCTAssertEqual((model.teams).count, 1)
        XCTAssertEqual((model.accounts).count, 2)

        XCTAssertEqual((model.invites).count, 2)
        let last = model.invites[1]
        XCTAssertEqual(last.id, 603)
        XCTAssertTrue(nil == last.account)
        XCTAssertEqual(last.mailAddress!, "typetalk@example.com")
        XCTAssertEqual(last.status, "decline")
    }
}
