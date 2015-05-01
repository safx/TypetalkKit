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
    public let topic: Topic
    public let favorite: Bool
    public let unread: Unread?

    public init(topic: Topic = Topic(), favorite: Bool = false, unread: Unread? = nil) {
        self.topic = topic
        self.favorite = favorite
        self.unread = unread
    }

    required public convenience init(data: [String: AnyObject]) {
        var topic: Topic?
        var favorite: Bool?
        var unread: Unread?

        topic    <-- data["topic"]
        favorite <-- data["favorite"]
        unread   <-- data["unread"]

        self.init(topic: topic ?? Topic(), favorite: favorite ?? false, unread: unread)
    }
}
