//
//  TeamWithMembers.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/03.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TeamWithMembers : Deserializable, ObjcBase {
    public let team: Team
    public let members: [Member]
    
    required public init(team: Team = Team(), members: [Member] = []) {
        self.team = team
        self.members = members
    }

    required public convenience init(data: [String: AnyObject]) {
        var team: Team?
        var members: [Member]?
        
        team    <-- data["team"]
        members <-- data["members"]

        self.init(team: team ?? Team(), members: members ?? [])
    }
}
