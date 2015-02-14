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
    
    override class func load() {
        Client.sharedClient.setDeveloperSettings(
            clientId:     "Your ClientID",
            clientSecret: "Your SecretID",
            redirectURI:  "Your custome scheme",    // e.g. typetalkkit://auth/success
            scopes: [Scope.my, Scope.topic_read])
        Client.sharedClient.restoreTokenFromAccountStore()
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }

    func applicationWillFinishLaunching(aNotification: NSNotification) {
        var appleEventManager:NSAppleEventManager = NSAppleEventManager.sharedAppleEventManager()
        appleEventManager.setEventHandler(self, andSelector: "handleGetURLEvent:replyEvent:",
            forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    // MARK - handleURL
    
    func handleGetURLEvent(event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        if let ev = event {
            if let url_str = ev.descriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue {
                if let url = NSURL(string: url_str) {
                    if Client.sharedClient.isRedirectURL(url) {
                        Client.sharedClient.authorizationDone(URL: url)
                    }
                }
            }
        }
    }
}

