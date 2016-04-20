//
//  AppDelegate.swift
//  Login
//
//  Created by Zach Ambur on 4/6/16.
//  Copyright © 2016 Zach Ambur. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL,
                     sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, openURL: url,
                         sourceApplication: sourceApplication, annotation: annotation)
    }
}
