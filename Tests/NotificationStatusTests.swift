//
//  NotificationStatusTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class NotificationStatusTests: TestCase {
    
    func testExample() {
        var error: NSError? = nil
        let model = NotificationStatus(dictionary: json("model_notification_status"), error: &error)
        
        XCTAssertEqual(model.unreadMentions!, 1)
        XCTAssertEqual(model.unopenedAccess!, 1)
        XCTAssertEqual(model.pendingTeamInvite!, 2)
        XCTAssertEqual(model.pendingTopicInvite!, 2)
    }
}
