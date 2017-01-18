//
//  OAuth2RouterTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
@testable import TypetalkKit

class OAuth2RouterTests: XCTestCase {
    func testAuthorize() {
        let req = try! Authorize(client_id: "aaaa", redirect_uri: "http://example.com/typetalk", scope: [Scope.my, Scope.topic_read].description).buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "GET")
        XCTAssertEqual(req.url!.host!, "typetalk.in")
        XCTAssertEqual(req.url!.path, "/oauth2/authorize")
    }

    func testRequestRefreshToken() {
        let req = try! AccessToken(grant_type: .RefreshToken, client_id: "bbb", client_secret: "ccc").buildURLRequest()
        XCTAssertEqual(req.httpMethod!, "POST")
        XCTAssertEqual(req.url!.absoluteString, "https://typetalk.in/oauth2/access_token")
    }
}
