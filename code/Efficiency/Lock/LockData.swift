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
        if let password = UserDefaults.standard.object(forKey: "password") as? String {
            if password != "" {
                return true
            }
        }
        return false
    }
    
    static func setPassword(password: String) {
        UserDefaults.standard.set(password.md5Value, forKey: "password")
        // setValue(password.md5Value, forKey: "password")
    }
    
    static func checkPassword(password: String) -> Bool {
        if let oldMd5Password = UserDefaults.standard.object(forKey: "password") as? String {
            if password.md5Value == oldMd5Password {
                return true
            }
        }
        return false
    }
}
