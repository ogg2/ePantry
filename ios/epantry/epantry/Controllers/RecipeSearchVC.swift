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
    
    @IBOutlet weak var searchBar: UISearchBar!
    let ingredientArray = ["Apple", "Banana", "Orange"]
    let button = UIButton()
    var ingredient = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    func setupSearchBar() {
        
    }
    
    func setupButton () {
        //let button = UIButton()
        button.frame = CGRect(x: 10, y: 630, width: 300, height: 70)
        view.addSubview(button)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(ingredientArray[0], for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 17
        
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
    }
    
    @objc func buttonWasTapped() {
        searchBar.text = "\(searchBar.text!) \(button.currentTitle!)"
    }
    
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

extension RecipeSearchVC: UISearchBarDelegate {
    func searchBar ( searchBar: UISearchBar, textDidChange searchText: String) {
        ingredient = ingredientArray.filter({$0.prefix(searchText.count) == searchText})
    }
}
