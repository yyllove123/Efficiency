//
//  AppDelegate.swift
//  Efficiency
//
//  Created by Yalin on 16/3/29.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var splitViewController: UISplitViewController?
    

    static func changeToViewController(controller: UIViewController?) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if controller == nil {
                appDelegate.window!.rootViewController = appDelegate.splitViewController
            }
            else {
                appDelegate.window!.rootViewController = controller
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        if let masterNavController = splitViewController.viewControllers.first as? UINavigationController {
            
            if let masterViewController = masterNavController.topViewController as? MasterViewController {
                splitViewController.delegate = masterViewController
            }
        }
        
        self.splitViewController = splitViewController;
        
        LockManager.applicationDidFinishLaunching(application: application)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        LockManager.applicationWillResignActive(application: application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        LockManager.applicationDidEnterBackground(application: application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        LockManager.applicationWillEnterForeground(application: application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        LockManager.applicationDidBecomeActive(application: application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return DocumentsImportManager.applicationOpenURL(url: url, options: options)
    }
    
}


