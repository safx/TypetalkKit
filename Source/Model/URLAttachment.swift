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
    public let attachment: Attachment = Attachment()
    public let webUrl: NSURL = NSURL()
    public let apiUrl: NSURL = NSURL()
    public let thumbnails: [Thumbnail] = []

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        attachment <<<<  data["attachment"]
        webUrl     <<<   data["webUrl"]
        apiUrl     <<<   data["apiUrl"]
        thumbnails <<<<* data["thumbnails"]
    }
}
