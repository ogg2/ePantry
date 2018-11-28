//
//  RecipeInstruct.swift
//  epantry
//
//  Created by Owen Gibson on 11/26/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

//UITableViewDelegate, UITableViewDataSource

class RecipeInstructVC: UIViewController {
    
    
    @IBOutlet weak var scrollViewIngredients: UIScrollView!
    @IBOutlet weak var scrollViewInstructions: UIScrollView!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    let listofIngredients = ["1 Cup of Milk", "1 T of Pepper"]
    
    var ingredientsList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewInstructions.contentLayoutGuide.bottomAnchor.constraint(equalTo: instructions.bottomAnchor).isActive = true
        scrollViewIngredients.contentLayoutGuide.bottomAnchor.constraint(equalTo: ingredients.bottomAnchor).isActive = true
        
        print("Recipe Instructions Loaded")
    }
}
