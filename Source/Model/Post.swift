//
//  Post.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Post {
    public let id: PostID = 0
    public let topicId: TopicID = 0
    public let topic: Topic? = nil
    public let replyTo: Int? = nil
    public let message: String = ""
    public let account: Account? = nil // TODO: remove '?'
    public let mention: String? = nil // FIXME
    public let attachments: [URLAttachment] = []
    public let likes: [Like] = []
    public let talks: [Talk] = []
    public let links: [Link] = []
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()

    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as PostID
            case "topicId": self.topicId = v as TopicID
            case "topic": if let dic = v as? [NSObject : AnyObject] {
                    self.topic = Topic(dictionary: dic, error: &err)
                }
            case "replyTo": if let r = v as? Int { self.replyTo = r }
            case "message": self.message = v as String
            case "account": if let dic = v as? [NSObject : AnyObject] {
                    self.account = Account(dictionary: dic, error: &err)
                }
            case "mention": let pass = 0 // FIXME
            case "attachments": self.attachments = $.array(v) { (i) -> URLAttachment? in
                    let obj = URLAttachment(dictionary: i, error: &err)
                    return err == nil ? obj : nil
                }
            case "likes": self.likes = $.array(v) { (i) -> Like? in
                    let obj = Like(dictionary: i, error: &err)
                    return err == nil ? obj : nil
                }
            case "talks": self.talks = $.array(v) { (i) -> Talk? in
                    let obj = Talk(dictionary: i, error: &err)
                    return err == nil ? obj : nil
                }
            case "links": self.links = $.array(v) { (i) -> Link? in
                    let obj = Link(dictionary: i, error: &err)
                    return err == nil ? obj : nil
                }
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)

            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
