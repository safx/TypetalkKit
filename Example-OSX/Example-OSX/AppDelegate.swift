//
//  AppDelegate.swift
//  TypetalkSample-OSX
//
//  Created by Safx Developer on 2015/01/29.
//  Copyright (c) 2015年 Safx Developers. All rights reserved.
//

import Cocoa
import TypetalkKit


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        _ = TypetalkAPI.setDeveloperSettings(
            clientId:     "Your_ClientID",
            clientSecret: "Your_SecretID",
            scopes: [Scope.my, Scope.topicRead],
            redirectURI:  "Your_custome_scheme")    // e.g. typetalkkit://auth/success
        
        _ = TypetalkAPI.restoreTokenFromAccountStore()
    }
    
    func applicationWillFinishLaunching(_ aNotification: Notification) {
        let appleEventManager:NSAppleEventManager = NSAppleEventManager.shared()
        appleEventManager.setEventHandler(self, andSelector: #selector(AppDelegate.handleGetURLEvent(_:replyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    // MARK - handleURL
    
    @objc func handleGetURLEvent(_ event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        if let ev = event,
            let url_str = ev.forKeyword(AEKeyword(keyDirectObject))?.stringValue,
            let url = URL(string: url_str), TypetalkAPI.isRedirectURL(url) {
                _ = TypetalkAPI.authorizationDone(URL: url)
        }
    }
}

