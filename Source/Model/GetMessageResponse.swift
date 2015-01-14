//
//  GetMessageResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/01.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetMessageResponse : Deserializable, ObjcBase {
    public let team: Team = Team()
    public let topic: Topic = Topic()
    public let post: Post = Post()
    public let replies: [Post] = []
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        team    <<<<  data["team"]
        topic   <<<<  data["topic"]
        post    <<<<  data["post"]
        replies <<<<* data["replies"]
    }
}
