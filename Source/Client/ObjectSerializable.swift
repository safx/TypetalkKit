//
//  ObjectSerialize.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/10/07.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire

public let ERROR_DOMAIN = "ErrorDomain.TypetalkKit"


extension Alamofire.Request {
    public func responseObject<T where T: JSONDecodable>(_: T?, _ completionHandler: (T.DecodedType?, NSError?) -> Void) {
        let serializer = objectResponseSerializer()

        response(serializer: serializer, completionHandler: { (request, response, jsonObject, err) in
            guard let j = jsonObject as? [String: AnyObject] else {
                completionHandler(nil, err)
                return
            }

            do {
                let obj = try T.parseJSON(j)
                completionHandler(obj, nil)
            } catch {
                completionHandler(nil, nil) // FIXME: NSError
            }
        })
    }

    private func objectResponseSerializer() -> Request.Serializer {
        return { (request, response, data) in
            if let r = response {
                let statusCode = r.statusCode
                if statusCode / 100 == 4 {
                    let err = NSError(domain: ERROR_DOMAIN, code: statusCode, userInfo: r.allHeaderFields)
                    return (nil, err)
                }
            }

            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON, serializationError) = JSONSerializer(request, response, data)
            if JSON != nil {
                return (JSON, nil)
            } else {
                return (nil, serializationError)
            }
        }
    }
}
