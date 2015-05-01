//
//  AccessToken.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class OAuth2Credential : NSObject, NSCoding {
    public let accessToken: String
    public let tokenType: String
    public let refreshToken: String
    public let scopes: [Scope]
    public let expiryDate: NSDate

    public init(dictionary dictionaryValue: [NSObject : AnyObject], error: NSErrorPointer) {
        var accessToken: String = ""
        var tokenType: String = ""
        var refreshToken: String = ""
        var scopes: [Scope] = []
        var expiryDate: NSDate = NSDate()

        for (k,v) in dictionaryValue {
            switch k {
            case "access_token": accessToken = v as! String
            case "token_type": tokenType = v as! String
            case "expires_in": expiryDate = NSDate(timeIntervalSinceNow: NSTimeInterval(v as! Int))
            case "refresh_token": refreshToken = v as! String
            case "scope": scopes = Scope.scopesFromRaw(v as! String)
            default:
                println("ERROR: \(k) = \(v)") // FIXME
            }
        }
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiryDate = expiryDate
        self.refreshToken = refreshToken
        self.scopes = scopes
    }

    required public init(coder: NSCoder) {
        accessToken  = coder.decodeObjectForKey("accessToken") as! String
        refreshToken = coder.decodeObjectForKey("refreshToken") as! String
        expiryDate   = coder.decodeObjectForKey("expiryDate") as! NSDate
        tokenType    = coder.decodeObjectForKey("tokenType") as! String
        scopes       = Scope.scopesFromRaw(coder.decodeObjectForKey("scopes") as! String)
    }

    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(accessToken,  forKey: "accessToken")
        coder.encodeObject(refreshToken, forKey: "refreshToken")
        coder.encodeObject(expiryDate, forKey: "expiryDate")
        coder.encodeObject(tokenType, forKey: "tokenType")
        coder.encodeObject(Scope.scopesToRaw(scopes), forKey: "scopes")
    }
}
