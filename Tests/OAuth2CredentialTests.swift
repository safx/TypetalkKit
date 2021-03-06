//
//  AccessTokenTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class AccessTokenTests: XCTestCase {

    func testProfile() {
        let model = try! decode(OAuth2Credential.self, fromJsonFile: "model_access_token")
        
        XCTAssertEqual(model.accessToken, "@YOUR_ACCESS_TOKEN")
        XCTAssertEqual(model.tokenType, "Bearer")
        XCTAssertEqual(model.expiryIn, 3600)
        XCTAssertEqual(model.refreshToken, "@YOUR_REFRESH_TOKEN")

        //XCTAssertEqual(model.scopes.count, 2)
        //XCTAssertEqual(model.scopes.filter({ $0 == Scope.my }).count, 1)
        //XCTAssertEqual(model.scopes.filter({ $0 == Scope.topic_read }).count, 1)
    }
}
