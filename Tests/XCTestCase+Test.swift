//
//  TestUtil.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/14.
//  Copyright (c) 2014年 Safx. All rights reserved.
//

import Foundation
import XCTest
@testable import TypetalkKit

extension XCTestCase {
    func path(_ name: String) -> String {
        let bundle = Bundle(for: ClientAPITests.self)
        return bundle.path(forResource: name, ofType: "json")!
    }

    func decode<T: Decodable>(_ type: T.Type, fromJsonFile name: String) throws -> T {
        let data = try Data(contentsOf: URL(fileURLWithPath: path(name)), options: [])
        return try decode(T.self, from: data)
    }

    func decode<T: Decodable>(_ type: T.Type, fromStreamingJsonFile name: String) throws -> T {
        let streamdata = try? Data(contentsOf: URL(fileURLWithPath: path("streaming-\(name)")), options: [])
        let dic = try JSONSerialization.jsonObject(with: streamdata!, options: []) as! [String:AnyObject]
        let dataObj = dic["data"] as! [String:AnyObject]
        let data = try! JSONSerialization.data(withJSONObject: dataObj, options: [])
        return try decode(T.self, from: data)
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        if #available(OSX 10.12, iOS 10.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        } else {
            fatalError("Please use newer macOS")
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.typeMismatch(let dataType, let context) {
            print("typeMismatch")
            print("  type:", dataType)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  JSON:", String(data: data, encoding: String.Encoding.utf8)!)
            throw DecodingError.typeMismatch(dataType, context)
        } catch DecodingError.valueNotFound(let dataType, let context) {
            print("valueNotFound")
            print("  type:", dataType)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  JSON:", String(data: data, encoding: String.Encoding.utf8)!)
            throw DecodingError.valueNotFound(dataType, context)
        } catch DecodingError.keyNotFound(let codingPath, let context) {
            print("keyNotFound")
            print("  type:", codingPath)
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  JSON:", String(data: data, encoding: String.Encoding.utf8)!)
            throw DecodingError.keyNotFound(codingPath, context)
        } catch DecodingError.dataCorrupted(let context) {
            print("dataCorrupted")
            print("  desc:", context.debugDescription)
            print("  ctx :", context.codingPath.map{$0.stringValue})
            print("  JSON:", String(data: data, encoding: String.Encoding.utf8)!)
            throw DecodingError.dataCorrupted(context)
        } catch let error {
            print("Other Error", error)
            print("  JSON:", String(data: data, encoding: String.Encoding.utf8)!)
            throw error
        }
    }
}
