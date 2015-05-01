//
//  GetMessagesResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/25.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class GetMessagesResponse : Deserializable, ObjcBase {
    public let team: Team
    public let topic: Topic
    public let bookmark: Bookmark
    public let posts: [Post]
    public let hasNext: Bool

    public required init(team: Team = Team(), topic: Topic = Topic(), bookmark: Bookmark = Bookmark(), posts: [Post] = [], hasNext: Bool = false) {
        self.team = team
        self.topic = topic
        self.bookmark = bookmark
        self.posts = posts
        self.hasNext = hasNext
    }

    required public convenience init(data: [String: AnyObject]) {
        var team: Team?
        var topic: Topic?
        var bookmark: Bookmark?
        var posts: [Post]?
        var hasNext: Bool?

        team     <-- data["team"]
        topic    <-- data["topic"]
        bookmark <-- data["bookmark"]
        posts    <-- data["posts"]
        hasNext  <-- data["hasNext"]

        self.init(team: team ?? Team(), topic: topic ?? Topic(), bookmark: bookmark ?? Bookmark(), posts: posts ?? [], hasNext: hasNext ?? false)
    }
}
