//
//  Unread.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Unread {
    public let topicId: TopicID = 0
    public let postId: PostID = 0
    public let count: Int = 0
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        for (k,v) in dictionaryValue {
            switch k {
            case "topicId": self.topicId = v as TopicID
            case "postId": self.postId = v as PostID
            case "count": self.count = v as Int
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
