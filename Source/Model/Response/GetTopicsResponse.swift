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
    public let topics: [TopicWithUserInfo]
    
    public required init(topics: [TopicWithUserInfo] = []) {
        self.topics = topics
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var topics: [TopicWithUserInfo]?
        topics <-- data["topics"]
        self.init(topics: topics ?? [])
    }
}
