//
//  Like.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/24.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class Like : Deserializable, ObjcBase {
    public let id: LikeID = 0
    public let postId: PostID = 0
    public let topicId: TopicID = 0
    public let comment: String? = nil
    public let account: Account? = nil
    
    public required init() {}

    required public init(data: [String: AnyObject]) {
        id      <-- data["id"]
        postId  <-- data["postId"]
        topicId <-- data["topicId"]
        comment <-- data["comment"]
        account <-- data["account"]
    }
}
