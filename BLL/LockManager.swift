//
//  LockManager.swift
//  Efficiency
//
//  Created by Yalin on 16/4/3.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class LockManager: NSObject, UIApplicationDelegate {

    static func applicationDidFinishLaunching(application: UIApplication) {
        
        dispatch_after(dispatch_time_t(0.3), dispatch_get_main_queue()) {
            enterLockController()
        }
        
    }
    
    static func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
    static func applicationWillResignActive(application: UIApplication) {
        self.enterLockController()
    }
    
    static func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    static func applicationDidEnterBackground(application: UIApplication) {
        //
        self.enterLockController()
    }
    
    static func lockController() -> UIViewController {
        return LockViewController()
    }
    
    static func enterLockController() {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
//            delegate.window?.rootViewController?.presentViewController(self.lockController(), animated: true, completion: nil)
        }
    }
}
