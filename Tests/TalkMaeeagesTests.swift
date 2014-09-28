//
//  TalkMaeeagesTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class TalkMessagesTests: TestCase {
    
    func testExample() {
        var error: NSError? = nil
        let model = TalkMessages(dictionary: json("model_talk_messages"), error: &error)
        
        XCTAssertEqual(model.topic!.id, 208)
        XCTAssertEqual(model.topic!.name, "IT Peeps")
        XCTAssertEqual(model.topic!.suggestion, "IT Peeps")
        XCTAssertEqual(model.topic!.lastPostedAt!.description, "2014-07-25 03:38:45 +0000")
        XCTAssertEqual(model.topic!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(model.topic!.updatedAt.description, "2014-06-10 02:32:29 +0000")

        XCTAssertEqual(model.talk!.id, 900)
        XCTAssertEqual(model.talk!.topicId, 208)
        XCTAssertEqual(model.talk!.name, "About us")
        XCTAssertEqual(model.talk!.createdAt.description, "2014-07-02 03:42:29 +0000")
        XCTAssertEqual(model.talk!.updatedAt.description, "2014-07-02 03:52:29 +0000")

        XCTAssertEqual(countElements(model.posts), 2)

        XCTAssertEqual(model.hasNext, false)
    }
}
