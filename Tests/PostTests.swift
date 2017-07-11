//
//  PostTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class PostTests: XCTestCase {
    
    func testExample() {
        let model = try! Post.parse(with: json("model_post"))

        XCTAssertEqual(model.id, 300)
        XCTAssertEqual(model.topicId, 208)
        XCTAssertNil(model.replyTo)
        XCTAssertEqual(model.message, "Here's an example of a link and images. http://nulab-inc.com")

        XCTAssertEqual(model.account.id, 103)
        XCTAssertEqual(model.account.name, "stefhull")
        XCTAssertEqual(model.account.fullName, "StefHull")
        XCTAssertEqual(model.account.suggestion, "StefHull")
        XCTAssertEqual(model.account.imageUrl.absoluteString, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
        XCTAssertEqual(model.account.createdAt.description, "2014-06-27 02:32:29 +0000")
        XCTAssertEqual(model.account.updatedAt.description, "2014-06-27 02:32:29 +0000")

        //XCTAssertNil(model.mention)

        XCTAssertEqual((model.attachments).count, 4)
        XCTAssertEqual((model.likes).count, 0)
        XCTAssertEqual((model.talks).count, 0)
        XCTAssertEqual((model.links).count, 1)

        XCTAssertEqual(model.createdAt.description, "2014-06-29 00:32:29 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-06-29 00:32:29 +0000")
    }
}
