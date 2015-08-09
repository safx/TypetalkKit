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
    internal static var oauth2 = OAuth2Client()

    public static var isInitialized: Bool {
        return oauth2.isInitialized
    }
    public static var isSignedIn: Bool {
        return oauth2.isSignedIn
    }
    public static var accessToken: String? {
        return oauth2.accessToken
    }
    public static func setDeveloperSettings(clientId clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) -> Bool {
        return oauth2.setDeveloperSettings(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI, scopes: scopes)
    }
    public static func restoreTokenFromAccountStore() -> Bool {
        return oauth2.restoreTokenFromAccountStore()
    }
    public static func authorize(completion: OAuth2Client.CompletionClosure) {
        oauth2.authorize(completion)
    }
    public static func isRedirectURL(url: NSURL) -> Bool {
        return oauth2.isRedirectURL(url)
    }
    public static func authorizationDone(URL url: NSURL) -> Bool {
        return oauth2.authorizationDone(URL: url)
    }
    public static func requestRefreshToken(completion: OAuth2Client.CompletionClosure) -> Bool {
        return oauth2.requestRefreshToken(completion)
    }
}

enum TypetalkAPIError: ErrorType {
    case CannotBuildURLRequest
}


extension APIKitRequest {
    public var baseURL: NSURL { return NSURL(string: TypetalkAPI.baseURLString)! }

    public var requestBodyBuilder: RequestBodyBuilder {
        return .URL(encoding: NSUTF8StringEncoding)
    }
}

extension APIKitRequest {
    public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        if true {
            guard let accessToken = TypetalkAPI.accessToken else {
                throw TypetalkAPIError.CannotBuildURLRequest
            }

            URLRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return URLRequest
    }
}
