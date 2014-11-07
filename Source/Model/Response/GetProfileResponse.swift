//
//  GetProfileResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class GetProfileResponse : Deserializable, ObjcBase {
    public let account = Account()
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        account <<<< data["account"]
    }
}
