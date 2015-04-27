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
    public let id: PostID
    public let topicId: TopicID
    public let topic: Topic?
    public let replyTo: Int?
    public let message: String
    public let account: Account
    public let mention: String?
    public let attachments: [URLAttachment]
    public let likes: [Like]
    public let talks: [Talk]
    public let links: [Link]
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public init(id: PostID = 0, topicId: TopicID = 0, topic: Topic? = nil, replyTo: Int? = nil, message: String = "", account: Account = Account(), mention: String? = nil, attachments: [URLAttachment] = [], likes: [Like] = [], talks: [Talk] = [], links: [Link] = [], createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.topicId = topicId
        self.topic = topic
        self.replyTo = replyTo
        self.message = message
        self.account = account
        self.mention = mention
        self.attachments = attachments
        self.likes = likes
        self.talks = talks
        self.links = links
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: PostID?
        var topicId: TopicID?
        var topic: Topic?
        var replyTo: Int?
        var message: String?
        var account: Account?
        var mention: String?
        var attachments: [URLAttachment]?
        var likes: [Like]?
        var talks: [Talk]?
        var links: [Link]?
        var createdAt: NSDate?
        var updatedAt: NSDate?

        id          <-- data["id"]
        topicId     <-- data["topicId"]
        topic       <-- data["topic"]
        replyTo     <-- data["replyTo"]
        message     <-- data["message"]
        account     <-- data["account"]
        mention     <-- data["mention"]
        attachments <-- data["attachments"]
        likes       <-- data["likes"]
        talks       <-- data["talks"]
        links       <-- data["links"]
        createdAt   <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt   <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")

        self.init(id: id ?? 0, topicId: topicId ?? 0, topic: topic, replyTo: replyTo, message: message ?? "", account: account ?? Account(), mention: mention, attachments: attachments ?? [], likes: likes ?? [], talks: talks ?? [], links: links ?? [], createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate())
    }
}
