//
//  Like.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Like {
    public let id: LikeID = 0
    public let postId: PostID = 0
    public let topicId: TopicID = 0
    public let comment: String? = nil
    public let account: Account? = nil
    
    public init() {}
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as LikeID
            case "postId": self.postId = v as PostID
            case "topicId": self.topicId = v as TopicID
            case "comment": if let s = v as? String { self.comment = s }
            case "account": if let dic = v as? [NSObject : AnyObject] {
                    self.account = Account(dictionary: dic, error: &err)
                }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
