//
//  JSONDecodable.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015 Safx Developers. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    associatedtype DecodedType = Self
    static func parse(with JSONObject: Any) throws -> DecodedType
}

public extension JSONDecodable {
    static func parseAsArray(with JSONArray: Any) throws -> [Self.DecodedType] {
        guard let array = JSONArray as? [Any] else {
            typealias Arr = [Self.DecodedType]
            throw JSONDecodeError.valueTranslationFailed(type: Arr.self, object: JSONArray)
        }

        var r: [Self.DecodedType] = []
        r.reserveCapacity(array.count)
        for e in array {
            if e is NSNull {
                throw JSONDecodeError.nonNullable(key: "(ROOT)", object: JSONArray)
            } else {
                r.append(try Self.parse(with: e))
            }
        }
        return r
    }

    static func parseAsArrayForNullable(with JSONArray: Any) throws -> [Self.DecodedType?] {
        guard let array = JSONArray as? [Any] else {
            typealias Arr = [Self.DecodedType?]
            throw JSONDecodeError.valueTranslationFailed(type: Arr.self, object: JSONArray)
        }

        var r: [Self.DecodedType?] = []
        r.reserveCapacity(array.count)
        for e in array {
            if e is NSNull {
                r.append(nil)
            } else {
                r.append(try Self.parse(with: e))
            }
        }
        return r
    }
}

// MARK:

extension URL: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> URL {
        if let v = JSONObject as? String, let val = URL(string: v) {
            return val
        }
        throw JSONDecodeError.valueTranslationFailed(type: URL.self, object: JSONObject)
    }
}

extension Date: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> Date {
        if let v = JSONObject as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let newDate = dateFormatter.date(from: v) {
                return newDate
            }
        }
        throw JSONDecodeError.valueTranslationFailed(type: Date.self, object: JSONObject)
    }
}

extension String: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> String {
        if let v = JSONObject as? String {
            return v
        }
        throw JSONDecodeError.valueTranslationFailed(type: String.self, object: JSONObject)
    }
}

extension Float: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> Float {
        if let v = JSONObject as? NSNumber {
            return v.floatValue
        }
        throw JSONDecodeError.valueTranslationFailed(type: Float.self, object: JSONObject)
    }
}

extension Double: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> Double {
        if let v = JSONObject as? NSNumber {
            return v.doubleValue
        }
        throw JSONDecodeError.valueTranslationFailed(type: Double.self, object: JSONObject)
    }
}

extension Int: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> Int {
        if let v = JSONObject as? NSNumber {
            return v.intValue
        }
        throw JSONDecodeError.valueTranslationFailed(type: Int.self, object: JSONObject)
    }
}

extension UInt: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> UInt {
        if let v = JSONObject as? NSNumber {
            return UInt(v.uintValue)
        }
        throw JSONDecodeError.valueTranslationFailed(type: UInt.self, object: JSONObject)
    }
}

extension Bool: JSONDecodable {
    public static func parse(with JSONObject: Any) throws -> Bool {
        if let v = JSONObject as? NSNumber {
            return v.boolValue
        }
        throw JSONDecodeError.valueTranslationFailed(type: Bool.self, object: JSONObject)
    }
}
