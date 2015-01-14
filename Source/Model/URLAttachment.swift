//
//  URLAttachment.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class URLAttachment : Deserializable, ObjcBase {
    public let webUrl: NSURL = NSURL()
    public let apiUrl: NSURL = NSURL()
    public let attachment: Attachment = Attachment()

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        webUrl     <<<  data["webUrl"]
        apiUrl     <<<  data["apiUrl"]
        attachment <<<< data["attachment"]
    }
}
