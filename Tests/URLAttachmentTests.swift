//
//  URLAttachmentTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class URLAttachmentTests: XCTestCase {

    func testExample() {
        let model = try! URLAttachment.parseJSON(json("model_urlattachment"))

        XCTAssertEqual(model.webUrl.absoluteString, "https://typetalk.in/topics/208/posts/300/attachments/1/1.jpg")
        XCTAssertEqual(model.apiUrl.absoluteString, "https://typetalk.in/api/v1/topics/208/posts/300/attachments/1/1.jpg")

        XCTAssertEqual(model.attachment.fileKey, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        XCTAssertEqual(model.attachment.fileName, "1.jpg")
        XCTAssertEqual(model.attachment.fileSize, 472263)

        XCTAssertEqual((model.thumbnails).count, 3)
        XCTAssertEqual(model.thumbnails[0].type.rawValue, "small")
        XCTAssertEqual(model.thumbnails[0].fileSize, 16842)
        XCTAssertEqual(model.thumbnails[0].width, 480)
        XCTAssertEqual(model.thumbnails[0].height, 360)

        XCTAssertEqual(model.thumbnails[1].type.rawValue, "medium")
        XCTAssertEqual(model.thumbnails[1].fileSize, 23714)
        XCTAssertEqual(model.thumbnails[1].width, 800)
        XCTAssertEqual(model.thumbnails[1].height, 600)

        XCTAssertEqual(model.thumbnails[2].type.rawValue, "large")
        XCTAssertEqual(model.thumbnails[2].fileSize, 41130)
        XCTAssertEqual(model.thumbnails[2].width, 1024)
        XCTAssertEqual(model.thumbnails[2].height, 768)
    }
}
