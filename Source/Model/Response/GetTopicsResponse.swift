//
//  GetTopicsResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetTopicsResponse : Deserializable, ObjcBase {
    public let topics: [TopicWithUserInfo] = []
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        topics <<<<* data["topics"]
    }
}
