//
//  NSDate+TypetalkKitAddtionTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import XCTest

class NSDate_TypetalkKitAddtionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // TODO: check other locales
    func testHumanReadableTimeInterval() {
        let now = NSDate()

        XCTAssertEqual("1 minute ago", now.humanReadableTimeInterval(sinceDate: now))
        XCTAssertEqual("5 minutes ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*5, sinceDate: now)))

        XCTAssertEqual("1 hour ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*60*1, sinceDate: now)))
        XCTAssertEqual("1 hour ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*60*1.5, sinceDate: now)))
        XCTAssertEqual("3 hours ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*60*3, sinceDate: now)))

        XCTAssertEqual("1 day ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*60*24, sinceDate: now)))
        XCTAssertEqual("1 day ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*60*25, sinceDate: now)))
        XCTAssertEqual("2 days ago", now.humanReadableTimeInterval(sinceDate: NSDate(timeInterval: -60*60*24*2, sinceDate: now)))

        XCTAssertEqual("Jan 3 1970", now.humanReadableTimeInterval(sinceDate: NSDate(timeIntervalSince1970: 60*60*24*2)))
    }

}
