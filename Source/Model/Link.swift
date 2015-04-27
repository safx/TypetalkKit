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
    public let id: LinkID
    public let url: NSURL
    public let contentType: String
    public let title: String
    public let description: String
    public let imageUrl: NSURL
    public let createdAt: NSDate
    public let updatedAt: NSDate
    public let embed: Embed?

    public required init(id: LinkID = 0, url: NSURL = NSURL(), contentType: String = "", title: String = "", description: String = "", imageUrl: NSURL = NSURL(), createdAt: NSDate = NSDate(), updatedAt: NSDate = NSDate(), embed: Embed? = nil) {
        self.id = id
        self.url = url
        self.contentType = contentType
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.embed = embed
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: LinkID?
        var url: NSURL?
        var contentType: String?
        var title: String?
        var description: String?
        var imageUrl: NSURL?
        var createdAt: NSDate?
        var updatedAt: NSDate?
        var embed: Embed?

        id          <-- data["id"]
        url         <-- data["url"]
        contentType <-- data["contentType"]
        title       <-- data["title"]
        description <-- data["description"]
        imageUrl    <-- data["imageUrl"]
        createdAt   <-- (data["createdAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        updatedAt   <-- (data["updatedAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        embed       <-- data["embed"]

        self.init(id: id ?? 0, url: url ?? NSURL(), contentType: contentType ?? "", title: title ?? "", description: description ?? "", imageUrl: imageUrl ?? NSURL(), createdAt: createdAt ?? NSDate(), updatedAt: updatedAt ?? NSDate(), embed: embed)
    }
}
