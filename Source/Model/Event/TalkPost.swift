//
//  TalkPost.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2015/02/16.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TalkPost : Deserializable, ObjcBase {
    public let topic: Topic = Topic()
    public let talk: Talk = Talk()
    public let postIds: [PostID]?

    required public init() {}

    required public init(data: [String: AnyObject]) {
        topic   <-- data["topic"]
        talk    <-- data["talk"]
        postIds <-- data["postIds"]
    }
}
