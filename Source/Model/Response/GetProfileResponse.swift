//
//  GetProfileResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetProfileResponse : Deserializable, ObjcBase {
    public let account: Account
    
    public required init(account: Account = Account()) {
        self.account = account
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var account: Account?
        account <-- data["account"]
        self.init(account: account ?? Account())
    }
}
