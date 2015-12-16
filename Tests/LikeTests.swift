//
//  LikeTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class LikeTests: XCTestCase {
    
    func testExample() {
        let model = try! Like.parseJSON(json("model_like"))
        
        XCTAssertEqual(model.id, 400)
        XCTAssertEqual(model.postId, 302)
        XCTAssertEqual(model.topicId, 208)
        XCTAssertNil(model.comment)
        XCTAssertEqual(model.account!.id, 100)
        XCTAssertEqual(model.account!.name, "jessica")
        XCTAssertEqual(model.account!.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(model.account!.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(model.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
        XCTAssertEqual(model.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
        XCTAssertEqual(model.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
    }
}
