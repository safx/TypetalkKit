//
//  TalkMessages.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/05.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import JSONHelper

public class TalkMessages : Deserializable, ObjcBase {
    public let topic: Topic = Topic()
    public let talk: Talk = Talk()
    public let posts: [Post] = []
    public let hasNext: Bool = false
    
    required public init() {}

    required public init(data: [String: AnyObject]) {
        topic   <-- data["topic"]
        talk    <-- data["talk"]
        posts   <-- data["posts"]
        hasNext <-- data["hasNext"]
    }
}
