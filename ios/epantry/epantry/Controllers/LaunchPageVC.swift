//
//  ViewController.swift
//  epantry
//
//  Created by Caleb Cain on 9/28/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import UIKit

class LaunchPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var pantryButton: UIButton!
    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var groceryListButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!

    @IBAction func groceryListButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroceryList")
        self.present(vc!, animated: true, completion: {
            print("Grocery List Presented")
        })
    }
    
    @IBAction func pantryButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PantryList")
        self.present(vc!, animated: true, completion: {
            print("Pantry list presented")
        })
    }
    
    @IBAction func recipeButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeSearch")
        self.present(vc!, animated: true, completion: {
            print("Recipe search presented")
        })
    }
    
    @IBAction func logoutButtonDidClick(_ sender: Any) {
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.logout()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func logout() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage")
        self.present(vc!, animated: false, completion : {
            print("Logout performed")
        })
    }
}

