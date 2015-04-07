//
//  Link.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Link : Deserializable, ObjcBase {
    public let id: LinkID = 0
    public let url: NSURL = NSURL()
    public let contentType: String = ""
    public let title: String = ""
    public let description: String = ""
    public let imageUrl: NSURL = NSURL()
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    public let embed: Embed?

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        id          <-- data["id"]
        url         <-- data["url"]
        contentType <-- data["contentType"]
        title       <-- data["title"]
        description <-- data["description"]
        imageUrl    <-- data["imageUrl"]
        createdAt   <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt   <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        embed       <-- data["embed"]
    }
}
