//
//  NotificationStatus.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class NotificationStatus : Deserializable, ObjcBase {
    public let mention: Mention?
    public let access: Access?
    public let invite: Invite?
    
    required public init() {}
    
    required public init(data: [String: AnyObject]) {
        mention <<<< data["mention"]
        access  <<<< data["access"]
        invite  <<<< data["invite"]
    }

    // MARK: subclasses

    public class Mention : Deserializable {
        public let unread: Int?
        required public init() {}
        required public init(data: [String: AnyObject]) {
            unread <<< data["unread"]
        }
    }

    public class Access : Deserializable {
        public let unopened: Int?
        required public init() {}
        required public init(data: [String: AnyObject]) {
            unopened <<< data["unopened"]
        }
    }

    public class Invite : Deserializable {
        public let team: PendingCount?
        public let topic: PendingCount?
        required public init() {}
        required public init(data: [String: AnyObject]) {
            team  <<<< data["team"]
            topic <<<< data["topic"]
        }
        
        public class PendingCount : Deserializable {
            public let pending: Int?
            required public init() {}
            required public init(data: [String: AnyObject]) {
                pending <<< data["pending"]
            }
        }
    }
}
