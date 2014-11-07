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

    public func responseObject<T where T: ObjcBase, T: Deserializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = ModelUtil.objectResponseSerializer(nil as T?)

        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? T, error)
        })
    }
    
}
