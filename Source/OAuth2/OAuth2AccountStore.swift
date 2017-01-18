//
//  OAuth2AccountStore.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

open class OAuth2AccountStore {
    fileprivate let serviceName: String
    
    init(serviceName: String) {
        self.serviceName = serviceName
    }
    
    fileprivate var attributes: [String:AnyObject] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName as AnyObject,
        ]
    }
    
    open func queryCredential() -> OAuth2Credential? {
        var attrs = attributes
        attrs[kSecReturnAttributes as String] = kCFBooleanTrue

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(attrs as CFDictionary, UnsafeMutablePointer($0)) }

        if status == OSStatus(errSecSuccess) {
            let q = result as! NSDictionary
            let k = String(kSecAttrGeneric)
            if let data = q[k] as? Data {
                return NSKeyedUnarchiver.unarchiveObject(with: data) as! OAuth2Credential?
            }
        } else if status != OSStatus(errSecItemNotFound) {
            //
        }
        
        return nil
    }

    open func removeCredential() -> Bool {
        return SecItemDelete(attributes as CFDictionary) == OSStatus(errSecSuccess)
    }
    
    open func saveCredential(_ credential: OAuth2Credential) -> Bool {
        var attrs = attributes
        attrs[kSecAttrGeneric as String] = NSKeyedArchiver.archivedData(withRootObject: credential) as AnyObject?

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { SecItemAdd(attrs as CFDictionary, UnsafeMutablePointer($0)) }

        if status != OSStatus(errSecDuplicateItem) {
            return status == OSStatus(errSecSuccess)
        }
        guard removeCredential() else {
            return false
        }

        let retryStatus = withUnsafeMutablePointer(to: &result) { SecItemAdd(attrs as CFDictionary, UnsafeMutablePointer($0)) }
        return retryStatus == OSStatus(errSecSuccess)
    }
}
