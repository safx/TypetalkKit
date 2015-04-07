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
    public let id: TalkID = 0
    public let topicId: TopicID = 0
    public let name: String = ""
    public let suggestion: String = ""
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        id         <-- data["id"]
        topicId    <-- data["topicId"]
        name       <-- data["name"]
        suggestion <-- data["suggestion"]
        createdAt  <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt  <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}
