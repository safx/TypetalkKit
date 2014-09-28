//
//  DetailedMessage.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/01.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

// respons structure for get-message
public class DetailedMessage {
    public let team: Team? = nil // TODO: remove '?'
    public let topic: Topic? = nil // TODO: remove '?'
    public let post: Post? = nil // TODO: remove '?'
    public let replies: [Post] = []
    
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
            case "post": if let dic = v as? [NSObject : AnyObject] {
                    self.post = Post(dictionary: dic, error: &err)
                }
            case "replies": self.replies = $.array(v) { (i) -> Post? in
                    let obj = Post(dictionary: i, error: &err)
                    return err == nil ? obj : nil
                }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
