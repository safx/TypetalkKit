//
//  GetTopicMembersResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class GetTopicMembersResponse : ObjectSerializable {
    public let accounts: [AccountWithOnlineStatus] = []
    public let pendings: [AccountWithMailAddress] = []

    
    public init() {}
    
    required public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "accounts": self.accounts = $.array(v) { (i) -> AccountWithOnlineStatus? in
                let obj = AccountWithOnlineStatus(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            case "pendings": self.pendings = $.array(v) { (i) -> AccountWithMailAddress? in
                let obj = AccountWithMailAddress(dictionary: i, error: &err)
                return err == nil ? obj : nil
                }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
