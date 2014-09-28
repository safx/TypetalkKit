//
//  TeamWithMembersTests.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/03.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import XCTest
import TypetalkKit

class TeamWithMembersTests: TestCase {

    func testExample() {
        var error: NSError? = nil
        let model = TeamWithMembers(dictionary: json("model_team_with_members"), error: &error)
        
        XCTAssertEqual(model.team!.id, 700)
        XCTAssertEqual(model.team!.name, "Nulab Inc.")
        XCTAssertEqual(model.team!.imageUrl.absoluteString!, "https://typetalk.in/teams/700/image.png?t=1402367549000")
        XCTAssertEqual(model.team!.createdAt.description, "2014-06-10 02:32:29 +0000")
        XCTAssertEqual(model.team!.updatedAt.description, "2014-06-10 02:32:29 +0000")

        XCTAssertEqual(countElements(model.members), 4)
        let last = model.members[3]
        XCTAssertEqual(last.account!.id, 103)
        XCTAssertEqual(last.account!.name, "stefhull")
        XCTAssertEqual(last.account!.fullName, "StefHull")
        XCTAssertEqual(last.account!.suggestion, "StefHull")
        XCTAssertEqual(last.account!.imageUrl.absoluteString!, "https://typetalk.in/accounts/103/profile_image.png?t=1403836349000")
        XCTAssertEqual(last.account!.createdAt.description, "2014-06-27 02:32:29 +0000")
        XCTAssertEqual(last.account!.updatedAt.description, "2014-06-27 02:32:29 +0000")
        XCTAssertEqual(last.role, "admin")
    }
}
