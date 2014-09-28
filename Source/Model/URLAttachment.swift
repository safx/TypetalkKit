//
//  URLAttachment.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class URLAttachment {
    public let webUrl: NSURL = NSURL()
    public let apiUrl: NSURL = NSURL()
    public let attachment: Attachment = Attachment()
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "webUrl": self.webUrl = $.url(v)
            case "apiUrl": self.apiUrl = $.url(v)
            case "attachment": self.attachment = Attachment(dictionary: v as [NSObject : AnyObject], error: &err)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
