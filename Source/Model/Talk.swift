//
//  Talk.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Talk {
    public let id: TalkID = 0
    public let topicId: TopicID = 0
    public let name: String = ""
    public let suggestion: String = ""
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    public init() {}
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as TalkID
            case "topicId": self.topicId = v as TopicID
            case "name": self.name = v as String
            case "suggestion": self.suggestion = v as String
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
