//
//  AccountWithOnlineStatus.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class AccountWithOnlineStatus : ObjectSerializable {
    public let account: Account? = nil
    public let online: Bool = false
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "account": if let dic = v as? [NSObject : AnyObject] {
                self.account = Account(dictionary: dic, error: &err)
                }
            case "online": self.online = v as Bool
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
