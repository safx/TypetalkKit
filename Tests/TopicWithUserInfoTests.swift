//
//  TopicWithUserInfoTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class TopicWithUserInfoTests: XCTestCase {

    func testExample() {
        let model = try! TopicWithUserInfo.parseJSON(json("model_topic_with_userinfo"))
        
        XCTAssertEqual(model.topic.id, 202)
        XCTAssertEqual(model.topic.name, "Arts & Crafts Club")
        XCTAssertEqual(model.topic.suggestion, "Arts & Crafts Club")
        XCTAssertEqual(model.topic.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(model.topic.createdAt.description, "2014-06-04 02:32:29 +0000")
        XCTAssertEqual(model.topic.updatedAt.description, "2014-06-04 02:32:29 +0000")
        XCTAssertEqual(model.favorite, true)
        XCTAssertEqual(model.unread!.topicId, 202)
        XCTAssertEqual(model.unread!.postId, 0)
        XCTAssertEqual(model.unread!.count, 1)
    }
}
