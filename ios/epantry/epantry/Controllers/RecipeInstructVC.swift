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
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    var recipes = [Recipe]()
    //var myRecipe: MyRecipe?
    //let listofIngredients = ["1 Cup of Milk", "1 T of Pepper"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewInstructions.contentLayoutGuide.bottomAnchor.constraint(equalTo: instructionsLabel.bottomAnchor).isActive = true
        scrollViewIngredients.contentLayoutGuide.bottomAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor).isActive = true
        
        //loadRecipeInfo (name: (myRecipe?.name)!)
        //loadRecipeInfo(name: myRecipe?.name, prepTime: myRecipe?.prepTime, ingredients: myRecipe?.ingredients, instructions: myRecipe?.instructions)
        print("Recipe Instructions Loaded")
    }
    
    func loadRecipeInfo (name: String) {
        recipeNameLabel.text = name
    }
    
    /*func loadRecipeInfo(name: String, prepTime: Int, ingredients: [String], instructions: [String]) {
        recipeNameLabel.text = name
        prepTimeLabel.text = "Preparation Time: \(prepTime) min"
        
        /*for i in 0...(ingredients.count - 1) {
            ingredientsLabel.text = "\(ingredientsLabel?.text ?? "")\n\(ingredients[i])"
        }
        
        for i in 0...(instructions.count - 1) {
            instructionsLabel.text = "\(instructionsLabel?.text ?? "")\n\(instructions[i])"
        }*/
    }*/
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeResults") as! RecipeResultsVC

        for i in 0...(recipes.count - 1) {
            vc.recipes.append(recipes[i])
        }
        
        self.present(vc, animated: false, completion: {
            print("Load List of Recipes")
        })
    }
}
