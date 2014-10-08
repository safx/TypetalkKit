//
//  ModelUtil.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire

@objc public protocol ObjectSerializable {
    init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer)
}

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

    class func getObjectSerializer<T: ObjectSerializable>(_: T?, key: String?) -> Request.Serializer {
        return { (request, response, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if JSON != nil {
                var err : NSError? = nil
                let dic = key == nil ? JSON! : JSON![key!]
                let obj = T(dictionary: dic as NSDictionary, error:&err)
                return (obj, nil)
            } else {
                return (nil, serializationError)
            }
        }
    }

    class func getCollectionSerializer<T: ObjectSerializable>(_: T?, key: String) -> Request.Serializer {
        return { (request, response, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if JSON != nil {
                var err: NSError? = nil
                let arr = JSON![key]
                
                var objs: [T] = []
                for i in arr as [NSDictionary] {
                    let obj = T(dictionary: i, error: &err)
                    if err != nil { break }
                    objs.append(obj)
                }
                return (objs, nil)
            } else {
                return (nil, serializationError)
            }
        }
    }
}
