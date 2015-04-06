//
//  SaveReadTopicResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class SaveReadTopicResponse : Deserializable, ObjcBase {
    public let unread = Unread()
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        unread <-- data["unread"]
    }
}
