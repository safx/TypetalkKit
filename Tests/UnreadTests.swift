//
//  UnreadTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest
import TypetalkKit

class UnreadTests: XCTestCase {
    
    func testExample() {
        var error: NSError? = nil
        let model = Unread(dictionary: TestUtil.json("model_unread"), error: &error)
        
        XCTAssertEqual(model.topicId, 208)
        XCTAssertEqual(model.postId, 307)
        XCTAssertEqual(model.count, 0)
    }
}
