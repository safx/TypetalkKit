//
//  OAuth2Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import Alamofire

public struct DeveloperSettings {
    let clientId: String
    let clientSecret: String
    let redirectURI: String
    let scopes: [Scope]
    
    public init(clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
        self.scopes = scopes
    }
}


public class OAuth2Client {
    public typealias CompletionBlock = ((NSError?) -> Void)

    private var _settings: DeveloperSettings = DeveloperSettings(clientId: "", clientSecret: "", redirectURI: "", scopes: [])
    public var settings: DeveloperSettings { return _settings }
    public var isInitialized: Bool {
        return _settings.clientId != "" && _settings.clientSecret != "" && _settings.redirectURI != "" && countElements(_settings.scopes) > 0
    }
    public func setDeveloperSettings(#clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) -> Bool {
        if isInitialized { return false }
        _settings = DeveloperSettings(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI, scopes: scopes)
        return true
    }
    
    
    enum ClientState {
        case NotSignedIn
        case Authorizing(CompletionBlock)
        case RequestingAccessToken
        case SignedIn(OAuth2Credential)
        case RequestingTokenRefresh
    }
    
    var state: ClientState = .NotSignedIn
    public var isSignedIn: Bool {
        switch state {
        case .SignedIn: return true
        default: return false
        }
    }
    public var accessToken: String? {
        switch state {
        case .SignedIn(let credential): return credential.accessToken
        default: return nil
        }
    }
    
    
    public func restoreTokenFromAccountStore() -> Bool {
        if let credential = OAuth2AccountStore.sharedStore.queryCredential() {
            self.state = .SignedIn(credential)
            return true
        }
        return false
    }
    
    public func isRedirectURL(url: NSURL) -> Bool {
        let absurl = url.absoluteString!
        return absurl.hasPrefix(_settings.redirectURI)
    }
    
    public func authorizationDone(URL url: NSURL) -> Bool {
        switch state {
        case .Authorizing(let cb):
            let d = OAuth2Client.parseQuery(url)
            if let code = d["code"] {
                requestAuthorizationCode(code, cb)
                return true
            }
            return false
        default:
            return false
        }
    }
    
    public class func parseQuery(url: NSURL) -> [String:String] {
        var dic: [String:String] = [:]
        if let q = url.query {
            let ss = q.componentsSeparatedByString("&")
            for s in ss {
                let kv = q.componentsSeparatedByString("=")
                switch countElements(kv) {
                case 0: let nothing = 0
                case 1: dic[kv[0]] = ""
                case 2: dic[kv[0]] = kv[1]
                default: dic[kv[0]] = kv[1] // FIXME
                }
            }
        }
        return dic
    }
    
    public func requestAuthorizationCode(code: String, completion: CompletionBlock) {
        state = .RequestingAccessToken
        _requestAccessToken(OAuth2Router.RequestAuthorizationCode(_settings, code), completion)
    }
    
    public func requestRefreshToken(completion: CompletionBlock) -> Bool {
        switch state {
        case .SignedIn(let (credential)):
            state = .RequestingTokenRefresh
            _requestAccessToken(OAuth2Router.RequestRefreshToken(_settings, credential.refreshToken), completion)
            return true
        default:
            // TODO: send error to completion block
            return false
        }
    }
    
    private func _requestAccessToken(router: OAuth2Router, completion: CompletionBlock) {
        Alamofire.request(router)
            .responseJSON { (request, response, json, error) -> Void in
                if error == nil {
                    let errorResponse = ErrorResponse.checkErrorResponse(json as [String:AnyObject])
                    if errorResponse == nil {
                        var err: NSError? = nil
                        let credential = OAuth2Credential(dictionary: json as NSDictionary, error: &err)
                        if err == nil {
                            OAuth2AccountStore.sharedStore.saveCredential(credential)
                            self.state = ClientState.SignedIn(credential)
                        }
                    } else {
                        self.authorize(completion) // FIXME: call iOS function
                        return
                    }
                }
                completion(error)
        }
    }
}

// MARK: iOS

import UIKit

extension OAuth2Client {
    public func authorize(completion: CompletionBlock) {
        state = .Authorizing(completion)
        let request = OAuth2Router.Authorize(_settings).URLRequest
        UIApplication.sharedApplication().openURL(request.URL)
    }
}
