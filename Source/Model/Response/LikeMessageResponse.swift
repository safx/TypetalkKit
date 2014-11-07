//
//  LikeMessageResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class LikeMessageResponse : Deserializable, ObjcBase {
    public let like = Like()
    
    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        like <<<< data["like"]
    }
}
