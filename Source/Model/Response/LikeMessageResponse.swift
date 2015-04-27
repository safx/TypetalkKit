//
//  LikeMessageResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class LikeMessageResponse : Deserializable, ObjcBase {
    public let like: Like
    
    public required init(like: Like = Like()) {
        self.like = like
    }
    
    required public convenience init(data: [String: AnyObject]) {
        var like: Like?
        like <-- data["like"]
        self.init(like: like ?? Like())
    }
}
