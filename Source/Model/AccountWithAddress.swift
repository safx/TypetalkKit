//
//  AccountWithMailAddress.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class AccountWithMailAddress : ObjectSerializable {
    public let account: Account? = nil
    public let mailAddress: String? = nil
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "account": if let dic = v as? [NSObject : AnyObject] {
                self.account = Account(dictionary: dic, error: &err)
                }
            case "mailAddress": if let x = v as? String { self.mailAddress = x }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
