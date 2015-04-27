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
    public let id: AccountID
    public let name: String
    public let fullName: String
    public let suggestion: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate

    required public init(id: AccountID = 0, name: String = "", fullName: String = "", suggestion: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.suggestion = suggestion
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: AccountID?
        var name: String?
        var fullName: String?
        var suggestion: String?
        var imageUrl: NSURL?
        var createdAt: NSDate?
        var updatedAt: NSDate?

        id         <-- data["id"]
        name       <-- data["name"]
        fullName   <-- data["fullName"]
        suggestion <-- data["suggestion"]
        imageUrl   <-- data["imageUrl"]
        createdAt  <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt  <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")

        self.init(id: id ?? 0, name: name ?? "", fullName: fullName ?? "", suggestion: suggestion ?? "", imageUrl: imageUrl ?? NSURL(), createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate())
    }
}
