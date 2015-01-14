//
//  TopicInvite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TopicInvite: Invite, Deserializable, ObjcBase {
    public let topic: Topic = Topic()
    
    public required init() { super.init() }
    
    required public init(data: [String: AnyObject]) {
        super.init(data: data)
        topic <<<< data["topic"]
    }
}
