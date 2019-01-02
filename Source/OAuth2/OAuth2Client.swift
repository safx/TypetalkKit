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
    public var headerFields: [String : String] {
        guard let accessToken = TypetalkAPI.accessToken else {
            return [:]
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }
}

extension TypetalkAPI {
    public typealias CompletionClosure = (SessionTaskError?) -> Void

    static var state: ClientState = .notSignedIn
    static fileprivate var settings: DeveloperSettings!
    static fileprivate let accountStore = OAuth2AccountStore(serviceName: "TypetalkKit")

    public static var isInitialized: Bool {
        return settings != nil
    }
    public static var isSignedIn: Bool {
        switch state {
        case .signedIn: return true
        default: return false
        }
    }
    public static var accessToken: String? {
        switch state {
        case .signedIn(let credential): return credential.accessToken
        default: return nil
        }
    }
    @discardableResult
    public static func setDeveloperSettings(clientId: String, clientSecret: String, scopes: [Scope] = [], redirectURI: String? = nil) -> Bool {
        if isInitialized { return false }
        settings = DeveloperSettings(clientId: clientId, clientSecret: clientSecret, scopes: scopes, redirectURI: redirectURI)
        return true
    }
    @discardableResult
    public static func restoreTokenFromAccountStore() -> Bool {
        if let credential = accountStore.queryCredential() {
            self.state = .signedIn(credential)
            return true
        }
        return false
    }

    internal static func setDummyAccessTokenForTest() {
        let credential = OAuth2Credential(accessToken: "atfoo", tokenType: "ttbar", refreshToken: "rtbazz", expiryIn: 0)
        self.state = .signedIn(credential)
    }

    public static func isRedirectURL(_ url: URL) -> Bool {
        precondition(settings.redirectURI != nil)

        let absurl = url.absoluteString
        return absurl.hasPrefix(settings.redirectURI!)
    }
    
    @discardableResult
    public static func authorizationDone(URL url: URL) -> Bool {
        switch state {
        case .authorizing(let cb):
            let d = parseQuery(url)
            if let code = d["code"] {
                requestAuthorizationCode(code, completion: cb)
                return true
            }
        default: ()
        }
        return false
    }

    public static func requestAuthorizationCode(_ code: String, completion: @escaping CompletionClosure) {
        precondition(isInitialized)
        state = .requestingAccessToken
        access(token: AccessToken(
            grant_type: .authorizationCode,
            client_id: settings.clientId,
            client_secret: settings.clientSecret,
            redirect_uri: settings.redirectURI,
            code: code), completion: completion)
    }

    @discardableResult
    public static func requestRefreshToken(_ completion: @escaping CompletionClosure) -> Bool {
        precondition(isInitialized)
        switch state {
        case .signedIn(let (credential)):
            state = .requestingTokenRefresh
            access(token: AccessToken(
                grant_type: .refreshToken,
                client_id: settings.clientId,
                client_secret: settings.clientSecret,
                refresh_token: credential.refreshToken), completion: completion)
            return true
        default:
            return false
        }
    }

    public static func access(token request: AccessToken, completion: @escaping CompletionClosure) {
        send(request) { result -> Void in
            switch result {
            case .success(let credential):
                _ = self.accountStore.saveCredential(credential)
                self.state = ClientState.signedIn(credential)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    public static func authorize(_ completion: @escaping CompletionClosure) {
        precondition(isInitialized)
        precondition(settings.redirectURI != nil)

        state = .authorizing(completion)
        let request = Authorize(
            client_id: settings.clientId,
            redirect_uri: settings.redirectURI!,
            scope: Scope.scopesToRaw(settings.scopes))
        let param = URLEncodedSerialization.string(from: request.parameters as? [String:Any] ?? [:])
        let base = request.baseURL.absoluteString
        openURL(url: URL(string: base + "/" + request.path + "?" + param)!)
    }

    public static func authorizeWithClientCredentials(_ completion: @escaping CompletionClosure) {
        precondition(isInitialized)
        state = .authorizing(completion)
        access(token: AccessToken(
            grant_type: .clientCredentials,
            client_id: settings.clientId,
            client_secret: settings.clientSecret,
            scope: Scope.scopesToRaw(settings.scopes)), completion: completion)
    }

    public class func parseQuery(_ url: URL) -> [String:String] {
        var dic: [String:String] = [:]
        if let q = url.query {
            let ss = q.components(separatedBy: "&")
            for _ in ss {
                let kv = q.components(separatedBy: "=")
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
        case notSignedIn
        case authorizing(CompletionClosure)
        case requestingAccessToken
        case signedIn(OAuth2Credential)
        case requestingTokenRefresh
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
    public static func scopesFromRaw(_ raw: String) -> [Scope] {
        return raw.components(separatedBy: ",").compactMap { Scope(rawValue: $0) }
    }

    public static func scopesToRaw(_ values: [Scope]) -> String {
        return values.map { $0.rawValue } .joined(separator: ",")
    }
}

#if os(iOS)
    import UIKit
    private func openURL(url: URL) {
        UIApplication.shared.openURL(url)
    }
#else
    import AppKit
    private func openURL(url: URL) {
        NSWorkspace.shared.open(url)
    }
#endif
