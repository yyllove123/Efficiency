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
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            enterLockController()
        }
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
