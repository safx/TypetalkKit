//
//  PostLinksEvent.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/19.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class PostLinksEvent : Deserializable, ObjcBase {
    public let postId: PostID
    public let links: [Link]

    public required init(postId: PostID = 0, links: [Link] = []) {
        self.postId = postId
        self.links = links
    }

    required public convenience init(data: [String: AnyObject]) {
        var postId: PostID?
        var links: [Link]?

        postId <-- data["postId"]
        links  <-- data["links"]

        self.init(postId: postId ?? 0, links: links ?? [])
    }
}
