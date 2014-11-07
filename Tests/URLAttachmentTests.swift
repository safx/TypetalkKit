//
//  URLAttachmentTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class URLAttachmentTests: XCTestCase {
    
    func testExample() {
        let model = URLAttachment(data: json("model_urlattachment"))

        XCTAssertEqual(model.webUrl.absoluteString!, "https://typetalk.in/topics/208/posts/300/attachments/1/1.jpg")
        XCTAssertEqual(model.apiUrl.absoluteString!, "https://typetalk.in/api/v1/topics/208/posts/300/attachments/1/1.jpg")
        
        XCTAssertEqual(model.attachment.fileKey, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        XCTAssertEqual(model.attachment.fileName, "1.jpg")
        XCTAssertEqual(model.attachment.fileSize, 472263)
    }
}
