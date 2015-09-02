//
//  DecodeError.swift
//  Swift-idl
//
//  Created by Safx Developer on 2015/05/12.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Foundation


public enum JSONDecodeError: ErrorType, CustomStringConvertible {
    case MissingKey(key: String)
    case TypeMismatch(key: String, type: String)
    case ValueTranslationFailed(type: String)
    case NonNullable(key: String)

    public var description: String {
        switch self {
        case .MissingKey(let v): return "MissingKey(key=\(v))"
        case .TypeMismatch(let v): return "TypeMismatch(key=\(v.key), type=\(v.type))"
        case .ValueTranslationFailed(let v): return "ValueTranslationFailed(type=\(v))"
        case .NonNullable(let v): return "NonNullable(key=\(v))"
        }
    }
}
