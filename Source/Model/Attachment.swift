//
//  Attachment.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Attachment : Deserializable, ObjcBase {
    public let fileKey: String = ""
    public let fileName: String = ""
    public let fileSize: Int = 0
    public let contentType: String = ""
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        fileKey     <<< data["fileKey"]
        fileName    <<< data["fileName"]
        fileSize    <<< data["fileSize"]
        contentType <<< data["contentType"]
    }
}