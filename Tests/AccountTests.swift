//
//  AccountTest.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/14.
//  Copyright (c) 2014年 Safx. All rights reserved.
//

import XCTest
@testable import TypetalkKit


class AccountTests: XCTestCase {

    func testProfile() {
        let model = try! decode(Account.self, fromJsonFile: "model_account")
        
        XCTAssertEqual(model.id, 102)
        XCTAssertEqual(model.name, "moss")
        XCTAssertEqual(model.fullName, "Moss")
        XCTAssertEqual(model.suggestion, "Moss")
        XCTAssertEqual(model.imageUrl.absoluteString, "https://typetalk.in/accounts/102/profile_image.png?t=1403749949000")
        XCTAssertEqual(model.createdAt.description, "2014-06-26 02:32:29 +0000")
        XCTAssertEqual(model.updatedAt.description, "2014-07-27 04:52:39 +0000")
    }
}
