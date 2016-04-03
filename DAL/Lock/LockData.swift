//
//  LockData.swift
//  Efficiency
//
//  Created by Yalin on 16/4/3.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

struct LockData {
    
    static func havePassword() -> Bool {
        if let password = NSUserDefaults.standardUserDefaults().objectForKey("password") as? String {
            if password != "" {
                return true
            }
        }
        return false
    }
    
    static func setPassword(password: String) {
        NSUserDefaults.standardUserDefaults().setValue(password.md5Value, forKey: "password")
    }
    
    static func checkPassword(password: String) -> Bool {
        if let oldMd5Password = NSUserDefaults.standardUserDefaults().objectForKey("password") as? String {
            if password.md5Value == oldMd5Password {
                return true
            }
        }
        return false
    }
}
