//
//  GetTopicMembersResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetTopicMembersResponse : Deserializable, ObjcBase {
    public let accounts: [AccountWithOnlineStatus]
    public let pendings: [AccountWithMailAddress]

    required public init(accounts: [AccountWithOnlineStatus] = [], pendings: [AccountWithMailAddress] = []) {
        self.accounts = accounts
        self.pendings = pendings
    }

    required public convenience init(data: [String: AnyObject]) {
        var accounts: [AccountWithOnlineStatus]?
        var pendings: [AccountWithMailAddress]?

        accounts <-- data["accounts"]
        pendings <-- data["pendings"]

        self.init(accounts: accounts ?? [], pendings: pendings ?? [])
    }
}
