//
//  RegisterVC.swift
//  epantry
//
//  Created by Caleb Cain on 11/5/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var invalidRegisterLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButtonDidClick(_ sender: Any) {
        DispatchQueue.main.async {
            let user = self.username.text!
            let pw = self.password.text!
            let pwConfirm = self.confirmPassword.text!
        
            var registered: Bool = Bool()
        
            if (pw != pwConfirm) {
                self.invalidRegisterLabel.isHidden = false
                self.invalidRegisterLabel.text = "Passwords don't match"
            } else {
                API.registrationAttempt(username: user, password: pw, completionHandler: { (success, content, error) in
                    registered = success
                })
            
                if (registered) {
                    /* Need to tell user they registered successfully somehow */
                    
                    self.invalidRegisterLabel.isHidden = true
                } else {
                    self.invalidRegisterLabel.text = "Username already taken"
                    self.invalidRegisterLabel.isHidden = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.center = view.center
        self.password.center = view.center
        self.confirmPassword.center = view.center
        self.username.center = view.center
        self.usernameLabel.center = view.center
        self.passwordLabel.center = view.center
        self.confirmPasswordLabel.center = view.center
        self.invalidRegisterLabel.center = view.center
        self.invalidRegisterLabel.isHidden = true
    }
}
