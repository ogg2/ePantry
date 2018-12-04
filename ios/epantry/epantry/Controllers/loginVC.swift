//
//  loginVC.swift
//  epantry
//
//  Created by Caleb Cain on 10/29/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginAttempt(_ sender: Any) {
        DispatchQueue.main.async {
            let user = self.username.text!
            let pw = self.password.text!
            
            var loggedIn: Bool = Bool()
            
            API.loginAttempt(username: user, password: pw, completionHandler: { (success, content, error) in
                loggedIn = success
                print(loggedIn)
                
                if (loggedIn) {
                    let vc: LaunchPageVC = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage") as! LaunchPageVC
                    self.present(vc, animated: true, completion: {
                        print("login successful")
                    })
                } else {
                    self.invalidLogin()
                }
            })
        }
    }
    
    func invalidLogin() {
        let dialogMessage = UIAlertController(title: "Invalid Login", message: "Login attempt failed.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func registerButtonDidClick(_ sender: Any) {
        let vcRegister = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPage") as! RegisterVC
        self.present(vcRegister, animated: true, completion: {
            print("Registration page presented")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.password.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginAttempt((Any).self)
        return true
    }
}
