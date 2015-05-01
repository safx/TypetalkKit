//
//  Thumbnail.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/01/19.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Thumbnail: Deserializable, ObjcBase {
    public let type: AttachmentType
    public let fileSize: Int
    public let width: Int
    public let height: Int

    public required init(type: AttachmentType = .Small, fileSize: Int = 0, width: Int = 0, height: Int = 0) {
        self.type = type
        self.fileSize = fileSize
        self.width = width
        self.height = height
    }

    required public convenience init(data: [String: AnyObject]) {
        var type: AttachmentType?
        var fileSize: Int?
        var width: Int?
        var height: Int?

        var t = ""
        t <-- data["type"]
        type = AttachmentType(rawValue: t)
        fileSize <-- data["fileSize"]
        width    <-- data["width"]
        height   <-- data["height"]

        self.init(type: type ?? .Small, fileSize: fileSize ?? 0, width: width ?? 0, height: height ?? 0)
    }
}
