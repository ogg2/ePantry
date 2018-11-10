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
    
    @IBOutlet weak var backButton: UIButton!
    
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
                    /* POPUP REGISTRATION SUCCESSFUL MODAL */
                    let vc: LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginVC
                    self.present(vc, animated: false, completion: {
                        print("Registration successful")
                    })
                    self.invalidRegisterLabel.isHidden = true
                } else {
                    self.invalidRegisterLabel.text = "Username already taken"
                    self.invalidRegisterLabel.isHidden = false
                }
            }
        }
    }
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage")
        self.present(vc!, animated: false, completion : {
            print("Logout performed")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invalidRegisterLabel.isHidden = true
    }
}
