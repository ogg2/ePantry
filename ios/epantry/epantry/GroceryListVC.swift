//
//  GroceryListVC.swift
//  epantry
//
//  Created by Caleb Cain on 10/2/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class GroceryListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    @IBAction func importButtonDidClick(_ sender: Any) {
        print("Import items to Pantry")
    }
    
    @IBAction func editButtonDidClick(_ sender: Any) {
        print("Edit items now")
    }
    
}
