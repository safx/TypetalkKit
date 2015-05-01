//
//  GetMentionsResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetMentionsResponse : Deserializable, ObjcBase {
    public let mentions: [Mention]
    
    public required init(mentions: [Mention] = []) {
        self.mentions = mentions
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var mentions: [Mention]?
        mentions <-- data["mentions"]
        self.init(mentions: mentions ?? [])
    }
}
