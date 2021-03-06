//
//  TalkTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class TalkTests: XCTestCase {
    
    func testExample() {
        let model = try! decode(Talk.self, fromJsonFile: "model_talk")
        
        XCTAssertEqual(model.id, 901)
        XCTAssertEqual(model.topicId, 208)
        XCTAssertEqual(model.name, "2nd talk")
        XCTAssertEqual(model.suggestion, "2nd talk")
        XCTAssertEqual(model.createdAt.description, "2014-07-02 03:52:29 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-07-02 03:55:29 +0000")
    }
}
