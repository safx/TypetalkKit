//
//  AccessTokenTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class AccessTokenTests: XCTestCase {

    func testProfile() {
        var error: NSError? = nil
        let model = OAuth2Credential(dictionary: json("model_access_token"), error: &error)
        
        XCTAssertEqual(model.accessToken, "@YOUR_ACCESS_TOKEN")
        XCTAssertEqual(model.tokenType, "Bearer")
        //XCTAssertEqual(model.expiryDate, 3600)
        XCTAssertEqual(model.refreshToken, "@YOUR_REFRESH_TOKEN")

        XCTAssertEqual(model.scopes.count, 2)
        XCTAssertEqual(model.scopes.filter({ $0 == Scope.my }).count, 1)
        XCTAssertEqual(model.scopes.filter({ $0 == Scope.topic_read }).count, 1)
    }
}
