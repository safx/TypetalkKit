//
//  Attachment.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Attachment {
    public let fileKey: String = ""
    public let fileName: String = ""
    public let fileSize: Int = 0
    public let contentType: String = ""
    
    public init() {}
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        for (k,v) in dictionaryValue {
            switch k {
            case "fileKey": self.fileKey = v as String
            case "fileName": self.fileName = v as String
            case "fileSize": self.fileSize = v as Int
            case "contentType": self.contentType = v as String
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
