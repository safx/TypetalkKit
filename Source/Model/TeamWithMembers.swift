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
    public let team: Team = Team()
    public let members: [Member] = []
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        team    <<<<  data["team"]
        members <<<<* data["members"]
    }
}
