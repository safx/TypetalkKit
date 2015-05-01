//
//  GetFriendsResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetFriendsResponse : Deserializable, ObjcBase {
    public let accounts: [Account]
    
    public init(accounts: [Account] = []) {
        self.accounts = accounts
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var accounts: [Account]?
        accounts <-- data["accounts"]

        self.init(accounts: accounts ?? [])
    }
}
