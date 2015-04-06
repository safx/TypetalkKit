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
    public let team: Team = Team()
    public let topic: Topic = Topic()
    public let bookmark: Bookmark = Bookmark()
    public let posts: [Post] = []
    public let hasNext: Bool = false

    public required init() {}
    
    required public init(data: [String: AnyObject]) {
        team     <-- data["team"]
        topic    <-- data["topic"]
        bookmark <-- data["bookmark"]
        posts    <-- data["posts"]
        hasNext  <-- data["hasNext"]
    }
}
