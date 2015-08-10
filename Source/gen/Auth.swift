// This file was auto-generated from Auth.swift with swift-idl.

import Foundation
import APIKit


public class Authorize: AuthRequest {
    public typealias Response = OAuth2Credential
    public let client_id: String
    public let redirect_uri: String
    public let scope: [Scope]
    public let response_type: String

    public init(client_id: String, redirect_uri: String, scope: [Scope], response_type: String = "code") {
        self.client_id = client_id
        self.redirect_uri = redirect_uri
        self.scope = scope
        self.response_type = response_type
    }

    public var method: HTTPMethod {
        return .GET
    }

    public var path: String {
        return "authorize"
    }

    public var parameters: [String: AnyObject] {
        return ["client_id": client_id.toJSON(), "redirect_uri": redirect_uri.toJSON(), "scope": scope.map { $0.toJSON() }, "response_type": response_type.toJSON()]
    }
}

public class RequestAuthorizationCode: AuthRequest {
    public typealias Response = OAuth2Credential
    public let client_id: String
    public let client_secret: String
    public let redirect_uri: String
    public let code: String
    public let grant_type: String

    public init(client_id: String, client_secret: String, redirect_uri: String, code: String, grant_type: String = "authorization_code") {
        self.client_id = client_id
        self.client_secret = client_secret
        self.redirect_uri = redirect_uri
        self.code = code
        self.grant_type = grant_type
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "access_token"
    }

    public var parameters: [String: AnyObject] {
        return ["client_id": client_id.toJSON(), "client_secret": client_secret.toJSON(), "redirect_uri": redirect_uri.toJSON(), "code": code.toJSON(), "grant_type": grant_type.toJSON()]
    }
}

public class RequestRefreshToken: AuthRequest {
    public typealias Response = OAuth2Credential
    public let client_id: String
    public let client_secret: String
    public let refresh_token: String
    public let grant_type: String

    public init(client_id: String, client_secret: String, refresh_token: String, grant_type: String = "refresh_token") {
        self.client_id = client_id
        self.client_secret = client_secret
        self.refresh_token = refresh_token
        self.grant_type = grant_type
    }

    public var method: HTTPMethod {
        return .POST
    }

    public var path: String {
        return "access_token"
    }

    public var parameters: [String: AnyObject] {
        return ["client_id": client_id.toJSON(), "client_secret": client_secret.toJSON(), "refresh_token": refresh_token.toJSON(), "grant_type": grant_type.toJSON()]
    }
}

public class OAuth2Credential: NSObject, NSCoding, JSONDecodable, JSONEncodable {
    public let accessToken: String    // json:"access_token"
    public let tokenType: String      // json:"token_type"
    public let refreshToken: String   // json:"refresh_token"
    public let expiryIn: Int          // json:"expires_in"

    public init(accessToken: String, tokenType: String, refreshToken: String, expiryIn: Int) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.refreshToken = refreshToken
        self.expiryIn = expiryIn
    }

    required public init?(coder: NSCoder) {
        var failed = false
        if let accessToken = coder.decodeObjectForKey("accessToken") as? String {
            self.accessToken = accessToken
        } else {
            self.accessToken = String()  // FIXME: set default value
            failed = true
        }
        if let tokenType = coder.decodeObjectForKey("tokenType") as? String {
            self.tokenType = tokenType
        } else {
            self.tokenType = String()  // FIXME: set default value
            failed = true
        }
        if let refreshToken = coder.decodeObjectForKey("refreshToken") as? String {
            self.refreshToken = refreshToken
        } else {
            self.refreshToken = String()  // FIXME: set default value
            failed = true
        }
        expiryIn = coder.decodeIntegerForKey("expiryIn")
        if failed {
            return // nil
        }
    }

    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(accessToken, forKey: "accessToken")
        coder.encodeObject(tokenType, forKey: "tokenType")
        coder.encodeObject(refreshToken, forKey: "refreshToken")
        coder.encodeInteger(expiryIn, forKey: "expiryIn")
    }

    public class func parseJSON(data: AnyObject) throws -> OAuth2Credential {
        if !(data is NSDictionary) {
            throw JSONDecodeError.TypeMismatch(key: "OAuth2Credential", type: "NSDictionary")
        }

        let accessToken: String
        if let v: AnyObject = data["access_token"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "access_token")
            } else {
                do {
                    accessToken = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "access_token", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "access_token")
        }

        let tokenType: String
        if let v: AnyObject = data["token_type"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "token_type")
            } else {
                do {
                    tokenType = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "token_type", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "token_type")
        }

        let refreshToken: String
        if let v: AnyObject = data["refresh_token"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "refresh_token")
            } else {
                do {
                    refreshToken = try String.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "refresh_token", type: "String")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "refresh_token")
        }

        let expiryIn: Int
        if let v: AnyObject = data["expires_in"] {
            if v is NSNull {
                throw JSONDecodeError.NonNullablle(key: "expires_in")
            } else {
                do {
                    expiryIn = try Int.parseJSON(v)
                } catch JSONDecodeError.ValueTranslationFailed {
                    throw JSONDecodeError.TypeMismatch(key: "expires_in", type: "Int")
                }
            }
        } else {
            throw JSONDecodeError.MissingKey(key: "expires_in")
        }

        return OAuth2Credential(accessToken: accessToken, tokenType: tokenType, refreshToken: refreshToken, expiryIn: expiryIn)
    }

    public func toJSON() -> [String: AnyObject] {
        return [
            "access_token": accessToken.toJSON(),
            "token_type": tokenType.toJSON(),
            "refresh_token": refreshToken.toJSON(),
            "expires_in": expiryIn.toJSON(),
        ]
    }
}

