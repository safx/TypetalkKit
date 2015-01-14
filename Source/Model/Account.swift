//
//  Account.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/14.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Account : Deserializable, ObjcBase {
    public let id: AccountID = 0
    public let name: String = ""
    public let fullName: String = ""
    public let suggestion: String = ""
    public let imageUrl: NSURL = NSURL()
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        id         <<< data["id"]
        name       <<< data["name"]
        fullName   <<< data["fullName"]
        suggestion <<< data["suggestion"]
        imageUrl   <<< data["imageUrl"]
        createdAt  <<< (value: data["createdAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt  <<< (value: data["updatedAt"], format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}
