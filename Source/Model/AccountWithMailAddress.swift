//
//  AccountWithMailAddress.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class AccountWithMailAddress : Deserializable, ObjcBase {
    public let account: Account = Account()
    public let mailAddress: String?

    required public init() {}

    required public init(data: [String: AnyObject]) {
        account     <-- data["account"]
        mailAddress <-- data["mailAddress"]
    }
}
