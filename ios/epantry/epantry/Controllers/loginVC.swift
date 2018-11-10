//
//  loginVC.swift
//  epantry
//
//  Created by Caleb Cain on 10/29/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var invalidLoginLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginAttempt(_ sender: Any) {
        DispatchQueue.main.async {
            let user = self.username.text!
            let pw = self.password.text!
            
            var loggedIn: Bool = Bool()
            
            API.loginAttempt(username: user, password: pw, completionHandler: { (success, content, error) in
                loggedIn = success
            })
            
            if (loggedIn) {
                let vc: LaunchPageVC = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage") as! LaunchPageVC
                self.present(vc, animated: true, completion: {
                    print("login successful")
                })
            } else {
                print("Invalid Login")
                self.invalidLoginLabel.isHidden = false
            }
        }
    }
    
    @IBAction func registerButtonDidClick(_ sender: Any) {
        let vcRegister = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPage") as! RegisterVC
        self.present(vcRegister, animated: true, completion: {
            print("Registration page presented")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invalidLoginLabel.isHidden = true
    }
}
