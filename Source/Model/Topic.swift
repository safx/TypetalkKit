//
//  Topic.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/16.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Topic : Deserializable, ObjcBase {
    public let id: TopicID
    public let name: String
    public let suggestion: String
    public let lastPostedAt: NSDate? // set to nil when a topic is created.
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public required init(id: TopicID = 0, name: String = "", suggestion: String = "", lastPostedAt: NSDate? = nil, createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.name = name
        self.suggestion = suggestion
        self.lastPostedAt = lastPostedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: TopicID?
        var name: String?
        var suggestion: String?
        var lastPostedAt: NSDate?
        var createdAt: NSDate?
        var updatedAt: NSDate?

        id           <-- data["id"]
        name         <-- data["name"]
        suggestion   <-- data["suggestion"]
        lastPostedAt <-- (data["lastPostedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        createdAt    <-- (data["createdAt"]   , "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt    <-- (data["updatedAt"]   , "yyyy-MM-dd'T'HH:mm:ssZ")

        self.init(id: id ?? 0, name: name ?? "", suggestion: suggestion ?? "", lastPostedAt: lastPostedAt, createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate())
    }
}
