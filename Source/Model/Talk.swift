//
//  Talk.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Talk : Deserializable, ObjcBase {
    public let id: TalkID
    public let topicId: TopicID
    public let name: String
    public let suggestion: String
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public required init(id: TalkID = 0, topicId: TopicID = 0, name: String = "", suggestion: String = "", createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.topicId = topicId
        self.name = name
        self.suggestion = suggestion
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: TalkID?
        var topicId: TopicID?
        var name: String?
        var suggestion: String?
        var createdAt: NSDate?
        var updatedAt: NSDate?

        id         <-- data["id"]
        topicId    <-- data["topicId"]
        name       <-- data["name"]
        suggestion <-- data["suggestion"]
        createdAt  <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt  <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")

        self.init(id: id ?? 0, topicId: topicId ?? 0, name: name ?? "", suggestion: suggestion ?? "", createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate())
    }
}
