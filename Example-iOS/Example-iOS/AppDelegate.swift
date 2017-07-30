//
//  AppDelegate.swift
//  iOSExample
//
//  Created by Safx Developer on 2014/09/17.
//  Copyright (c) 2014年 Safx Developers. All rights reserved.
//

import UIKit
import TypetalkKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        //navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        _ = TypetalkAPI.setDeveloperSettings(
            clientId:     "Your ClientID",
            clientSecret: "Your SecretID",
            scopes: [Scope.my, Scope.topicRead],    // e.g. typetalkkit://auth/success
            redirectURI:  "Your custome scheme")

        _ = TypetalkAPI.restoreTokenFromAccountStore()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if TypetalkAPI.isRedirectURL(url) {
            if #available(iOS 9.0, *) {
                if let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?, sourceApplication == "com.apple.mobilesafari" {
                    return TypetalkAPI.authorizationDone(URL: url)
                }
            } else {
                // Fallback on earlier versions
            }
        }
        return false
    }
    
    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController {
                if topAsDetailController.detailItem == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }

}

