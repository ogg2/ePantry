//
//  RecipeResultsVC.swift
//  epantry
//
//  Created by Owen Gibson on 11/17/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class RecipeResultsVC: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
}
