//
//  NotificationStatus.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class NotificationStatus : ObjectSerializable {
    public let unreadMentions: Int?
    public let unopenedAccess: Int?
    public let pendingTeamInvite: Int?
    public let pendingTopicInvite: Int?
    
    public init() {}
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        if let v = dictionaryValue["mention"] as? NSDictionary {
            if let x = v["unread"] as? Int { self.unreadMentions = x }
        }
        if let v = dictionaryValue["access"] as? NSDictionary {
            if let x = v["unopened"] as? Int { self.unopenedAccess = x }
        }
        if let w = dictionaryValue["invite"] as? NSDictionary {
            if let v = w["team"] as? NSDictionary {
                if let x = v["pending"] as? Int { self.pendingTeamInvite = x }
            }
            if let v = w["topic"] as? NSDictionary {
                if let x = v["pending"] as? Int { self.pendingTopicInvite = x }
            }
        }
    }
}
