//
//  OAuth2ClientTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest
import TypetalkKit

class OAuth2ClientTests: TestCase {
    
    func testParseQuery() {
        let d1 = OAuth2Client.parseQuery(NSURL(string: "typetalkkit://success/?code=ci9em1jbpcqq5dgvdfox5ahvbonuj5ygbzd3mwrgknc6tedp8kuxyxqpgpg8gpe0"))
        let v1 = d1["code"]
        XCTAssertEqual(v1!, "ci9em1jbpcqq5dgvdfox5ahvbonuj5ygbzd3mwrgknc6tedp8kuxyxqpgpg8gpe0")
    }
}
