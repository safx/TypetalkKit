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

public extension NSURL {
    public func toJSON() -> String {
        return self.absoluteString
    }
}

public extension NSDate {
    public func toJSON() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(self)
    }
}

public extension String {
    public func toJSON() -> String {
        return self
    }
}

public extension Float {
    public func toJSON() -> NSNumber {
        return NSNumber(float: self)
    }
}

public extension Double {
    public func toJSON() -> NSNumber {
        return NSNumber(double: self)
    }
}

public extension Int {
    public func toJSON() -> NSNumber {
        return NSNumber(integer: self)
    }
}

public extension UInt {
    public func toJSON() -> NSNumber {
        return NSNumber(unsignedLong: self)
    }
}

public extension Bool {
    public func toJSON() -> NSNumber {
        return NSNumber(bool: self)
    }
}
