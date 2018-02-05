//
//  Alert.swift
//  Health
//
//  Created by Yalin on 15/8/26.
//  Copyright (c) 2015年 Yalin. All rights reserved.
//

import UIKit

struct Alert {
    static func showErrorAlert(title: String?, message: String?) {
        Alert.showAlert(title: title, message: message)
    }
    
    static func showError(error: NSError) {
        Alert.showAlert(title: error.domain, message: error.localizedDescription)
    }
    
    static func showAlert(title: String?, message: String?) {
        Alert.showAlert(title: title, message: message, complete: nil)
    }
    
    static func showAlert(title: String?, message: String?, complete: ((Int) -> Void)?) {
        showAlert(title: title, message: message, cancelButtonTitle: "取消", complete: complete, controller: nil, otherButtonTitles: nil)
    }
    
    static func showAlert(title: String?, message: String?, cancelButtonTitle: String?, complete: ((Int) -> Void)?, controller: UIViewController?, otherButtonTitles: String?...) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        if cancelButtonTitle != nil {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction) in
                complete?(0)
            })
            alertController.addAction(cancelAction)
        }
        
        for i in 0 ..< otherButtonTitles.count {
            let action = UIAlertAction(title: otherButtonTitles[i], style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
                complete?(i + 1)
            })
            alertController.addAction(action)
        }
        
        if controller != nil {
            controller?.present(alertController, animated: true, completion: nil)
        }
        else {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}


extension Alert {
    
}