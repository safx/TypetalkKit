//
//  Notifications.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Notifications : Deserializable, ObjcBase {
    public let mentions: [Mention] = []
    public let invites = Invites()
    
    public required init() {}

    required public init(data: [String: AnyObject]) {
        mentions <-- data["mentions"]
        invites  <-- data["invites"]
    }

    // MARK: subclass
    
    public class Invites : Deserializable, ObjcBase {
        public let teams: [TeamInvite] = []
        public let topics: [TopicInvite] = []
    
        public required init() {}
   
        required public init(data: [String: AnyObject]) {
            teams  <-- data["teams"]
            topics <-- data["topics"]
        }
    }
}
