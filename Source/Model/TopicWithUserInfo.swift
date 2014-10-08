//
//  TopicWithUserInfo.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/21.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TopicWithUserInfo : ObjectSerializable {
    public let topic: Topic? = nil
    public let favorite: Bool = false
    public let unread: Unread? = nil
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "topic": self.topic = Topic(dictionary: v as [NSObject : AnyObject], error: &err)
            case "favorite": self.favorite = v as Bool
            case "unread": if let dic = v as? [NSObject : AnyObject] {
                    self.unread = Unread(dictionary: dic , error: &err)
                }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
