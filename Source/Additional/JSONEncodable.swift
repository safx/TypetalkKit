//
//  JSONEncodable.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation

public protocol JSONEncodable {
    func toJSON() -> [String: AnyObject]
}

// MARK:

public extension URL {
    public func toJSON() -> String {
        return self.absoluteString
    }
}

public extension Date {
    public func toJSON() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

public extension String {
    public func toJSON() -> String {
        return self
    }
}

public extension Float {
    public func toJSON() -> NSNumber {
        return NSNumber(value: self as Float)
    }
}

public extension Double {
    public func toJSON() -> NSNumber {
        return NSNumber(value: self as Double)
    }
}

public extension Int {
    public func toJSON() -> NSNumber {
        return NSNumber(value: self as Int)
    }
}

public extension UInt {
    public func toJSON() -> NSNumber {
        return NSNumber(value: self as UInt)
    }
}

public extension Bool {
    public func toJSON() -> NSNumber {
        return NSNumber(value: self as Bool)
    }
}
