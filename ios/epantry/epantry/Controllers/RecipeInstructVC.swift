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
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var scrollViewIngredients: UIScrollView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var scrollViewInstructions: UIScrollView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var stepsTitleLabel: UILabel!
    
    
    var recipes = [Recipe]()
    var myRecipe = MyRecipe(name: "", prepTime: 0, ingredients: [""], instructions: [""])
    
    //let listofIngredients = ["1 Cup of Milk", "1 T of Pepper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
        scrollViewInstructions.contentLayoutGuide.bottomAnchor.constraint(equalTo: instructionsLabel.bottomAnchor).isActive = true
        scrollViewIngredients.contentLayoutGuide.bottomAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor).isActive = true
        
        scrollViewIngredients.layer.cornerRadius = 17
        scrollViewInstructions.layer.cornerRadius = 17
        
        listTitleLabel.layer.masksToBounds = true
        listTitleLabel.layer.cornerRadius = 4
        stepsTitleLabel.layer.masksToBounds = true
        stepsTitleLabel.layer.cornerRadius = 4
        
        loadRecipeInfo (name: (myRecipe?.name)!, prepTime: (myRecipe?.prepTime)!, listofIngredients: (myRecipe?.ingredients)!, instructionSteps: (myRecipe?.instructions)!)
        //loadRecipeInfo(name: myRecipe?.name, prepTime: myRecipe?.prepTime, ingredients: myRecipe?.ingredients, instructions: myRecipe?.instructions)
        print("Recipe Instructions Loaded")
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
    
    func loadRecipeInfo (name: String, prepTime: Int, listofIngredients: [String], instructionSteps: [String]) {
        recipeNameLabel.text = name
        prepTimeLabel.text = "Preparation Time: \(prepTime) min"
        
        var oldText = ""
        for i in 0...(listofIngredients.count - 1) {
            
            if oldText.isEmpty {
                oldText = "\u{2022} \(listofIngredients[0])"
            } else {
                oldText += "\n\u{2022} \(listofIngredients[i])"
            }
            ingredientsLabel.text = oldText
        }
        
        oldText = ""
        for i in 0...(instructionSteps.count - 1) {
            
            if oldText.isEmpty {
                oldText = "\(i + 1)) \(instructionSteps[0])\n"
            } else {
                oldText += "\n\(i + 1)) \(instructionSteps[i])\n"
            }
            instructionsLabel.text = oldText
        }
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
