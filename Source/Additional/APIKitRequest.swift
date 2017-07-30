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
    associatedtype APIKitResponse
}


/*
extension APIKitRequest {
    public var baseURL: NSURL { return NSURL(string: "https://api.example.com/")! }
}
*/

public struct NullDataParser: DataParser {
    public var contentType: String? = "application/json"
    public func parse(data: Data) throws -> Any {
        return data
    }
}

extension APIKitRequest where Self.Response: Decodable {
    public typealias DataParser = NullDataParser

    public var dataParser: DataParser {
        return NullDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .iso8601
        do {
            return try decoder.decode(Self.Response.self, from: object as! Data) // FIXME
        } catch DecodingError.typeMismatch(let dataType, let context) {
            print("typeMismatch")
            print("  type:", dataType)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            throw ResponseError.unexpectedObject((context, dataType))
        } catch DecodingError.valueNotFound(let dataType, let context) {
            print("valueNotFound")
            print("  type:", dataType)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            throw ResponseError.unexpectedObject((context, dataType))
        } catch DecodingError.keyNotFound(let codingPath, let context) {
            print("keyNotFound")
            print("  type:", codingPath)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            throw ResponseError.unexpectedObject((context, codingPath))
        } catch DecodingError.dataCorrupted(let context) {
            print("dataCorrupted")
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            throw ResponseError.unexpectedObject(context)
        } catch let error {
            print("Other Error", error)
            throw ResponseError.unexpectedObject(error)
        }
    }
}
