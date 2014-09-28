//
//  LinkTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class LinkTests: TestCase {
    
    func testProfile() {
        var error: NSError? = nil
        let model = Link(dictionary: json("model_link"), error: &error)
        
        XCTAssertEqual(model.id, 105)
        XCTAssertEqual(model.url.absoluteString!, "http://nulab-inc.com")
        XCTAssertEqual(model.contentType, "text/html; charset=UTF-8")
        XCTAssertEqual(model.title, "Fun. Creative. Collaboration. | Nulab Inc.")
        XCTAssertEqual(model.description, "We develop collaborative software tools aimed at facilitating effective work communication and collaboration.")
        XCTAssertEqual(model.imageUrl.absoluteString!, "http://nulab-inc.com/ogp_dft.png")
        XCTAssertEqual(model.createdAt.description, "2014-07-25 03:38:34 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-07-25 03:38:34 +0000")
    }
}
