//
//  ResponseSerialize.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/07.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire



extension Alamofire.Request {
    
    public func responseObject<T: ObjectSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        return responseObjectWithKey(nil, completionHandler: completionHandler)
    }
    
    public func responseObjectWithKey<T: ObjectSerializable>(key: String?, completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = ModelUtil.getObjectSerializer(nil as T?, key: key)
        
        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? T, error)
        })
    }

    public func responseCollection<T: ObjectSerializable>(key: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, [T]?, NSError?) -> Void) -> Self {
        let serializer: Serializer = ModelUtil.getCollectionSerializer(nil as T?, key: key)
        
        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? [T], error)
        })
    }
}