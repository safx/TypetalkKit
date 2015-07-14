//
//  NotificationStatusTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class NotificationStatusTests: XCTestCase {
    
    func testExample() {
        let model = try! NotificationStatus.parseJSON(json("model_notification_status"))
        
        XCTAssertEqual(model.mention!.unread!, 1)
        XCTAssertEqual(model.access!.unopened!, 1)
        XCTAssertEqual(model.invite!.team!.pending!, 2)
        XCTAssertEqual(model.invite!.topic!.pending!, 2)
    }
}
