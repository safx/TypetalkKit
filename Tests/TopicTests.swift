//
//  TopicTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/16.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class TopicTests: XCTestCase {
    
    func testExample() {
        let model = try! decode(Topic.self, fromJsonFile: "model_topic")
        
        XCTAssertEqual(model.id, 207)
        XCTAssertEqual(model.name, "Art Directors")
        XCTAssertEqual(model.suggestion, "Art Directors")
        XCTAssertEqual(model.lastPostedAt!.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(model.createdAt.description, "2014-07-19 12:42:39 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-08-29 22:52:49 +0000")
    }
}
