//
//  Unread.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Unread : Deserializable, ObjcBase {
    public let topicId: TopicID = 0
    public let postId: PostID = 0
    public let count: Int = 0

    public required init() {}

    public init(topicId: TopicID, postId: PostID, count: Int) {
        self.topicId = topicId
        self.postId = postId
        self.count = count
    }

    required public init(data: [String: AnyObject]) {
        topicId <-- data["topicId"]
        postId  <-- data["postId"]
        count   <-- data["count"]
    }
}
