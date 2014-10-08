//
//  Topic.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/16.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Topic : ObjectSerializable {
    public let id: TopicID = 0
    public let name: String = ""
    public let suggestion: String = ""
    public let lastPostedAt: NSDate? = nil // set to nil when a topic is created.
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as TopicID
            case "name": self.name = v as String
            case "suggestion": self.suggestion = v as String
            case "lastPostedAt": if let d = v as? String { self.lastPostedAt = $.date(v) }
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
