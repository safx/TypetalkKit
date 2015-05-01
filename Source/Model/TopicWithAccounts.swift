//
//  TopicWithAccounts.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/04.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TopicWithAccounts : Deserializable, ObjcBase {
    public let topic: Topic
    public let teams: [TeamWithMembers]
    public let accounts: [Account]
    public let invites: [TopicInvite]

    required public init(topic: Topic = Topic(), teams: [TeamWithMembers] = [], accounts: [Account] = [], invites: [TopicInvite] = []) {
        self.topic = topic
        self.teams = teams
        self.accounts = accounts
        self.invites = invites
    }

    required public convenience init(data: [String: AnyObject]) {
        var topic: Topic?
        var teams: [TeamWithMembers]?
        var accounts: [Account]?
        var invites: [TopicInvite]?

        topic    <-- data["topic"]
        teams    <-- data["teams"]
        accounts <-- data["accounts"]
        invites  <-- data["invites"]

        self.init(topic: topic ?? Topic(), teams: teams ?? [],  accounts: accounts ?? [], invites: invites ?? [])
    }
}
