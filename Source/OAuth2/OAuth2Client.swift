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
    public typealias CompletionClosure = ((NSError?) -> Void)

    private var _settings: DeveloperSettings = DeveloperSettings(clientId: "", clientSecret: "", redirectURI: "", scopes: [])
    public var settings: DeveloperSettings { return _settings }
    public var isInitialized: Bool {
        return _settings.clientId != "" && _settings.clientSecret != "" && _settings.redirectURI != "" && _settings.scopes.count > 0
    }
    public func setDeveloperSettings(clientId clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) -> Bool {
        if isInitialized { return false }
        _settings = DeveloperSettings(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI, scopes: scopes)
        return true
    }


    enum ClientState {
        case NotSignedIn
        case Authorizing(CompletionClosure)
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
    private let accountStore = OAuth2AccountStore(serviceName: "TypetalkKit")

    public func restoreTokenFromAccountStore() -> Bool {
        if let credential = accountStore.queryCredential() {
            self.state = .SignedIn(credential)
            return true
        }
        return false
    }

    public func isRedirectURL(url: NSURL) -> Bool {
        let absurl = url.absoluteString
        return absurl.hasPrefix(_settings.redirectURI)
    }

    public func authorizationDone(URL url: NSURL) -> Bool {
        switch state {
        case .Authorizing(let cb):
            let d = OAuth2Client.parseQuery(url)
            if let code = d["code"] {
                requestAuthorizationCode(code, completion: cb)
                return true
            }
        default: ()
        }
        return false
    }

    public class func parseQuery(url: NSURL) -> [String:String] {
        var dic: [String:String] = [:]
        if let q = url.query {
            let ss = q.componentsSeparatedByString("&")
            for _ in ss {
                let kv = q.componentsSeparatedByString("=")
                switch kv.count {
                case 0: break
                case 1: dic[kv[0]] = ""
                case 2: dic[kv[0]] = kv[1]
                default: dic[kv[0]] = kv[1] // FIXME
                }
            }
        }
        return dic
    }

    public func requestAuthorizationCode(code: String, completion: CompletionClosure) {
        state = .RequestingAccessToken
        _requestAccessToken(OAuth2Router.RequestAuthorizationCode(_settings, code), completion: completion)
    }

    public func requestRefreshToken(completion: CompletionClosure) -> Bool {
        switch state {
        case .SignedIn(let (credential)):
            state = .RequestingTokenRefresh
            _requestAccessToken(OAuth2Router.RequestRefreshToken(_settings, credential.refreshToken), completion: completion)
            return true
        default:
            // TODO: send error to completion block
            return false
        }
    }

    private func _requestAccessToken(router: OAuth2Router, completion: CompletionClosure) {
        Alamofire.request(router)
            .responseJSON { (request, response, json, error) -> Void in
                if error == nil {
                    let errorResponse = ErrorResponse.checkErrorResponse(json as! [String:AnyObject])
                    if errorResponse == nil {
                        var err: NSError? = nil
                        let credential = OAuth2Credential(dictionary: json as! [NSObject : AnyObject], error: &err)
                        if err == nil {
                            self.accountStore.saveCredential(credential)
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

// MARK: authorize

#if os(iOS)
    import UIKit
    private func openURL(url: NSURL) {
        UIApplication.sharedApplication().openURL(url)
    }
#else
    import AppKit
    private func openURL(url: NSURL) {
        NSWorkspace.sharedWorkspace().openURL(url)
    }
#endif

extension OAuth2Client {
    public func authorize(completion: CompletionClosure) {
        state = .Authorizing(completion)
        let request = OAuth2Router.Authorize(_settings).URLRequest
        openURL(request.URL!)
    }
}
