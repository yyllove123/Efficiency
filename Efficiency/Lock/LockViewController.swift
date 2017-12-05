//
//  LockViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/4/3.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import LocalAuthentication

class LockViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    
    convenience init() {
        self.init(nibName: "LockViewController", bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if LockData.havePassword() {
            passwordTextField.placeholder = "输入密码，我会自动检测!"
        }
        else {
            passwordTextField.placeholder = "没有设置密码,按回车确定密码"
            passwordTextField.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterForegroundNoti), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        faceIdCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func enterForegroundNoti() {
        faceIdCheck()
    }
    
    func faceIdCheck() {
        
        var error: NSError? = nil
        
        let authenticationContext = LAContext()
        if authenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "输入自己", reply: { [unowned self] (success, err) in
                
                DispatchQueue.main.async { [unowned self] in
                    if success {
                        self.passwordTextField.resignFirstResponder()
                        AppDelegate.changeToViewController(controller: nil)
                        
                        authenticationContext.invalidate()
                    }
                    else {
                        self.passwordTextField.becomeFirstResponder()
                    }
                }
            })
        }
        else {
            passwordTextField.becomeFirstResponder()
        }
        
    }

    @IBAction func sureButtonPressed(sender: AnyObject) {
        if passwordTextField.text != nil {
            if LockData.havePassword() {
                if LockData.checkPassword(password: passwordTextField.text!) {
                    passwordTextField.resignFirstResponder()
                    AppDelegate.changeToViewController(controller: nil)
                }
            }
            else {
                LockData.setPassword(password: passwordTextField.text!)
                passwordTextField.resignFirstResponder()
                AppDelegate.changeToViewController(controller: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
