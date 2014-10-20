//
//  Scope.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/23.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public enum Scope : String {
    case my = "my"
    case topic_read = "topic.read"
    case topic_post = "topic.post"
    case topic_write = "topic.write"
    case topic_delete = "topic.delete"
    
    public static func scopesFromRaw(raw: String) -> [Scope] {
        var r: [Scope] = []
        for i in raw.componentsSeparatedByString(",") {
            if let val = Scope(rawValue: i) {
                r.append(val)
            }
        }
        return r
    }

    public static func scopesToRaw(values: [Scope]) -> String {
        return ",".join(values.map({ $0.rawValue }))
    }
}
