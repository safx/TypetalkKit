//
//  Bookmark.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Bookmark : ObjectSerializable {
    public let postId: PostID = 0
    public let updatedAt: NSDate = NSDate()
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        for (k,v) in dictionaryValue {
            switch k {
            case "postId": self.postId = v as PostID
            case "updatedAt": self.updatedAt = $.date(v)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
