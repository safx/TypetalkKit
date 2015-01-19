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
    public let type: AttachmentType = .Small
    public let fileSize: Int = 0
    public let width: Int = 0
    public let height: Int = 0

    public required init() {}

    required public init(data: [String: AnyObject]) {
        var t = ""
        t <<< data["type"]
        type     =   AttachmentType(rawValue: t)!
        fileSize <<< data["fileSize"]
        width    <<< data["width"]
        height   <<< data["height"]
    }
}
