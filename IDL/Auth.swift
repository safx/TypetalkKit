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
    typealias Response = OAuth2Credential
    let client_id: String
    let redirect_uri: String
    let scope: [Scope]
    let response_type: String = "code"
}

class RequestAuthorizationCode: ClassInit, APIKitHelper, AuthRequest { // router:"POST, access_token"
    typealias Response = OAuth2Credential
    let client_id: String
    let client_secret: String
    let redirect_uri: String
    let code: String
    let grant_type: String = "authorization_code"
}

class RequestRefreshToken: ClassInit, APIKitHelper, AuthRequest { // router:"POST,access_token"
    typealias Response = OAuth2Credential
    let client_id: String
    let client_secret: String
    let refresh_token: String
    let grant_type: String = "refresh_token"
}


class OAuth2Credential: NSObject, ClassInit, NSCoding, JSONDecodable, JSONEncodable {
    public let accessToken: String    // json:"access_token"
    public let tokenType: String      // json:"token_type"
    public let refreshToken: String   // json:"refresh_token"
    public let expiryIn: Int          // json:"expires_in"
    //public let scope: Scope
}
