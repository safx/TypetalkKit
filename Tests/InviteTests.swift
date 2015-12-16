//
//  InviteTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
@testable import TypetalkKit

class InviteTests: XCTestCase {
    
    func testTeamInvite() {
        let model = try! Invite.parseJSON(json("model_team_invite"))
        
        XCTAssertEqual(model.id, 800)
        XCTAssertEqual(model.team!.id, 702)

        XCTAssertEqual(model.sender!.id, 106)
        XCTAssertEqual(model.sender!.name, "chelseab")
        XCTAssertEqual(model.sender!.fullName, "ChelseaB")
        XCTAssertEqual(model.sender!.suggestion, "ChelseaB")
        XCTAssertEqual(model.sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/106/profile_image.png?t=1404095549000")
        XCTAssertEqual(model.sender!.createdAt.description, "2014-06-30 02:32:29 +0000")
        XCTAssertEqual(model.sender!.updatedAt.description, "2014-06-30 02:32:29 +0000")

        XCTAssertEqual(model.account!.id, 100)
        XCTAssertEqual(model.account!.name, "jessica")
        XCTAssertEqual(model.account!.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(model.account!.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(model.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
        XCTAssertEqual(model.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
        XCTAssertEqual(model.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")

        // FIXME XCTAssertEqual(model.role, "member")
        XCTAssertEqual(model.message, "Hello. Please join us.")
        XCTAssertEqual(model.createdAt!.description, "2014-07-01 03:32:29 +0000")
        XCTAssertEqual(model.updatedAt!.description, "2014-07-25 03:38:53 +0000")
    }

    func testTopicInvite() {
        let model = try! Invite.parseJSON(json("model_topic_invite"))
        
        XCTAssertEqual(model.id, 601)
        XCTAssertEqual(model.topic!.id, 210)
        XCTAssertEqual(model.topic!.name, "Development")
        XCTAssertEqual(model.topic!.suggestion, "Development")
        
        XCTAssertEqual(model.sender!.id, 105)
        XCTAssertEqual(model.sender!.name, "brad")
        XCTAssertEqual(model.sender!.fullName, "BradMarshalls")
        XCTAssertEqual(model.sender!.suggestion, "BradMarshalls")
        XCTAssertEqual(model.sender!.imageUrl.absoluteString, "https://typetalk.in/accounts/105/profile_image.png?t=1404009149000")
        XCTAssertEqual(model.sender!.createdAt.description, "2014-06-29 02:32:29 +0000")
        XCTAssertEqual(model.sender!.updatedAt.description, "2014-06-29 02:32:29 +0000")
        
        XCTAssertEqual(model.account!.id, 100)
        XCTAssertEqual(model.account!.name, "jessica")
        XCTAssertEqual(model.account!.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(model.account!.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(model.account!.imageUrl.absoluteString, "https://typetalk.in/accounts/100/profile_image.png?t=1403577149000")
        XCTAssertEqual(model.account!.createdAt.description, "2014-06-24 02:32:29 +0000")
        XCTAssertEqual(model.account!.updatedAt.description, "2014-06-24 02:32:29 +0000")
        
        XCTAssertEqual(model.message, "It is a new project. Join us!")
        XCTAssertEqual(model.createdAt!.description, "2014-07-04 02:32:29 +0000")
        XCTAssertEqual(model.updatedAt!.description, "2014-07-04 02:32:29 +0000")
    }
}
