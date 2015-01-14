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
    public let accounts: [AccountWithOnlineStatus] = []
    public let pendings: [AccountWithMailAddress] = []
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        accounts <<<<* data["accounts"]
        pendings <<<<* data["pendings"]
    }
}
