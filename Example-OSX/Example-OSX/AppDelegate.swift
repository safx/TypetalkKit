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

    override class func initialize() {
        _ = TypetalkAPI.setDeveloperSettings(
            clientId:     "Your ClientID",
            clientSecret: "Your SecretID",
            scopes: [Scope.my, Scope.topic_read],    // e.g. typetalkkit://auth/success
            redirectURI:  "Your custome scheme")
        
        _ = TypetalkAPI.restoreTokenFromAccountStore()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationWillFinishLaunching(_ aNotification: Notification) {
        let appleEventManager:NSAppleEventManager = NSAppleEventManager.shared()
        appleEventManager.setEventHandler(self, andSelector: #selector(AppDelegate.handleGetURLEvent(_:replyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    // MARK - handleURL
    
    func handleGetURLEvent(_ event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        if let ev = event,
            let url_str = ev.forKeyword(AEKeyword(keyDirectObject))?.stringValue,
            let url = URL(string: url_str), TypetalkAPI.isRedirectURL(url) {
                _ = TypetalkAPI.authorizationDone(URL: url)
        }
    }
}

