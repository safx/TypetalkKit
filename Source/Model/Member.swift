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
    public let account: Account = Account()
    public let role: String = ""
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        account <-- data["account"]
        role    <-- data["role"]
    }
}
