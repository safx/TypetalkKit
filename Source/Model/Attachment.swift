//
//  Attachment.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Attachment : Deserializable, ObjcBase {
    public let contentType: String
    public let fileKey: String
    public let fileName: String
    public let fileSize: Int

    public required init(contentType: String = "", fileKey: String = "", fileName: String = "", fileSize: Int = 0) {
        self.contentType = contentType
        self.fileKey = fileKey
        self.fileName = fileName
        self.fileSize = fileSize
    }

    required public convenience init(data: [String: AnyObject]) {
        var contentType: String?
        var fileKey: String?
        var fileName: String?
        var fileSize: Int?

        contentType <-- data["contentType"]
        fileKey     <-- data["fileKey"]
        fileName    <-- data["fileName"]
        fileSize    <-- data["fileSize"]

        self.init(contentType: contentType ?? "", fileKey: fileKey ?? "", fileName: fileName ?? "", fileSize: fileSize ?? 0)
    }
}
