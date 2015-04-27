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
    public let mentions: [Mention]
    public let invites: Invites

    public required init(mentions: [Mention] = [], invites:Invites = Invites()) {
        self.mentions = mentions
        self.invites = invites
    }

    required public convenience init(data: [String: AnyObject]) {
        var mentions: [Mention]?
        var invites: Invites?

        mentions <-- data["mentions"]
        invites  <-- data["invites"]

        self.init(mentions: mentions ?? [], invites: invites ?? Invites())
    }

    // MARK: subclass

    public class Invites : Deserializable, ObjcBase {
        public let teams: [TeamInvite]
        public let topics: [TopicInvite]

        public required init(teams: [TeamInvite] = [], topics: [TopicInvite] = []) {
            self.teams = teams
            self.topics = topics
        }

        required public convenience init(data: [String: AnyObject]) {
            var teams: [TeamInvite]?
            var topics: [TopicInvite]?

            teams  <-- data["teams"]
            topics <-- data["topics"]

            self.init(teams: teams ?? [], topics: topics ?? [])
        }
    }
}
