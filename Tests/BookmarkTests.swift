//
//  BookmarkTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest
import TypetalkKit

class BookmarkTests: XCTestCase {
    
    func testExample() {
        let model = try! Bookmark.parseJSON(json("model_bookmark"))
        
        XCTAssertEqual(model.postId, 304)
        XCTAssertEqual(model.updatedAt.description, "2014-07-25 03:38:34 +0000")
    }
}
