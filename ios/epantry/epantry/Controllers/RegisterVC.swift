//
//  RegisterVC.swift
//  epantry
//
//  Created by Caleb Cain on 11/5/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
        
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButtonDidClick(_ sender: Any) {
        DispatchQueue.main.async {
            let user = self.username.text!
            var pw = self.password.text!
            var pwConfirm = self.confirmPassword.text!
            
            pw = API.passwordHash(username: user, password: pw)
            pwConfirm = API.passwordHash(username: user, password: pwConfirm)
            print(pw)
            print(pwConfirm)
        
            var registered: Bool = Bool()
        
            if (pw != pwConfirm) {
                self.invalidRegistration(alertMessage: "Passwords don't match")
            } else {
                API.registrationAttempt(username: user, password: pw, completionHandler: { (success, content, error) in
                    registered = success
                    print(registered)
                    if (registered) {
                        self.registrationSuccessful()
                    } else {
                        self.invalidRegistration(alertMessage: "Username already taken")
                    }
                })
            }
        }
    }
    
    func backToLogin() {
        let vc: LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginVC
        self.present(vc, animated: false, completion: {
            print("Registration successful")
        })
    }
    
    func registrationSuccessful() {
        let dialogMessage = UIAlertController(title: "Registration Sucessful", message: "Account created successfully", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.backToLogin()
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func invalidRegistration(alertMessage: String) {
        let dialogMessage = UIAlertController(title: "Invalid Registration", message: alertMessage, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage")
        self.present(vc!, animated: false, completion : {
            print("Logout performed")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmPassword.delegate = self
        
        assignbackground()
    }
    
    func assignbackground(){
        let background = UIImage(named: "pantry.png")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.registerButtonDidClick((Any).self)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
