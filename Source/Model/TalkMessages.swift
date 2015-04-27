//
//  TalkMessages.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TalkMessages : Deserializable, ObjcBase {
    public let topic: Topic
    public let talk: Talk
    public let posts: [Post]
    public let hasNext: Bool

    required public init(topic: Topic = Topic(), talk: Talk = Talk(), posts: [Post] = [], hasNext: Bool = false) {
        self.topic = topic
        self.talk = talk
        self.posts = posts
        self.hasNext = hasNext
    }

    required public convenience init(data: [String: AnyObject]) {
        var topic: Topic?
        var talk: Talk?
        var posts: [Post]?
        var hasNext: Bool?

        topic   <-- data["topic"]
        talk    <-- data["talk"]
        posts   <-- data["posts"]
        hasNext <-- data["hasNext"]

        self.init(topic: topic ?? Topic(), talk: talk ?? Talk(), posts: posts ?? [], hasNext: hasNext ?? false)
    }
}
