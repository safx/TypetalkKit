//
//  Post.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Post : Deserializable, ObjcBase {
    public let id: PostID = 0
    public let topicId: TopicID = 0
    public let topic: Topic? = nil
    public let replyTo: Int? = nil
    public let message: String = ""
    public let account: Account = Account()
    public let mention: String? = nil // FIXME
    public let attachments: [URLAttachment] = []
    public let likes: [Like] = []
    public let talks: [Talk] = []
    public let links: [Link] = []
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        id          <<<   data["id"]
        topicId     <<<   data["topicId"]
        topic       <<<<  data["topic"]
        replyTo     <<<   data["replyTo"]
        message     <<<   data["message"]
        account     <<<<  data["account"]
        mention     <<<   data["mention"]
        attachments <<<<* data["attachments"]
        likes       <<<<* data["likes"]
        talks       <<<<* data["talks"]
        links       <<<<* data["links"]
        createdAt   <<<   (value: data["createdAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt   <<<   (value: data["updatedAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}
