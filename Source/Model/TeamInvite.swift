//
//  TeamInvite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TeamInvite: Invite, Deserializable, ObjcBase {
    public let team: Team = Team()
    public let role: String = ""
    
    public required init() { super.init() }
    
    required public init(data: [String: AnyObject]) {
        super.init(data: data)
        team <<<< data["team"]
        role <<<  data["role"]
    }
}
