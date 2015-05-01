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
    public let id: LikeID
    public let postId: PostID
    public let topicId: TopicID
    public let comment: String?
    public let account: Account?

    public required init(id: LikeID = 0, postId: PostID = 0, topicId: TopicID = 0, comment: String? = nil, account: Account? = nil) {
        self.id = id
        self.postId = postId
        self.topicId = topicId
        self.comment = comment
        self.account = account
    }

    required public convenience init(data: [String: AnyObject]) {
        var id: LikeID?
        var postId: PostID?
        var topicId: TopicID?
        var comment: String?
        var account: Account?

        id      <-- data["id"]
        postId  <-- data["postId"]
        topicId <-- data["topicId"]
        comment <-- data["comment"]
        account <-- data["account"]

        self.init(id: id ?? 0, postId: postId ?? 0, topicId: topicId ?? 0, comment: comment, account: account)
    }
}
