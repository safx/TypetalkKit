//
//  AcceptTeamInviteResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class AcceptTeamInviteResponse : Deserializable, ObjcBase {
    public let topics: [Topic] = []
    public let invite: TeamInvite? = nil
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        topics <<<<* data["topics"]
        invite <<<<  data["invite"]
    }
}
