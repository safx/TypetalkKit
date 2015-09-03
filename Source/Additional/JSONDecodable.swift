//
//  JSONDecodable.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    typealias DecodedType = Self
    static func parseJSON(data: AnyObject) throws -> DecodedType
}

public extension JSONDecodable {
    static func parseJSONArray(data: AnyObject) throws -> [Self.DecodedType] {
        guard let array = data as? [AnyObject] else {
            typealias Arr = [Self.DecodedType]
            throw JSONDecodeError.ValueTranslationFailed(type: Arr.self, object: data)
        }

        var r: [Self.DecodedType] = []
        r.reserveCapacity(array.count)
        for e in array {
            if e is NSNull {
                throw JSONDecodeError.NonNullable(key: "(ROOT)", object: data)
            } else {
                r.append(try Self.parseJSON(e))
            }
        }
        return r
    }

    static func parseJSONArrayForNullable(data: AnyObject) throws -> [Self.DecodedType?] {
        guard let array = data as? [AnyObject] else {
            typealias Arr = [Self.DecodedType?]
            throw JSONDecodeError.ValueTranslationFailed(type: Arr.self, object: data)
        }

        var r: [Self.DecodedType?] = []
        r.reserveCapacity(array.count)
        for e in array {
            if e is NSNull {
                r.append(nil)
            } else {
                r.append(try Self.parseJSON(e))
            }
        }
        return r
    }
}

// MARK:

extension NSURL: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> NSURL {
        if let v = data as? String, val = NSURL(string: v) {
            return val
        }
        throw JSONDecodeError.ValueTranslationFailed(type: NSURL.self, object: data)
    }
}

extension NSDate: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> NSDate {
        if let v = data as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let newDate = dateFormatter.dateFromString(v) {
                return newDate
            }
        }
        throw JSONDecodeError.ValueTranslationFailed(type: NSDate.self, object: data)
    }
}

extension String: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> String {
        if let v = data as? String {
            return v
        }
        throw JSONDecodeError.ValueTranslationFailed(type: String.self, object: data)
    }
}

extension Float: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Float {
        if let v = data as? NSNumber {
            return v.floatValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: Float.self, object: data)
    }
}

extension Double: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Double {
        if let v = data as? NSNumber {
            return v.doubleValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: Double.self, object: data)
    }
}

extension Int: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Int {
        if let v = data as? NSNumber {
            return v.integerValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: Int.self, object: data)
    }
}

extension UInt: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> UInt {
        if let v = data as? NSNumber {
            return UInt(v.unsignedIntegerValue)
        }
        throw JSONDecodeError.ValueTranslationFailed(type: UInt.self, object: data)
    }
}

extension Bool: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Bool {
        if let v = data as? NSNumber {
            return v.boolValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: Bool.self, object: data)
    }
}
