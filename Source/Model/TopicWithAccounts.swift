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
    public let topic: Topic = Topic()
    public let teams: [TeamWithMembers] = []
    public let accounts: [Account] = []
    public let invites: [TopicInvite] = []

    required public init() {}

    required public init(data: [String: AnyObject]) {
        topic    <<<<  data["topic"]
        teams    <<<<* data["teams"]
        accounts <<<<* data["accounts"]
        invites  <<<<* data["invites"]
    }
}
