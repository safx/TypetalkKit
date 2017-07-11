//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/18.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import APIKit


open class TypetalkAPI: Session {
    internal static let apiURLString: String = "https://typetalk.in/api/v1/"
    internal static let authURLString: String = "https://typetalk.in/oauth2"
}

enum TypetalkAPIError: Error {
    case cannotBuildURLRequest
}

