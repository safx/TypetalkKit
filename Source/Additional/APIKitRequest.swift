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
        if #available(OSX 10.12, iOS 10.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        } else {
            fatalError("Please use newer macOS")
        }
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        do {
            return try decoder.decode(Self.Response.self, from: data)
        } catch DecodingError.typeMismatch(let dataType, let context) {
            print("JSON Decoding Error: typeMismatch")
            print("  base:", Self.Response.self)
            print("  desc:", context.debugDescription)
            print("  type:", dataType)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  data:", String(data: data, encoding: String.Encoding.utf8) ?? "<non utf-8 string>")
            throw ResponseError.unexpectedObject((context, dataType))
        } catch DecodingError.valueNotFound(let dataType, let context) {
            print("JSON Decoding Error: valueNotFound")
            print("  base:", Self.Response.self)
            print("  type:", dataType)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  data:", String(data: data, encoding: String.Encoding.utf8) ?? "<non utf-8 string>")
            throw ResponseError.unexpectedObject((context, dataType))
        } catch DecodingError.keyNotFound(let codingPath, let context) {
            print("JSON Decoding Error: keyNotFound")
            print("  base:", Self.Response.self)
            print("  type:", codingPath)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  data:", String(data: data, encoding: String.Encoding.utf8) ?? "<non utf-8 string>")
            throw ResponseError.unexpectedObject((context, codingPath))
        } catch DecodingError.dataCorrupted(let context) {
            print("JSON Decoding Error: dataCorrupted")
            print("  base:", Self.Response.self)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  data:", String(data: data, encoding: String.Encoding.utf8) ?? "<non utf-8 string>")
            throw ResponseError.unexpectedObject(context)
        } catch let error {
            print("JSON Decoding Error:", error)
            print("  base:", Self.Response.self)
            print("  data:", String(data: data, encoding: String.Encoding.utf8) ?? "<non utf-8 string>")
            throw ResponseError.unexpectedObject(error)
        }
    }
}
