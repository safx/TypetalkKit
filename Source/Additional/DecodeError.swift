//
//  DecodeError.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation


public enum JSONDecodeError: Error, CustomStringConvertible {
    case missingKey(key: String, object: Any)
    case typeMismatch(key: String, object: Any, expected: Any.Type, actual: Any.Type)
    case valueTranslationFailed(type: Any.Type, object: Any)
    case nonNullable(key: String, object: Any)

    public var description: String {
        switch self {
        case .missingKey(let v): return "MissingKey(key=\(v), object=\(v.object))"
        case .typeMismatch(let v): return "TypeMismatch(key=\(v.key), object=\(v.object), expected=\(v.expected), actual=\(v.actual))"
        case .valueTranslationFailed(let v): return "ValueTranslationFailed(type=\(v), object=\(v.object))"
        case .nonNullable(let v): return "NonNullable(key=\(v), object=\(v.object))"
        }
    }
}
