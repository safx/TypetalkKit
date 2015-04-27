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
    public let account: Account
    public let mailAddress: String?

    public init(account: Account = Account(), mailAddress: String? = nil) {
        self.account = account
        self.mailAddress = mailAddress
    }

    required public convenience init(data: [String: AnyObject]) {
        var account: Account?;
        var mailAddress: String?

        account     <-- data["account"] ?? Account()
        mailAddress <-- data["mailAddress"] ?? ""

        if let a = account {
            self.init(account: a, mailAddress: mailAddress)
        } else {
            fatalError()
        }
    }
}
