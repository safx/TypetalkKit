//
//  Member.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/03.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Member : Deserializable, ObjcBase {
    public let account: Account
    public let role: String
    
    public required init(account: Account = Account(), role: String = "") {
        self.account = account
        self.role = role
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var account: Account?
        var role: String?

        account <-- data["account"]
        role    <-- data["role"]

        self.init(account: account ?? Account(), role: role ?? "")
    }
}
