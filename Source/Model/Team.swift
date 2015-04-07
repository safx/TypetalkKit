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
    public let id: TeamID = 0
    public let name: String = ""
    public let imageUrl: NSURL = NSURL()
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        id        <-- data["id"]
        name      <-- data["name"]
        imageUrl  <-- data["imageUrl"]
        createdAt <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
    }
}
