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
            cuisinePicker.isHidden = true
            cuisineLabel.isHidden = true
            thisCuisine = ""
        default:
            cuisinePicker.isHidden = false
            cuisineLabel.isHidden = false
            thisCuisine = "African"
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeResults") as! RecipeResultsVC
        var query: String
        if searchBar.text == "" {
            query = ""
        } else {
            query = splitAndJoinString(text: searchBar.text!)
        }
        let cuisine = thisCuisine.lowercased()
        
        
        /*guard let recipe1 = Recipe(name: query, photo: photo1, prepTime: 3)
         else {
         fatalError("Unable to show meal1")
         }
         print (vc.recipes.count)
         vc.recipes.append(recipe1)*/
        
        //print (vc.recipes.count)
        
        API.searchRecipes(query: query, cuisine: cuisine, completionHandler: { (ids, names, prepTimes, error) in
            
            if names.count > 0 {
                for i in 0...names.count - 1 {
                    
                    //let photo = UIImage(named: "https://spoonacular.com/recipeImages/\(images[i])")
                    
                    guard let recipe1 = Recipe(name: names[i], missingIngredients: [], prepTime: prepTimes[i], id: ids[i])
                        else {
                            fatalError("Unable to show recipe1")
                    }
                    //add to the [Recipe]
                    vc.recipes.append(recipe1)
                }
                
                self.present(vc, animated: true, completion: {
                    print("Search Results Presented with API Call")
                })
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
        //ingredient = ingredientArray.filter({$0.prefix(searchText.count) == searchText})
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeResults") as! RecipeResultsVC
        var query: String
        if searchBar.text == "" {
            query = ""
        } else {
            query = splitAndJoinString(text: searchBar.text!)
        }
        let cuisine = thisCuisine.lowercased()
        
        /*guard let recipe1 = Recipe(name: query, photo: photo1, prepTime: 3)
            else {
                fatalError("Unable to show meal1")
        }
        print (vc.recipes.count)
        vc.recipes.append(recipe1)*/
        
        //print (vc.recipes.count)
        
        API.searchRecipes(query: query, cuisine: cuisine, completionHandler: { (ids, names, prepTimes, error) in
            
            if names.count > 0 {
                for i in 0...names.count - 1 {
                    
                    //let photo = UIImage(named: "https://spoonacular.com/recipeImages/\(images[i])")
                    
                    guard let recipe1 = Recipe(name: names[i], missingIngredients: ["salmon"], prepTime: prepTimes[i], id: ids[i])
                        else {
                            fatalError("Unable to show recipe1")
                    }
                    //add to the [Recipe]
                    vc.recipes.append(recipe1)
                }
                
                self.present(vc, animated: true, completion: {
                    print("Search Results Presented with API Call")
                })
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
