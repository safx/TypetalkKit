//
//  Notifications.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/06.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

public class Notifications {
    public let mentions: [Mention] = []
    public let teamInvites: [TeamInvite] = []
    public let topicInvites: [TopicInvite] = []
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "mentions": self.mentions = $.array(v) { (i) -> Mention? in
                let obj = Mention(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            case "invites":
                if let ts = v["teams"] as? NSArray {
                    self.teamInvites = $.array(ts) { (i) -> TeamInvite? in
                        let obj = TeamInvite(dictionary: i, error: &err)
                        return err == nil ? obj : nil
                    }
                }
                if let ts = v["topics"] as? NSArray {
                    self.topicInvites = $.array(ts) { (i) -> TopicInvite? in
                        let obj = TopicInvite(dictionary: i, error: &err)
                        return err == nil ? obj : nil
                    }
                }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}