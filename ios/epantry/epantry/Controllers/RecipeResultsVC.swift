//
//  RecipeResultsVC.swift
//  epantry
//
//  Created by Owen Gibson on 11/18/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class RecipeResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recipeResultsTable: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
        recipeResultsTable.delegate = self
        recipeResultsTable.dataSource = self
        print("Recipe Results Loaded")
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
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeSearch")
        self.present(vc!, animated: false, completion: {
            print("Back to Recipe Search")
        })
    }
    
    func tableView(_ recipeResultsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ recipeResultsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
        
        
        guard let cell = recipeResultsTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let recipe = recipes[indexPath.row]
        
        cell.recipeLabel.text = recipe.name
        cell.prepTime.text = "Ready in \(recipe.prepTime) minutes!"
        if recipe.missingIngredients.count == 0 {
            cell.missingIngredients.text = "You have all the ingredients for this recipe!"
        }
        else {
            cell.missingIngredients.text = "You still need "
            for i in 0...recipe.missingIngredients.count - 1 {
                if recipe.missingIngredients.count == 1 {
                    cell.missingIngredients.text?.append("\(recipe.missingIngredients[i]) to make this recipe.")
                }
                else {
                    if i <= 2 && recipe.missingIngredients.count > 2 {
                        if i == 2 {
                            cell.missingIngredients.text?.append("and \(recipe.missingIngredients.count - 2) more ingredients to make this recipe.")
                        } else {
                            cell.missingIngredients.text?.append("\(recipe.missingIngredients[i]), ")
                        }
                    }
                    if i < 3 && recipe.missingIngredients.count <= 2 {
                        if i == recipe.missingIngredients.count - 1{
                            cell.missingIngredients.text?.append("and \(recipe.missingIngredients[i]) to make this recipe.")
                        } else {
                            cell.missingIngredients.text?.append("\(recipe.missingIngredients[i]), ")
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ recipeResultsTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeInstruct") as! RecipeInstructVC
        
        API.getRecipeInfo(id: recipes[indexPath.row].id, completionHandler: { (name, prepTime, ingredients, ingredientsName, instructions, error) in
            
            guard let myRecipe = MyRecipe(name: self.recipes[indexPath.row].name, prepTime: self.recipes[indexPath.row].prepTime, ingredients: ingredients, ingredientsName: ingredientsName, instructions: instructions)
                else {
                    fatalError("Unable to load MyRecipe")
            }
            
            vc.myRecipe = myRecipe
            vc.recipes = self.recipes
            
            self.present(vc, animated: false, completion: {
                print("Load Recipe Info for Selected Recipe with API Call")
            })
        })
    }
}
