//
//  Team.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class Team : ObjectSerializable {
    public let id: TeamID = 0
    public let name: String = ""
    public let imageUrl: NSURL = NSURL()
    public let createdAt: NSDate = NSDate()
    public let updatedAt: NSDate = NSDate()
    
    public required init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        typealias $ = ModelUtil
        for (k,v) in dictionaryValue {
            switch k {
            case "id": self.id = v as TeamID
            case "name": self.name = v as String
            case "imageUrl": self.imageUrl = $.url(v)
            case "createdAt": self.createdAt = $.date(v)
            case "updatedAt": self.updatedAt = $.date(v)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
