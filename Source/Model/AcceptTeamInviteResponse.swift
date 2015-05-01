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
    public let topics: [Topic]
    public let invite: TeamInvite?

    required public init(topics: [Topic] = [], invite: TeamInvite? = nil) {
        self.topics = topics
        self.invite = invite
    }

    required public convenience init(data: [String: AnyObject]) {
        var topics: [Topic]?
        var invite: TeamInvite?

        topics <-- data["topics"]
        invite <-- data["invite"]

        self.init(topics: topics ?? [], invite: invite)
    }
}
