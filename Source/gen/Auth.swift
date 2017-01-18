// This file was auto-generated from Auth.swift with swift-idl.

import Foundation
import APIKit


public class Authorize: AuthRequest {
	public typealias APIKitResponse = OAuth2Credential
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
		return ["client_id": client_id.toJSON() as AnyObject, "redirect_uri": redirect_uri.toJSON() as AnyObject, "scope": scope.toJSON() as AnyObject, "response_type": response_type.toJSON() as AnyObject]
	}
}

public class AccessToken: AuthRequest {
	public typealias APIKitResponse = OAuth2Credential
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
		var p: [String: AnyObject] = ["grant_type": grant_type.toJSON() as AnyObject, "client_id": client_id.toJSON() as AnyObject, "client_secret": client_secret.toJSON() as AnyObject]
		_ = redirect_uri.map { p["redirect_uri"] = $0.toJSON() as AnyObject }
		_ = code.map { p["code"] = $0.toJSON() as AnyObject }
		_ = refresh_token.map { p["refresh_token"] = $0.toJSON() as AnyObject }
		_ = scope.map { p["scope"] = $0.toJSON() as AnyObject }
		return p
	}
}

public class OAuth2Credential: NSObject, NSCoding, JSONDecodable, JSONEncodable {
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

	public class func parse(with JSONObject: Any) throws -> OAuth2Credential {
		guard let dic = JSONObject as? Dictionary<String, AnyObject> else {
			throw JSONDecodeError.typeMismatch(key: "(GetTeamsResponse)", object: JSONObject, expected: Dictionary<String, AnyObject>.self, actual: type(of: JSONObject))
		}

		let accessToken: String
		if let v: AnyObject = dic["access_token"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "access_token", object: JSONObject)
			} else {
				accessToken = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "access_token", object: JSONObject)
		}

		let tokenType: String
		if let v: AnyObject = dic["token_type"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "token_type", object: JSONObject)
			} else {
				tokenType = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "token_type", object: JSONObject)
		}

		let refreshToken: String
		if let v: AnyObject = dic["refresh_token"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "refresh_token", object: JSONObject)
			} else {
				refreshToken = try String.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "refresh_token", object: JSONObject)
		}

		let expiryIn: Int
		if let v: AnyObject = dic["expires_in"] {
			if v is NSNull {
				throw JSONDecodeError.nonNullable(key: "expires_in", object: JSONObject)
			} else {
				expiryIn = try Int.parse(with: v)
			}
		} else {
			throw JSONDecodeError.missingKey(key: "expires_in", object: JSONObject)
		}

		return OAuth2Credential(accessToken: accessToken, tokenType: tokenType, refreshToken: refreshToken, expiryIn: expiryIn)
	}

	public func toJSON() -> [String: AnyObject] {
		return [
			"access_token": accessToken.toJSON() as AnyObject,
			"token_type": tokenType.toJSON() as AnyObject,
			"refresh_token": refreshToken.toJSON() as AnyObject,
			"expires_in": expiryIn.toJSON() as AnyObject,
		]
	}
}

public enum GrantType: String {
	case AuthorizationCode = "authorization_code"
	case ClientCredentials = "client_credentials"
	case RefreshToken = "refresh_token"

	public func toJSON() -> String {
		return rawValue
	}
}

