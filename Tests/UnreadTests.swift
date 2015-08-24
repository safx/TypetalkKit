//
//  UnreadTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
import TypetalkKit

class UnreadTests: XCTestCase {
    
    func testExample() {
        let model = try! Unread.parseJSON(json("model_unread"))
        
        XCTAssertEqual(model.topicId, 208)
        XCTAssertEqual(model.postId, 307)
        XCTAssertEqual(model.count, 0)
    }
}
