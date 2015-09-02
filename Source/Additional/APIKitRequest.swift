//
//  APIKitRequest.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

public protocol APIKitRequest: Request {
    typealias APIKitResponse
    typealias Response = APIKitResponse
    //typealias Response = Result<APIKitResponse>
}

/*
extension APIKitRequest {
    public var baseURL: NSURL { return NSURL(string: "https://api.example.com/")! }
}
*/

extension APIKitRequest where Self.Response: JSONDecodable, Self.Response == Self.Response.DecodedType {
    public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        do {
            return try Response.parseJSON(object)
        } catch {
            print(error)
        }
        return nil
    }
}
