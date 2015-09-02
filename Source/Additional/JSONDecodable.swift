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
            throw JSONDecodeError.ValueTranslationFailed(type: "Array")
        }

        var r: [Self.DecodedType] = []
        r.reserveCapacity(array.count)
        for e in array {
            if e is NSNull {
                throw JSONDecodeError.NonNullable(key: "(ROOT)")
            } else {
                r.append(try Self.parseJSON(e))
            }
        }
        return r
    }

    static func parseJSONArrayForNullable(data: AnyObject) throws -> [Self.DecodedType?] {
        guard let array = data as? [AnyObject] else {
            throw JSONDecodeError.ValueTranslationFailed(type: "Array")
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
        throw JSONDecodeError.ValueTranslationFailed(type: "NSURL")
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
        throw JSONDecodeError.ValueTranslationFailed(type: "NSDate")
    }
}

extension String: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> String {
        if let v = data as? String {
            return v
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "String")
    }
}

extension Float: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Float {
        if let v = data as? NSNumber {
            return v.floatValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "Float")
    }
}

extension Double: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Double {
        if let v = data as? NSNumber {
            return v.doubleValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "Double")
    }
}

extension Int: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Int {
        if let v = data as? NSNumber {
            return v.integerValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "Int")
    }
}

extension UInt: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> UInt {
        if let v = data as? NSNumber {
            return UInt(v.unsignedIntegerValue)
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "UInt")
    }
}

extension Bool: JSONDecodable {
    public static func parseJSON(data: AnyObject) throws -> Bool {
        if let v = data as? NSNumber {
            return v.boolValue
        }
        throw JSONDecodeError.ValueTranslationFailed(type: "Bool")
    }
}
