//
//  ResponseSerialize.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/07.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire

public let ERROR_DOMAIN = "ErrorDomain.TypetalkKit"

@objc public protocol ObjcBase {}

extension Alamofire.Request {
    public func responseObject<T where T: ObjcBase, T: Deserializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = objectResponseSerializer(nil as T?)

        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? T, error)
        })
    }

    private func objectResponseSerializer<T where T: ObjcBase, T: Deserializable>(_: T?) -> Request.Serializer {
        return { (request, response, data) in
            if let r = response {
                let statusCode = r.statusCode
                if statusCode / 100 == 4 {
                    let err = NSError(domain: ERROR_DOMAIN, code: statusCode, userInfo: r.allHeaderFields)
                    return (nil, err)
                }
            }

            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if JSON != nil {
                let obj = T(data: JSON as [String: AnyObject])
                return (obj, nil)
            } else {
                return (nil, serializationError)
            }
        }
    }
}
