//
//  Bookmark.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Bookmark : Deserializable, ObjcBase {
    public let postId: PostID = 0
    public let updatedAt: NSDate = NSDate()

    required public init() {}

    required public init(data: [String: AnyObject]) {
        postId    <<< data["postId"]
        updatedAt <<< (value: data["updatedAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}