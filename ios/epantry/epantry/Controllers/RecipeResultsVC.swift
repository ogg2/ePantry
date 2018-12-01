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
        
        recipeResultsTable.delegate = self
        recipeResultsTable.dataSource = self
        print("Recipe Results Loaded")
        
        //loadRecipes()
    }
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeSearch")
        self.present(vc!, animated: false, completion: {
            print("Back to Recipe Search")
        })
    }
    
    /*private func loadRecipes() {
        let photo1 = UIImage(named: "avocado.png")
        let photo2 = UIImage(named: "avocado.png")
        
        /*for i in 0...(recipes.count - 1) {
            vc.recipes.append(recipes[i])
        }*/
        
        guard let recipe1 = Recipe(name: "Pizza", photo: photo1, prepTime: 45)
            else {
                fatalError("Unable to show meal1")
        }
        
        guard let recipe2 = Recipe(name: "Tacos", photo: photo2, prepTime: 60)
            else {
                fatalError("Unable to show meal2")
        }
        
        recipes += [recipe1, recipe2]
    }*/
    
    func tableView(_ recipeResultsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ recipeResultsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
        
        guard let cell = recipeResultsTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let recipe = recipes[indexPath.row]
        
        cell.recipeImage.image = recipe.photo
        cell.recipeLabel.text = recipe.name
        cell.prepTime.text = "Ready in \(recipe.prepTime) minutes!"
        
        return cell
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! RecipeInstructVC
        
        guard let myRecipe = MyRecipe(name: "Chicken", prepTime: 45, ingredients: ["chicken"], instructions: ["Cut Chicken"])
            else {
                fatalError("Unable to load MyRecipe")
        }
        
        //nextVC.myRecipe = myRecipe
        nextVC.recipes = recipes
    }*/
    
    func tableView(_ recipeResultsTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeInstruct") as! RecipeInstructVC
        //let currentCell = recipeResultsTable.cellForRow(at: indexPath)! as UITableViewCell
        print("This Cell: \(recipes[indexPath.row].name)")
        
        guard let myRecipe = MyRecipe(name: recipes[indexPath.row].name, prepTime: recipes[indexPath.row].prepTime, ingredients: ["chicken", "egg", "bacon"], instructions: ["Cut Chicken into Cubes. This is a really long instruction set.", "Place chicken on cooking sheet", "put chicken in oven"])
            else {
                fatalError("Unable to load MyRecipe")
        }
        
        vc.myRecipe = myRecipe
        vc.recipes = recipes
        
        //vc.myRecipe = myRecipe
        
        //performSegue(withIdentifier: "segue", sender: self)
        self.present(vc, animated: false, completion: {
            print("Load Instructions for Selected Recipe")
        })
    }
}
