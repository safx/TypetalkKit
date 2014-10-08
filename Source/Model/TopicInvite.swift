//
//  TopicInvite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TopicInvite: Invite, ObjectSerializable {
    public let topic: Topic? = nil
    
    required public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        super.init(dictionary: dictionaryValue, error: error)
        
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "topic": if let dic = v as? [NSObject : AnyObject] {
                self.topic = Topic(dictionary: dic, error: &err)
                }
            case "id": break
            case "sender": break
            case "account": break
            case "role": break
            case "message": break
            case "createdAt": break
            case "updatedAt": break
            case "mailAddress": break
            case "status": break
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}