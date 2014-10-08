//
//  TeamWithCount.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/13.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TeamWithCount : ObjectSerializable {
    public let team: Team? = nil
    public let memberCount: Int = 0
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "team": if let dic = v as? [NSObject : AnyObject] {
                self.team = Team(dictionary: dic, error: &err)
                }
            case "memberCount": self.memberCount = v as Int
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
