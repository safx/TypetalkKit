//
//  OAuth2Router.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire


public enum OAuth2Router : URLRequestConvertible {
    private static let baseURLString = "https://typetalk.in/oauth2/"
    
    case Authorize(DeveloperSettings)
    case RequestAuthorizationCode(DeveloperSettings, String)
    case RequestRefreshToken(DeveloperSettings, String)
    
    private var methodAndPath: (Alamofire.Method, String) {
        switch self {
        case .Authorize(_)               : return (.GET , "authorize")
        case .RequestAuthorizationCode(_): return (.POST, "access_token")
        case .RequestRefreshToken(_)     : return (.POST, "access_token")
        }
    }
    
    private var method: Alamofire.Method {
        return methodAndPath.0
    }
    
    private var path: String {
        return methodAndPath.1
    }
    
    private var parameters: [String: AnyObject] {
        switch self {
        case .Authorize(let settings):
            return [
                "client_id"    : settings.clientId,
                "redirect_uri" : settings.redirectURI,
                "scope"        : Scope.scopesToRaw(settings.scopes),
                "response_type": "code",
            ]
        case .RequestAuthorizationCode(let (settings, authorizationCode)):
            return [
                "client_id"    : settings.clientId,
                "client_secret": settings.clientSecret,
                "redirect_uri" : settings.redirectURI,
                "code"         : authorizationCode,
                "grant_type"   : "authorization_code",
            ]
        case .RequestRefreshToken(let (settings, refreshToken)):
            return [
                "client_id"    : settings.clientId,
                "client_secret": settings.clientSecret,
                "refresh_token": refreshToken,
                "grant_type"   : "refresh_token",
            ]
        }
    }
    
    public var URLRequest: NSURLRequest {
        var request = NSMutableURLRequest(URL: (NSURL(string: OAuth2Router.baseURLString + path)))
        request.HTTPMethod = method.toRaw()
            
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
    }
}
