//
//  TeamWithCount.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/13.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TeamWithCount : Deserializable, ObjcBase {
    public let team: Team
    public let memberCount: Int

    required public init(team: Team = Team(), memberCount: Int = 0) {
        self.team = team
        self.memberCount = memberCount
    }

    required public convenience init(data: [String: AnyObject]) {
        var team: Team?
        var memberCount: Int?

        team        <-- data["team"]
        memberCount <-- data["memberCount"]

        self.init(team: team ?? Team(), memberCount: memberCount ?? 0)
    }
}
