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
    public let topicId: TopicID
    public let postId: PostID
    public let count: Int

    public required init(topicId: TopicID = 0, postId: PostID = 0, count: Int = 0) {
        self.topicId = topicId
        self.postId = postId
        self.count = count
    }

    required public convenience init(data: [String: AnyObject]) {
        var topicId: TopicID?
        var postId: PostID?
        var count: Int?

        topicId <-- data["topicId"]
        postId  <-- data["postId"]
        count   <-- data["count"]

        self.init(topicId: topicId ?? 0, postId: postId ?? 0, count: count ?? 0)
    }
}
