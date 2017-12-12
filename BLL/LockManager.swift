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
        
        enterLockController()
    }
    
    class func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
    class func applicationWillResignActive(application: UIApplication) {
//        self.enterLockController()
    }
    
    class func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    class func applicationDidEnterBackground(application: UIApplication) {
        //
        self.enterLockController()
    }
    
    static private let plockController = LockViewController()
    static func lockController() -> UIViewController {
        return plockController
    }
    
    static func enterLockController() {
        
        let controller = self.lockController()
        if !(controller.isViewLoaded && controller.view.window != nil) {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                UIApplication.shared.keyWindow?.rootViewController?.present(self.lockController(), animated: true, completion: nil)
            }
        }
        
        
        
//        AppDelegate.changeToViewController(controller: self.lockController())
    }
}
