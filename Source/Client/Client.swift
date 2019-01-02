//
//  Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/18.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import APIKit


open class TypetalkAPI: Session {
    internal static let apiURLString: String = "https://typetalk.com/api/"
    internal static let messageApiURLString: String = "wss://message.typetalk.com/api/v1/streaming"
    internal static let authURLString: String = "https://typetalk.com/oauth2"
}

enum TypetalkAPIError: Error {
    case cannotBuildURLRequest
}

