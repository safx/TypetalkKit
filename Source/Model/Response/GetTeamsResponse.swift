//
//  GetTeamsResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetTeamsResponse : Deserializable, ObjcBase {
    public let teams: [TeamWithCount]
    
    required public init(teams: [TeamWithCount] = []) {
        self.teams = teams
    }

    required public convenience init(data: [String: AnyObject]) {
        var teams: [TeamWithCount]?
        teams <-- data["teams"]
        self.init(teams: teams ?? [])
    }
}

