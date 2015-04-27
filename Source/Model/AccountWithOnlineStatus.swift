//
//  AccountWithOnlineStatus.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class AccountWithOnlineStatus : Deserializable, ObjcBase {
    public let account: Account
    public let online: Bool
    
    public init(account: Account = Account(), online: Bool = false) {
        self.account = account
        self.online = online
    }

    required public convenience init(data: [String: AnyObject]) {
        var account: Account?
        var online: Bool?

        account <-- data["account"]
        online  <-- data["online"]

        self.init(account: account ?? Account(), online: online ?? false)
    }
}
