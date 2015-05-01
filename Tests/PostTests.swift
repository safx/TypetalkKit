//
//  PostTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class PostTests: XCTestCase {
    
    func testExample() {
        let model = Post(data: json("model_post"))
        
        XCTAssertEqual(model.id, 300)
        XCTAssertEqual(model.topicId, 208)
        XCTAssertNil(model.replyTo)
        XCTAssertEqual(model.message, "Here's an example of a link and images. http://nulab-inc.com")

        XCTAssertEqual(model.account.id, 103)
        XCTAssertEqual(model.account.name, "stefhull")
        XCTAssertEqual(model.account.fullName, "StefHull")
        XCTAssertEqual(model.account.suggestion, "StefHull")
        XCTAssertEqual(model.account.imageUrl.absoluteString!, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
        XCTAssertEqual(model.account.createdAt.description, "2014-06-27 02:32:29 +0000")
        XCTAssertEqual(model.account.updatedAt.description, "2014-06-27 02:32:29 +0000")

        XCTAssertNil(model.mention)

        XCTAssertEqual(count(model.attachments), 4)
        XCTAssertEqual(count(model.likes), 0)
        XCTAssertEqual(count(model.talks), 0)
        XCTAssertEqual(count(model.links), 1)

        XCTAssertEqual(model.createdAt.description, "2014-06-29 00:32:29 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-06-29 00:32:29 +0000")
    }
}
