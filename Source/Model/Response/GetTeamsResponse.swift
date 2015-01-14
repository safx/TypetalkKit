//
//  GetTeamsResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetTeamsResponse : Deserializable, ObjcBase {
    public let teams: [TeamWithCount] = []
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        teams <<<<* data["teams"]
    }
}

