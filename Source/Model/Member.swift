//
//  Member.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/03.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Member {
    public let account: Account? = nil // TODO: remove '?'
    public let role: String = ""
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "account": if let dic = v as? [NSObject : AnyObject] {
                self.account = Account(dictionary: dic, error: &err)
                }
            case "role": self.role = v as String
                
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
