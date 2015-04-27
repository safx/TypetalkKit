//
//  TalkPost.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/16.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TalkPost : Deserializable, ObjcBase {
    public let topic: Topic
    public let talk: Talk
    public let postIds: [PostID]?

    required public init(topic: Topic = Topic(), talk: Talk = Talk(), postIds: [PostID]? = nil) {
        self.topic = topic
        self.talk = talk
        self.postIds = postIds
    }

    required public convenience init(data: [String: AnyObject]) {
        var topic: Topic?
        var talk: Talk?
        var postIds: [PostID]?

        topic   <-- data["topic"]
        talk    <-- data["talk"]
        postIds <-- data["postIds"]

        self.init(topic: topic ?? Topic(), talk: talk ?? Talk(), postIds: postIds)
    }
}
