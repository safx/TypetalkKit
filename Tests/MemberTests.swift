//
//  MemberTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/03.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class MemberTests: XCTestCase {
    
    func testProfile() {
        var error: NSError? = nil
        let model = Member(dictionary: TestUtil.json("model_member"), error: &error)
        
        XCTAssertEqual(model.account!.id, 101)
        XCTAssertEqual(model.account!.name, "ahorowitz")
        XCTAssertEqual(model.account!.fullName, "AHorowitz")
        XCTAssertEqual(model.account!.suggestion, "AHorowitz")
        XCTAssertEqual(model.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/101/profile_image.png?t=1403663549000")
        XCTAssertEqual(model.account!.createdAt.description, "2014-06-25 02:32:29 +0000")
        XCTAssertEqual(model.account!.updatedAt.description, "2014-06-25 02:32:29 +0000")
        XCTAssertEqual(model.role, "admin")
    }
}
