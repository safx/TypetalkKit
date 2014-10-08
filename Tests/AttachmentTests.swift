//
//  AttachmentTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class AttachmentTests: XCTestCase {
    
    func testExample() {
        var error: NSError? = nil
        let model = Attachment(dictionary: TestUtil.json("model_attachment"), error: &error)
        
        XCTAssertEqual(model.fileKey, "0569fedc62f37e48779ee285fe04f0ff4057e0d0")
        XCTAssertEqual(model.fileName, "sample.jpg")
        XCTAssertEqual(model.fileSize, 472263)
    }
}
