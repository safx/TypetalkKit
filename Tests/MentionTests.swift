//
//  MentionTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class MentionTests: XCTestCase {
    
    func testExample() {
        let model = try! decode(Mention.self, fromJsonFile: "model_mention")
        
        XCTAssertEqual(model.id, 501)
        XCTAssertEqual(model.readAt!.description, "2014-07-25 03:38:52 +0000")

        XCTAssertEqual(model.post!.id, 309)
        XCTAssertEqual(model.post!.topicId, 203)
        XCTAssertNil(model.post!.replyTo)
        XCTAssertEqual(model.post!.message, "@jessica Help me!")
        XCTAssertEqual(model.post!.account.id, 102)
        XCTAssertEqual(model.post!.account.name, "moss")
        XCTAssertEqual(model.post!.account.fullName, "Moss")
        XCTAssertEqual(model.post!.account.suggestion, "Moss")
        XCTAssertEqual(model.post!.account.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
        XCTAssertEqual(model.post!.account.createdAt.description, "2014-06-26 02:32:29 +0000")
        XCTAssertEqual(model.post!.account.updatedAt.description, "2014-06-26 02:32:29 +0000")
        XCTAssertEqual(model.post!.attachments?.count, 0)
        XCTAssertEqual(model.post!.createdAt.description, "2014-07-02 03:32:29 +0000")
        XCTAssertEqual(model.post!.updatedAt.description, "2014-07-02 03:32:29 +0000")
    }
}
