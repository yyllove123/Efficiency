//
//  LockManager.swift
//  Efficiency
//
//  Created by Yalin on 16/4/3.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class LockManager: NSObject {

    class func applicationDidFinishLaunching(application: UIApplication) {
        
//        dispatch_after(dispatch_time_t(0.3), DispatchQueue.main) {
//            enterLockController()
//        }
        
    }
    
    class func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
    class func applicationWillResignActive(application: UIApplication) {
        self.enterLockController()
    }
    
    class func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    class func applicationDidEnterBackground(application: UIApplication) {
        //
        self.enterLockController()
    }
    
    static func lockController() -> UIViewController {
        return LockViewController()
    }
    
    static func enterLockController() {
        
        AppDelegate.changeToViewController(controller: self.lockController())
    }
}
