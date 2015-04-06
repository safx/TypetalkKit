//
//  PostMessageResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class PostMessageResponse : Deserializable, ObjcBase {
    public let topic: Topic? = nil
    public let post: Post? = nil

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        topic <-- data["topic"]
        post  <-- data["post"]
    }
}
