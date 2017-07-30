//
//  Auth.swift
//  IDL
//
//  Created by Safx Developer on 2015/08/10.
//  Copyright © 2015年 Safx Developers. All rights reserved.
//

import Foundation
import APIKit


class Authorize: ClassInit, APIKitHelper, AuthRequest { // router:",authorize"
    typealias APIKitResponse = OAuth2Credential
    let client_id: String
    let redirect_uri: String
    let scope: String
    let response_type: String = "code"
}

class AccessToken: ClassInit, APIKitHelper, AuthRequest { // router:"POST, access_token"
    typealias APIKitResponse = OAuth2Credential
    let grant_type: GrantType
    let client_id: String
    let client_secret: String
    let redirect_uri: String? = nil   // AuthorizationCode
    let code: String? = nil           // AuthorizationCode
    let refresh_token: String? = nil  // RefreshToken
    let scope: String? = nil          // ClientCredentials
}

class OAuth2Credential: NSObject, ClassInit, NSCoding, Decodable, Encodable {
    open let accessToken: String    // json:"access_token"
    open let tokenType: String      // json:"token_type"
    open let refreshToken: String   // json:"refresh_token"
    open let expiryIn: Int          // json:"expires_in"
    //public let scope: Scope
}

enum GrantType: String, Encodable {
    case AuthorizationCode = "authorization_code"
    case ClientCredentials = "client_credentials"
    case RefreshToken      = "refresh_token"
}
