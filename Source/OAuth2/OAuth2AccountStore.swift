//
//  OAuth2AccountStore.swift
//  TypetalkKit
//
//  Created by Safx Developer on 2014/09/22.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import Foundation

public class OAuth2AccountStore {
    private let serviceName: String
    
    init(serviceName: String) {
        self.serviceName = serviceName
    }
    
    private var attributes: [String:AnyObject] {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            //kSecAttrLabel: SecAttrLabelTypetalk,
        ]
    }
    
    public func queryCredential() -> OAuth2Credential? {
        var attrs = attributes
        attrs[kSecReturnAttributes] = kCFBooleanTrue

        var result: Unmanaged<AnyObject>? = nil
        let status = SecItemCopyMatching(attrs, &result)
        if status == OSStatus(errSecSuccess) {
            if let res = result? {
                let q = res.takeRetainedValue() as NSDictionary
                let k = String(kSecAttrGeneric)
                if let data = q[k] as? NSData {
                    return NSKeyedUnarchiver.unarchiveObjectWithData(data) as OAuth2Credential?
                }
            }
        } else if status != OSStatus(errSecItemNotFound) {
            //
        }
        
        return nil
    }

    public func removeCredential() -> Bool {
        return SecItemDelete(attributes) == OSStatus(errSecSuccess)
    }
    
    public func saveCredential(credential: OAuth2Credential) -> Bool {
        var attrs = attributes
        attrs[kSecAttrGeneric] = NSKeyedArchiver.archivedDataWithRootObject(credential)

        let status = SecItemAdd(attrs, nil)
        if status == OSStatus(errSecDuplicateItem) {
            if removeCredential() {
                return SecItemAdd(attrs, nil) == OSStatus(errSecSuccess)
            }
        }
        return status == OSStatus(errSecSuccess)
    }
}