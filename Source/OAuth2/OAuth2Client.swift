//
//  OAuth2Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

extension TypetalkRequest {
    public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        guard let accessToken = TypetalkAPI.accessToken else {
            throw TypetalkAPIError.CannotBuildURLRequest
        }
        URLRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        return URLRequest
    }
}

extension TypetalkAPI {
    public typealias CompletionClosure = (APIError?) -> Void

    static var state: ClientState = .NotSignedIn
    static private var settings: DeveloperSettings!
    static private let accountStore = OAuth2AccountStore(serviceName: "TypetalkKit")

    public static var isInitialized: Bool {
        return settings != nil
    }
    public static var isSignedIn: Bool {
        switch state {
        case .SignedIn: return true
        default: return false
        }
    }
    public static var accessToken: String? {
        switch state {
        case .SignedIn(let credential): return credential.accessToken
        default: return nil
        }
    }
    public static func setDeveloperSettings(clientId clientId: String, clientSecret: String, scopes: [Scope] = [], redirectURI: String? = nil) -> Bool {
        if isInitialized { return false }
        settings = DeveloperSettings(clientId: clientId, clientSecret: clientSecret, scopes: scopes, redirectURI: redirectURI)
        return true
    }

    public static func restoreTokenFromAccountStore() -> Bool {
        if let credential = accountStore.queryCredential() {
            self.state = .SignedIn(credential)
            return true
        }
        return false
    }

    public static func isRedirectURL(url: NSURL) -> Bool {
        precondition(settings.redirectURI != nil)

        let absurl = url.absoluteString
        return absurl.hasPrefix(settings.redirectURI!)
    }
    public static func authorizationDone(URL url: NSURL) -> Bool {
        switch state {
        case .Authorizing(let cb):
            let d = parseQuery(url)
            if let code = d["code"] {
                requestAuthorizationCode(code, completion: cb)
                return true
            }
        default: ()
        }
        return false
    }

    public static func requestAuthorizationCode(code: String, completion: CompletionClosure) {
        precondition(isInitialized)
        state = .RequestingAccessToken
        accessToken(AccessToken(
            grant_type: .AuthorizationCode,
            client_id: settings.clientId,
            client_secret: settings.clientSecret,
            redirect_uri: settings.redirectURI,
            code: code), completion: completion)
    }

    public static func requestRefreshToken(completion: CompletionClosure) -> Bool {
        precondition(isInitialized)
        switch state {
        case .SignedIn(let (credential)):
            state = .RequestingTokenRefresh
            accessToken(AccessToken(
                grant_type: .RefreshToken,
                client_id: settings.clientId,
                client_secret: settings.clientSecret,
                refresh_token: credential.refreshToken), completion: completion)
            return true
        default:
            return false
        }
    }

    public static func accessToken(request: AccessToken, completion: CompletionClosure) {
        self.sendRequest(request) { result -> Void in
            switch result {
            case .Success(let credential):
                self.accountStore.saveCredential(credential)
                self.state = ClientState.SignedIn(credential)
                completion(nil)
            case .Failure(let error):
                completion(error)
            }
        }
    }

    public static func authorize(completion: CompletionClosure) {
        precondition(isInitialized)
        precondition(settings.redirectURI != nil)

        state = .Authorizing(completion)
        let request = Authorize(
            client_id: settings.clientId,
            redirect_uri: settings.redirectURI!,
            scope: Scope.scopesToRaw(settings.scopes))
        let param = URLEncodedSerialization.stringFromDictionary(request.parameters)
        let base = request.baseURL.absoluteString
        openURL(NSURL(string: base + "/" + request.path + "?" + param)!)
    }

    public static func authorizeWithClientCredentials(completion: CompletionClosure) {
        precondition(isInitialized)
        state = .Authorizing(completion)
        accessToken(AccessToken(
            grant_type: .ClientCredentials,
            client_id: settings.clientId,
            client_secret: settings.clientSecret,
            scope: Scope.scopesToRaw(settings.scopes)), completion: completion)
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

    internal enum ClientState {
        case NotSignedIn
        case Authorizing(CompletionClosure)
        case RequestingAccessToken
        case SignedIn(OAuth2Credential)
        case RequestingTokenRefresh
    }

}

internal struct DeveloperSettings {
    let clientId: String
    let clientSecret: String
    let scopes: [Scope]
    let redirectURI: String?

    internal init(clientId: String, clientSecret: String, scopes: [Scope] = [], redirectURI: String? = nil) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scopes = scopes
        self.redirectURI = redirectURI
    }
}

extension Scope {
    public static func scopesFromRaw(raw: String) -> [Scope] {
        return raw.componentsSeparatedByString(",").flatMap { Scope(rawValue: $0) }
    }

    public static func scopesToRaw(values: [Scope]) -> String {
        return ",".join(values.map({ $0.rawValue }))
    }
}

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

