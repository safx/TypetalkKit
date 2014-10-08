//
//  TeamTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class TeamTests: XCTestCase {
    
    func testExample() {
        var error: NSError? = nil
        let model = Team(dictionary: TestUtil.json("model_team"), error: &error)
        
        XCTAssertEqual(model.id, 702)
        XCTAssertEqual(model.name, "Cycling team")
        XCTAssertEqual(model.imageUrl.absoluteString!, "https://typetalk.in/teams/702/image.png?t=1402540349000")
        XCTAssertEqual(model.createdAt.description, "2014-06-12 02:32:29 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-08-22 22:52:59 +0000")
    }
}
