//
//  Mention.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Mention : Deserializable, ObjcBase {
    public let id: MentionID
    public let readAt: NSDate?
    public let post: Post?

    required public init(id: MentionID = 0, readAt: NSDate? = nil, post: Post? = nil) {
        self.id = id
        self.readAt = readAt
        self.post = post
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: MentionID?
        var readAt: NSDate?
        var post: Post?

        id     <-- data["id"]
        readAt <-- (data["readAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        post   <-- data["post"]

        self.init(id: id ?? 0, readAt: readAt, post: post)
    }
}
