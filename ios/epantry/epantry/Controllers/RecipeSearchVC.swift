//
//  RecipeSearchVC.swift
//  epantry
//
//  Created by Owen Gibson on 10/9/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit
//UITableViewDelegate, UITableViewDataSource
class RecipeSearchVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    //@IBOutlet weak var cuisineButton: UIButton!
    @IBOutlet weak var cuisinePicker: UIPickerView!
    @IBOutlet weak var cuisineToggle: UISegmentedControl!
    @IBOutlet weak var cuisineLabel: UILabel!
    
    let cuisinesArray = ["African", "Chinese", "Japanese", "Korean", "Vietnamese", "Thai", "Indian", "British", "Irish", "French", "Italian", "Mexican", "Spanish", "Middle Eastern", "Jewish", "American", "Cajun", "Southern", "Greek", "German", "Nordic", "Eastern European", "Caribbean", "Latin American"]
    
    var thisCuisine : String = ""
    
    //let ingredientArray = ["Apple", "Banana", "Orange", "Avocado", "Bread", "Cheese", "Eggs", "Milk"]
    //let button = UIButton()
    //var ingredient = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*for i in 1...ingredientArray.count {
            setupButton(idx: i)
        }*/
        self.searchBar.delegate = self
    }
    
    func setupSearchBar() {
    }
    
    /*@IBAction func cuisineButtonDidClick(_ sender: Any) {
        cuisinePicker.isHidden = false
    }*/
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            cuisinePicker.isHidden = false
            cuisineLabel.isHidden = false
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
        
        title.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
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
    
    /*func setupButton (idx: Int) {
        let button = UIButton()
        if idx % 2 == 1 {
            button.frame = CGRect(x: 30, y: 150 + idx * 50, width: 150, height: 70)
        } else {
            button.frame = CGRect(x: 235, y: 100 + idx * 50, width: 150, height: 70)
        }
        button.setTitleColor(.white, for: .normal)
        button.setTitle(ingredientArray[idx - 1], for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 17
        //button.sizeToFit()
        view.addSubview(button)
        /*button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        button.topAnchor.constraint(equalTo: searchBar.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.*/
        
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
    }*/
    
    /*@objc func buttonWasTapped(sender:UIButton!) {
        searchBar.text = "\(searchBar.text!) \(sender.currentTitle!)"
    }*/
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ recipeList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeList.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = "Recipe"
        return cell
    }*/
    
    func splitAndJoinString (text: String) -> String {
        let splitParam = text.components(separatedBy: " ")
        let joinedParam = splitParam.joined(separator: "+")
        
        return joinedParam
    }
}

extension RecipeSearchVC: UISearchBarDelegate {
    func searchBar ( searchBar: UISearchBar, textDidChange searchText: String) {
        //ingredient = ingredientArray.filter({$0.prefix(searchText.count) == searchText})
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeResults") as! RecipeResultsVC
        let query = splitAndJoinString(text: searchBar.text!)
        let cuisine = thisCuisine.lowercased()
        let photo1 = UIImage(named: "avocado.png")
        
        print (query)
        print (cuisine)
        guard let recipe1 = Recipe(name: query, photo: photo1, prepTime: 3)
            else {
                fatalError("Unable to show meal1")
        }
        print (vc.recipes.count)
        vc.recipes.append(recipe1)
        
        print (vc.recipes.count)
        
        self.present(vc, animated: false, completion: {
            print("Load List of Recipes")
        })
        /*API.searchRecipes(query: query, cuisine: "japanese", completionHandler: { (ids, names, prepTimes, images, error) in
            guard let recipe1 = Recipe(name: names[0], photo: images[0], prepTime: 45)
                else {
                    fatalError("Unable to show meal1")
            }
            
            //add to the [Recipe]
            vc.recipes.append(recipe1)
            self.present(vc, animated: true, completion: {
                print("Search Results Presented")
            })
        })*/
    }
}
