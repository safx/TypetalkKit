//
//  Mention.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/28.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Mention {
    public let id: MentionID = 0
    public let readAt: NSDate?
    public let post: Post? = nil
    
    public init() {}
    
    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        var err: NSError? = nil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as MentionID
            case "readAt": if let r = v as? String { self.readAt = $.date(r) }
            case "post": if let dic = v as? [NSObject : AnyObject] {
                self.post = Post(dictionary: dic, error: &err)
            }
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
