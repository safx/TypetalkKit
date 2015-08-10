//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/18.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import APIKit


public class TypetalkAPI: API {
    internal static var baseURLString: String { return "https://typetalk.in/api/v1/" }
}

enum TypetalkAPIError: ErrorType {
    case CannotBuildURLRequest
}

