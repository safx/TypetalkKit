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

    required public init(mention: Mention? = nil, access: Access? = nil, invite: Invite? = nil) {
        self.mention = mention
        self.access = access
        self.invite = invite
    }

    required public convenience init(data: [String: AnyObject]) {
        var mention: Mention?
        var access: Access?
        var invite: Invite?

        mention <-- data["mention"]
        access  <-- data["access"]
        invite  <-- data["invite"]

        self.init(mention: mention, access: access, invite: invite)
    }

    // MARK: subclasses

    public class Mention : Deserializable {
        public let unread: Int?
        required public init(unread: Int? = nil) {
            self.unread = unread
        }
        required public convenience init(data: [String: AnyObject]) {
            var unread: Int?
            unread <-- data["unread"]
            self.init(unread: unread)
        }
    }

    public class Access : Deserializable {
        public let unopened: Int?
        required public init(unopened: Int? = nil) {
            self.unopened = unopened
        }
        required public convenience init(data: [String: AnyObject]) {
            var unopened: Int?
            unopened <-- data["unopened"]
            self.init(unopened: unopened)
        }
    }

    public class Invite : Deserializable {
        public let team: PendingCount?
        public let topic: PendingCount?
        required public init(team: PendingCount? = nil, topic: PendingCount? = nil) {
            self.team = team
            self.topic = topic
        }
        required public convenience init(data: [String: AnyObject]) {
            var team: PendingCount?
            var topic: PendingCount?
            team  <-- data["team"]
            topic <-- data["topic"]
            self.init(team: team, topic: topic)
        }

        public class PendingCount : Deserializable {
            public let pending: Int?
            required public init(pending: Int? = nil) {
                self.pending = pending
            }
            required public convenience init(data: [String: AnyObject]) {
                var pending: Int?
                pending <-- data["pending"]
                self.init(pending: pending)
            }
        }
    }
}
