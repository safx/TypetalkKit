//
//  SaveReadMentionResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/26.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class SaveReadMentionResponse : Deserializable, ObjcBase {
    public let mention = Mention()
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        mention <<<< data["mention"]
    }
}
