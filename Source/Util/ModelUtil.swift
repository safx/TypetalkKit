//
//  ModelUtil.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class ModelUtil {
    class func array<T>(value: AnyObject, ctor: (NSDictionary) -> T? ) -> [T] {
        var ret: [T] = []
        if let arr = value as? [NSDictionary] {
            for i in arr {
                if let obj = ctor(i) {
                    ret.append(obj)
                }
            }
        }
        return ret
    }

    class func date(value: AnyObject) -> NSDate {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.dateFromString(value as String)!
    }

    class func url(value: AnyObject) -> NSURL {
        return NSURL(string: value as String)
    }
}
