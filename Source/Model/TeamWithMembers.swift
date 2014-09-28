//
//  TeamWithMembers.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/03.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TeamWithMembers {
    public let team: Team? = nil
    public let members: [Member] = []
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "team": if let dic = v as? [NSObject : AnyObject] {
                self.team = Team(dictionary: dic, error: &err)
                }
            case "members": self.members = $.array(v) { (i) -> Member? in
                let obj = Member(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
                
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
