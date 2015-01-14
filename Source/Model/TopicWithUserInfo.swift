//
//  TopicWithUserInfo.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TopicWithUserInfo : Deserializable, ObjcBase {
    public let topic: Topic = Topic()
    public let favorite: Bool = false
    public let unread: Unread? = nil
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        topic    <<<< data["topic"]
        favorite <<<  data["favorite"]
        unread   <<<< data["unread"]
    }
}
