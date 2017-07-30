// This file was auto-generated from Auth.swift with swift-idl.

import Foundation
import APIKit


public class Authorize: AuthRequest {
	public typealias APIKitResponse = OAuth2Credential
	public typealias Response = OAuth2Credential
	public let client_id: String
	public let redirect_uri: String
	public let scope: String
	public let response_type: String

	public init(client_id: String, redirect_uri: String, scope: String, response_type: String = "code") {
		self.client_id = client_id
		self.redirect_uri = redirect_uri
		self.scope = scope
		self.response_type = response_type
	}

	public var method: HTTPMethod {
		return .get
	}

	public var path: String {
		return "authorize"
	}

	public var parameters: Any? {
		return ["client_id": client_id as AnyObject, "redirect_uri": redirect_uri as AnyObject, "scope": scope as AnyObject, "response_type": response_type as AnyObject]
	}
}

public class AccessToken: AuthRequest {
	public typealias APIKitResponse = OAuth2Credential
	public typealias Response = OAuth2Credential
	public let grant_type: GrantType
	public let client_id: String
	public let client_secret: String
	public let redirect_uri: String?
	public let code: String?
	public let refresh_token: String?
	public let scope: String?

	public init(grant_type: GrantType, client_id: String, client_secret: String, redirect_uri: String? = nil, code: String? = nil, refresh_token: String? = nil, scope: String? = nil) {
		self.grant_type = grant_type
		self.client_id = client_id
		self.client_secret = client_secret
		self.redirect_uri = redirect_uri
		self.code = code
		self.refresh_token = refresh_token
		self.scope = scope
	}

	public var method: HTTPMethod {
		return .post
	}

	public var path: String {
		return "access_token"
	}

	public var parameters: Any? {
		var p: [String: AnyObject] = ["grant_type": grant_type.rawValue as AnyObject, "client_id": client_id as AnyObject, "client_secret": client_secret as AnyObject]
		_ = redirect_uri.map { p["redirect_uri"] = $0 as AnyObject }
		_ = code.map { p["code"] = $0 as AnyObject }
		_ = refresh_token.map { p["refresh_token"] = $0 as AnyObject }
		_ = scope.map { p["scope"] = $0 as AnyObject }
		return p
	}
}

public class OAuth2Credential: NSObject, Encodable, NSCoding, Decodable {
	public let accessToken: String // json:"access_token"
	public let tokenType: String // json:"token_type"
	public let refreshToken: String // json:"refresh_token"
	public let expiryIn: Int // json:"expires_in"

	public init(accessToken: String, tokenType: String, refreshToken: String, expiryIn: Int) {
		self.accessToken = accessToken
		self.tokenType = tokenType
		self.refreshToken = refreshToken
		self.expiryIn = expiryIn
	}

	required public init?(coder: NSCoder) {
		var failed = false
		if let accessToken = coder.decodeObject(forKey: "accessToken") as? String {
			self.accessToken = accessToken
		} else {
			self.accessToken = String()  // FIXME: set default value
			failed = true
		}
		if let tokenType = coder.decodeObject(forKey: "tokenType") as? String {
			self.tokenType = tokenType
		} else {
			self.tokenType = String()  // FIXME: set default value
			failed = true
		}
		if let refreshToken = coder.decodeObject(forKey: "refreshToken") as? String {
			self.refreshToken = refreshToken
		} else {
			self.refreshToken = String()  // FIXME: set default value
			failed = true
		}
		expiryIn = coder.decodeInteger(forKey: "expiryIn")
		if failed {
			return // nil
		}
	}

	public func encode(with coder: NSCoder) {
		coder.encode(accessToken, forKey: "accessToken")
		coder.encode(tokenType, forKey: "tokenType")
		coder.encode(refreshToken, forKey: "refreshToken")
		coder.encode(expiryIn, forKey: "expiryIn")
	}

	private enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
		case tokenType = "token_type"
		case refreshToken = "refresh_token"
		case expiryIn = "expires_in"
	}
}

public enum GrantType: String, Encodable {
	case authorizationCode = "authorization_code"
	case clientCredentials = "client_credentials"
	case refreshToken = "refresh_token"
}

