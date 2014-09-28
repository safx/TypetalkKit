//
//  TalkMessages.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TalkMessages {
    public let topic: Topic? // FIXME
    public let talk: Talk? // FIXME
    public let posts: [Post] = []
    public let hasNext: Bool = 0
    
    public init() {}
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "topic": self.topic = Topic(dictionary: v as [NSObject : AnyObject], error: &err)
            case "talk": self.talk = Talk(dictionary: v as [NSObject : AnyObject], error: &err)
            case "posts": self.posts = $.array(v) { (i) -> Post? in
                let obj = Post(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            case "hasNext": self.hasNext = v as Bool
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
