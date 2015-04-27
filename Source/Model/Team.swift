//
//  Team.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Team : Deserializable, ObjcBase {
    public let id: TeamID
    public let name: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate

    public required init(id: TeamID = 0, name: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate()) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: TeamID?
        var name: String?
        var imageUrl: NSURL?
        var createdAt: NSDate?
        var updatedAt: NSDate?

        id        <-- data["id"]
        name      <-- data["name"]
        imageUrl  <-- data["imageUrl"]
        createdAt <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")

        self.init(id: id ?? 0, name: name ?? "", imageUrl: imageUrl ?? NSURL(), createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate())
    }
}
