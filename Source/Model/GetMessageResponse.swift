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
    public let team: Team
    public let topic: Topic
    public let post: Post
    public let replies: [Post]

    required public init(team: Team = Team(), topic: Topic = Topic(), post: Post = Post(), replies: [Post] = []) {
        self.team = team
        self.topic = topic
        self.post = post
        self.replies = replies
    }

    required public convenience init(data: [String: AnyObject]) {
        var team: Team?
        var topic: Topic?
        var post: Post?
        var replies: [Post]?

        team    <-- data["team"]
        topic   <-- data["topic"]
        post    <-- data["post"]
        replies <-- data["replies"]

        self.init(team: team ?? Team(), topic: topic ?? Topic(), post: post ?? Post(), replies: replies ?? [])
    }
}
