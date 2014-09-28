//
//  TopicWithAccounts.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/04.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TopicWithAccounts {
    public let topic: Topic? = nil
    public let teams: [TeamWithMembers] = []
    public let accounts: [Account] = []
    public let invites: [TopicInvite] = []
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "topic": self.topic = Topic(dictionary: v as [NSObject : AnyObject], error: &err)
            case "teams": self.teams = $.array(v) { (i) -> TeamWithMembers? in
                let obj = TeamWithMembers(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            case "accounts": self.accounts = $.array(v) { (i) -> Account? in
                let obj = Account(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            case "invites": self.invites = $.array(v) { (i) -> TopicInvite? in
                let obj = TopicInvite(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }

            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
