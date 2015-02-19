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
    public let postId: PostID = 0
    public let links: [Link] = []

    public required init() {}

    required public init(data: [String: AnyObject]) {
        postId <<<   data["postId"]
        links  <<<<* data["links"]
    }
}
