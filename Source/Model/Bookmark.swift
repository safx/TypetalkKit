//
//  Bookmark.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Bookmark : Deserializable, ObjcBase {
    public let postId: PostID
    public let updatedAt: NSDate

    public init(postId: PostID = 0, updatedAt: NSDate = NSDate()) {
        self.postId = postId
        self.updatedAt = updatedAt
    }

    required public convenience init(data: [String: AnyObject]) {
        var postId: PostID?
        var updatedAt: NSDate?
        
        postId    <-- data["postId"]
        updatedAt <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")

        self.init(postId: postId ?? 0, updatedAt: updatedAt ?? NSDate())
    }
}
