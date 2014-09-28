//
//  Link.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Link {
    public let id: LinkID = 0
    public let url: NSURL = NSURL()
    public let contentType: String = ""
    public let title: String = ""
    public let description: String = ""
    public let imageUrl: NSURL = NSURL()
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as LinkID
            case "url": self.url = $.url(v)
            case "contentType": self.contentType = v as String
            case "title": self.title = v as String
            case "description": self.description = v as String
            case "imageUrl": self.imageUrl = $.url(v)
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
