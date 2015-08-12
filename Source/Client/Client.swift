//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/18.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import APIKit


public class TypetalkAPI: API {
    internal static var apiURLString: String { return "https://typetalk.in/api/v1/" }
    internal static var authURLString: String { return "https://typetalk.in/oauth2" }
}

enum TypetalkAPIError: ErrorType {
    case CannotBuildURLRequest
}

