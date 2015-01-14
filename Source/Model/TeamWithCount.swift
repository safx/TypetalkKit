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
    public let team: Team = Team()
    public let memberCount: Int = 0

    required public init() {}

    required public init(data: [String: AnyObject]) {
        team        <<<< data["team"]
        memberCount <<<  data["memberCount"]
    }
}
