//
//  Account.swift
//  Pods
//
//  Created by Safx Developer on 2014/09/14.
//
//

import Foundation

public class Account : ObjectSerializable {
    public let id: AccountID = 0
    public let name: String = ""
    public let fullName: String = ""
    public let suggestion: String = ""
    public let imageUrl: NSURL = NSURL()
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    required public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as AccountID
            case "name": self.name = v as String
            case "fullName": self.fullName = v as String
            case "suggestion": self.suggestion = v as String
            case "imageUrl": self.imageUrl = $.url(v)
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
