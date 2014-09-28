//
//  Messages.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

// respons structure for get-messages
public class Messages {
    public let team: Team? = nil // TODO: remove '?'
    public let topic: Topic? = nil // TODO: remove '?'
    public let bookmark: Bookmark? = nil // TODO: remove '?'
    public let posts: [Post] = []
    public let hasNext: Bool = 0
    
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "team": if let dic = v as? [NSObject : AnyObject] {
                    self.team = Team(dictionary: dic, error: &err)
                }
            case "topic": if let dic = v as? [NSObject : AnyObject] {
                    self.topic = Topic(dictionary: dic, error: &err)
                }
            case "bookmark": if let dic = v as? [NSObject : AnyObject] {
                    self.bookmark = Bookmark(dictionary: dic, error: &err)
                }
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
