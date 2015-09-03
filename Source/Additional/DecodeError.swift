//
//  DecodeError.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation


public enum JSONDecodeError: ErrorType, CustomStringConvertible {
    case MissingKey(key: String, object: AnyObject)
    case TypeMismatch(key: String, object: AnyObject, expected: Any.Type, actual: Any.Type)
    case ValueTranslationFailed(type: Any.Type, object: AnyObject)
    case NonNullable(key: String, object: AnyObject)

    public var description: String {
        switch self {
        case .MissingKey(let v): return "MissingKey(key=\(v), object=\(v.object))"
        case .TypeMismatch(let v): return "TypeMismatch(key=\(v.key), object=\(v.object), expected=\(v.expected), actual=\(v.actual))"
        case .ValueTranslationFailed(let v): return "ValueTranslationFailed(type=\(v), object=\(v.object))"
        case .NonNullable(let v): return "NonNullable(key=\(v), object=\(v.object))"
        }
    }
}
