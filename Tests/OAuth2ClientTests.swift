//
//  OAuth2ClientTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
@testable import TypetalkKit

class OAuth2ClientTests: XCTestCase {
    
    func testParseQuery() {
        let d1 = TypetalkAPI.parseQuery(URL(string: "typetalkkit://success/?code=ci9em1jbpcqq5dgvdfox5ahvbonuj5ygbzd3mwrgknc6tedp8kuxyxqpgpg8gpe0")!)
        let v1 = d1["code"]
        XCTAssertEqual(v1!, "ci9em1jbpcqq5dgvdfox5ahvbonuj5ygbzd3mwrgknc6tedp8kuxyxqpgpg8gpe0")
    }
}
