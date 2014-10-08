//
//  Invite.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Invite {
    public let id: InviteID = 0
    public let sender: Account? = nil
    public let account: Account? = nil
    public let message: String = ""
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()

    public let mailAddress: String = ""
    public let status: String = ""

    public init() {}
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as InviteID
            case "sender": if let dic = v as? [NSObject : AnyObject] {
                    self.sender = Account(dictionary: dic, error: &err)
                }
            case "account": if let dic = v as? [NSObject : AnyObject] {
                    self.account = Account(dictionary: dic, error: &err)
                }
            case "message": self.message = v as String
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)
            case "mailAddress": if let m = v as? String { self.mailAddress = m }
            case "status": self.status = v as String
            default:
                break
            }
        }
    }
}
