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
    public let topic: Topic?
    public let post: Post?

    public required init(topic: Topic? = nil, post: Post? = nil) {
        self.topic = topic
        self.post = post
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var topic: Topic?
        var post: Post?

        topic <-- data["topic"]
        post  <-- data["post"]

        self.init(topic: topic, post: post)
    }
}
