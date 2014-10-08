//
//  AcceptTeamInviteResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class AcceptTeamInviteResponse : ObjectSerializable {
    public let topics: [Topic] = []
    public let invite: TeamInvite? = nil
    
    
    public init() {}
    
    required public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "topics": self.topics = $.array(v) { (i) -> Topic? in
                let obj = Topic(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            case "invite": if let dic = v as? [NSObject : AnyObject] {
                self.invite = TeamInvite(dictionary: dic, error: &err)
                }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
