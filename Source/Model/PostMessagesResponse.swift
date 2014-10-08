//
//  PostMessagesResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class PostMessagesResponse : ObjectSerializable {
    public let topic: Topic? = nil
    public let post: Post? = nil
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "topic": if let dic = v as? [NSObject : AnyObject] {
                self.topic = Topic(dictionary: dic, error: &err)
                }
            case "post": if let dic = v as? [NSObject : AnyObject] {
                self.post = Post(dictionary: dic, error: &err)
                }
                
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
