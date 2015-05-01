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
    public let attachment: Attachment
    public let webUrl: NSURL
    public let apiUrl: NSURL
    public let thumbnails: [Thumbnail]

    public required init(attachment: Attachment = Attachment(), webUrl: NSURL = NSURL(), apiUrl: NSURL = NSURL(), thumbnails: [Thumbnail] = []) {
        self.attachment = attachment
        self.webUrl = webUrl
        self.apiUrl = apiUrl
        self.thumbnails = thumbnails
    }

    required public convenience init(data: [String: AnyObject]) {
        var attachment: Attachment?
        var webUrl: NSURL?
        var apiUrl: NSURL?
        var thumbnails: [Thumbnail]?

        attachment <-- data["attachment"]
        webUrl     <-- data["webUrl"]
        apiUrl     <-- data["apiUrl"]
        thumbnails <-- data["thumbnails"]

        self.init(attachment: attachment ?? Attachment(), webUrl: webUrl ?? NSURL(), apiUrl: apiUrl ?? NSURL(), thumbnails: thumbnails ?? [])
    }
}
