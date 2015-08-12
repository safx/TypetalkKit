//
//  OAuth2Client.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/27.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit

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

extension Authorize {
    convenience init(settings: DeveloperSettings) {
        self.init(
            client_id: settings.clientId,
            redirect_uri: settings.redirectURI,
            scope: settings.scopes)
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
    public static func setDeveloperSettings(clientId clientId: String, clientSecret: String, redirectURI: String, scopes: [Scope]) -> Bool {
        if isInitialized { return false }
        settings = DeveloperSettings(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI, scopes: scopes)
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
        let absurl = url.absoluteString
        return absurl.hasPrefix(settings.redirectURI)
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
        let request = RequestAuthorizationCode(
            client_id: settings.clientId,
            client_secret: settings.clientSecret,
            redirect_uri: settings.redirectURI,
            code: code)
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

    public static func requestRefreshToken(completion: CompletionClosure) -> Bool {
        precondition(isInitialized)
        switch state {
        case .SignedIn(let (credential)):
            state = .RequestingTokenRefresh
            let request = RequestRefreshToken(
                client_id: settings.clientId,
                client_secret: settings.clientSecret,
                refresh_token: credential.accessToken)
            self.sendRequest(request) { result -> Void in
                switch result {
                case .Success(let credential):
                    self.accountStore.saveCredential(credential)
                    self.state = ClientState.SignedIn(credential)
                case .Failure(let error):
                    completion(error)
                }
            }
            return true
        default:
            return false
        }
    }

    public static func authorize(completion: CompletionClosure) {
        precondition(isInitialized)
        state = .Authorizing(completion)
        let request = Authorize(settings: settings)

        let base = "https://typetalk.in/oauth2/" // FIXME
        let path = request.path
        var dic = request.parameters
        dic["scope"] = ",".join(settings.scopes.map{ $0.rawValue })

        let param = URLEncodedSerialization.stringFromDictionary(dic)
        openURL(NSURL(string: base + path + "?" + param)!)
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

    enum ClientState {
        case NotSignedIn
        case Authorizing(CompletionClosure)
        case RequestingAccessToken
        case SignedIn(OAuth2Credential)
        case RequestingTokenRefresh
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

