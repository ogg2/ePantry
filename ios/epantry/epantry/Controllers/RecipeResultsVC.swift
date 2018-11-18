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
        
        loadSampleRecipes()
    }
    
    @IBAction func backButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeSearch")
        self.present(vc!, animated: false, completion: {
            print("Back to Recipe Search")
        })
    }
    
    private func loadSampleRecipes() {
        let photo1 = UIImage(named: "avocado.png")
        let photo2 = UIImage(named: "avocado.png")
        
        guard let recipe1 = Recipe(name: "Pizza", photo: photo1)
            else {
                fatalError("Unable to show meal1")
        }
        
        guard let recipe2 = Recipe(name: "Tacos", photo: photo2)
            else {
                fatalError("Unable to show meal1")
        }
        
        recipes += [recipe1, recipe2]
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
        
        cell.recipeImage.image = recipe.photo
        cell.recipeLabel.text = recipe.name
        
        return cell
    }
    
    func tableView(_ recipeResultsTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = recipeResultsTable.cellForRow(at: indexPath)! as UITableViewCell
        print(indexPath.row)
    }
}
