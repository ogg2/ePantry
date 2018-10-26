//
//  RecipeSearchVC.swift
//  epantry
//
//  Created by Owen Gibson on 10/9/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class RecipeSearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Properites for Specific Recipe
    @IBOutlet weak var recipeName: UILabel?
    @IBOutlet weak var recipePhoto: UIImageView?
    @IBOutlet weak var recipeRating: UILabel?
    @IBOutlet weak var prepTime: UILabel?
    @IBOutlet weak var cuisine: UILabel?
    @IBOutlet weak var instructions: UITextField?
    @IBOutlet weak var recipeList: UITableView?
    
    //MARK: Properties for Recipe Search
    @IBOutlet weak var searchBar: UITextInput!
    @IBOutlet weak var ingredientSuggestions: UIButton?
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ recipeList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeList.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = "Recipe"
        return cell
    }
}
