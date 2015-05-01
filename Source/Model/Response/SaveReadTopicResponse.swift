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
    public let unread: Unread
    
    public required init(unread: Unread = Unread()) {
        self.unread = unread
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var unread: Unread?
        unread <-- data["unread"]
        self.init(unread: unread ?? Unread())
    }
}
