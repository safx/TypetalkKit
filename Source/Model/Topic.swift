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
    public let id: TopicID = 0
    public let name: String = ""
    public let suggestion: String = ""
    public let lastPostedAt: NSDate? = nil // set to nil when a topic is created.
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        id           <-- data["id"]
        name         <-- data["name"]
        suggestion   <-- data["suggestion"]
        lastPostedAt <-- (value: data["lastPostedAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
        createdAt    <-- (value: data["createdAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt    <-- (value: data["updatedAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}
