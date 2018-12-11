//
//  RecipeSearchVC.swift
//  epantry
//
//  Created by Owen Gibson on 10/9/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//UITableViewDelegate, UITableViewDataSource
class RecipeSearchVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cuisinePicker: UIPickerView!
    @IBOutlet weak var cuisineToggle: UISegmentedControl!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var initSearchButton: UIButton!
    @IBOutlet weak var searchingLabel: UILabel!
    
    let cuisinesArray = ["African", "American", "British", "Cajun", "Caribbean", "Chinese", "Eastern European", "French", "German", "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish", "Korean", "Latin American", "Mexican", "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"]
    
    
    var thisCuisine : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        /*for i in 1...ingredientArray.count {
            setupButton(idx: i)
        }*/
        self.searchBar.delegate = self
        initSearchButton.layer.cornerRadius = 17
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
    
    func setupSearchBar() {
    }
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            cuisinePicker.isHidden = false
            cuisineLabel.isHidden = false
            thisCuisine = "African"
        default:
            cuisinePicker.isHidden = true
            cuisineLabel.isHidden = true
            thisCuisine = ""
        }
    }
    
    func numberOfComponents(in cuisinePicker: UIPickerView) -> Int {
        return 1
    }
    
    /*func pickerView(_ cuisinePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cuisines[row]
    }*/
    
    func pickerView(_ cuisinePicker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let title = UILabel()
        
        title.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        title.text =  cuisinesArray[row]
        title.textAlignment = .center
        
        
        return title
        
    }
    
    func pickerView(_ cuisinePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cuisinesArray.count
    }
    
    func pickerView(_ cuisinePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        thisCuisine = cuisinesArray[row]
        cuisineLabel.text = "Search for " + cuisinesArray[row] + " recipes..."
    }
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    
    func splitAndJoinString (text: String) -> String {
        let splitParam = text.components(separatedBy: " ")
        let joinedParam = splitParam.joined(separator: "+")
        
        return joinedParam
    }
    
    @IBAction func initSearchDidClick(_ sender: Any) {
        
        searchingLabel.isHidden = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeResults") as! RecipeResultsVC
        
        vc.recipes = []
        
        var query: String
        if searchBar.text == "" {
            query = ""
        } else {
            query = splitAndJoinString(text: searchBar.text!)
        }
        let cuisine = splitAndJoinString(text: thisCuisine.lowercased())
        
        var pantryList: [String] = [""]
        
        API.getPantryItems(completionHandler: { items, dates in
            pantryList = items
            if (pantryList.count == 0) {
                pantryList = [""]
            }
        })
        
        API.searchRecipes(query: query, cuisine: cuisine, completionHandler: { (ids, names, prepTimes, error) in
            
            if names.count > 0 {
                for i in 0...names.count - 1 {
                    guard let recipe1 = Recipe(name: names[i], missingIngredients: [], prepTime: prepTimes[i], id: ids[i])
                        else {
                            fatalError("Unable to show recipe1")
                    }
                    print (recipe1.name)
                    //add to the [Recipe]
                    vc.recipes.append(recipe1)
                }
                
                for i in 0...vc.recipes.count - 1 {
                    API.getRecipeInfo(id: vc.recipes[i].id, completionHandler: { (name, prepTime, ingredients, ingredientsName, instructions, error) in
                        
                        guard let myRecipe = MyRecipe(name: vc.recipes[i].name, prepTime: prepTime, ingredients: ingredients, ingredientsName: ingredientsName, instructions: instructions)
                            else {
                                fatalError("Unable to load MyRecipe")
                        }
                        
                        vc.recipes[i].prepTime = myRecipe.prepTime
                        vc.recipes[i].missingIngredients = myRecipe.ingredientsName
                        
                        var indexes: [Int] = []
                        for j in 0...vc.recipes[i].missingIngredients.count - 1 {
                            if pantryList.contains(where: vc.recipes[i].missingIngredients[j].contains) {
                                indexes.append(j)
                            }
                        }
                        if indexes.count != 0 {
                            for k in 0...indexes.count - 1 {
                                print ("Removed\(i): \(vc.recipes[i].missingIngredients[indexes[indexes.count - 1 - k]])")
                                vc.recipes[i].missingIngredients.remove(at: indexes[indexes.count - 1 - k])
                                if i == vc.recipes.count - 1 && k == indexes.count - 1{
                                    vc.recipes.sort(by: { $0.missingIngredients.count < $1.missingIngredients.count })
                                    self.present(vc, animated: true, completion: {
                                        print("Search Results Presented with API Call")
                                    })
                                }
                            }
                        } else {
                            if i == vc.recipes.count - 1 {
                                vc.recipes.sort(by: { $0.missingIngredients.count < $1.missingIngredients.count })
                                self.present(vc, animated: true, completion: {
                                    print("Search Results Presented with API Call")
                                })
                            }
                        }
                    })
                }
            }
            else {
                let dialogMessage = UIAlertController(title: "Sorry!", message: "No recipe's exist for your search parameters.", preferredStyle: .alert)
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                })
                //Add OK to dialog message
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        })
    }
}

extension RecipeSearchVC: UISearchBarDelegate {
    func searchBar ( searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        initSearchDidClick((Any).self)
    }
}
