//
//  TeamInvite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class TeamInvite: Invite {
    public let team: Team? = nil
    public let role: String = ""
    
    override public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        super.init(dictionary: dictionaryValue, error: error)

        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "team": if let dic = v as? [NSObject : AnyObject] {
                self.team = Team(dictionary: dic, error: &err)
                }
            case "role": self.role = v as String
            case "id": break
            case "sender": break
            case "account": break
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