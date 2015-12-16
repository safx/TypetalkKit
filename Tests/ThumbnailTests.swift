//
//  ThumbnailTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/01/19.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class ThumbnailTests: XCTestCase {
    
    func testExample() {
        let model = try! Thumbnail.parseJSON(json("model_thumbnail"))
        
        XCTAssertEqual(model.type.rawValue, "small")
        XCTAssertEqual(model.fileSize, 10439)
        XCTAssertEqual(model.width, 480)
        XCTAssertEqual(model.height, 360)
    }
}
