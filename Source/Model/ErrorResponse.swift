//
//  ErrorResponse.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/30.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class ErrorResponse {
    public let name: String = ""
    public let description: String = ""
    public let file: String = ""
    public let line: Int = 0

    public class func checkErrorResponse(json: [NSObject : AnyObject], file: String = __FILE__, line: Int = __LINE__) -> ErrorResponse? {
        if json["error"] == nil { return nil }
        
        var error : NSError? = nil
        return ErrorResponse(dictionary: json, error: &error, file: file, line: line)
    }

    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer, file: String, line: Int) {
        self.file = file
        self.line = line
        for (k,v) in dictionaryValue {
            switch k {
            case "error": self.name = v as String
            case "error_description": self.description = v as String
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
    }
}
