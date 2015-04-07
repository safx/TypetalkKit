//
//  Mention.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Mention : Deserializable, ObjcBase {
    public let id: MentionID = 0
    public let readAt: NSDate?
    public let post: Post?
    
    required public init() {}
        
    required public init(data: [String: AnyObject]) {
        id     <-- data["id"]
        readAt <-- (data["readAt"], "yyyy-MM-dd'T'HH:mm:ssZ")
        post   <-- data["post"]
    }
}
