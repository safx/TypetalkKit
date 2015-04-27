//
//  SaveReadMentionResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class SaveReadMentionResponse : Deserializable, ObjcBase {
    public let mention: Mention
    
    public required init(mention: Mention = Mention()) {
        self.mention = mention
    }

    required public convenience init(data: [String: AnyObject]) {
        var mention: Mention?
        mention <-- data["mention"]
        self.init(mention: mention ?? Mention())
    }
}
