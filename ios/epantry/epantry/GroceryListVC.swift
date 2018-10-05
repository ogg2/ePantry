//
//  GroceryListVC.swift
//  epantry
//
//  Created by Caleb Cain on 10/2/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class GroceryListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("grocery list loaded")
        groceryList.delegate = self
        groceryList.dataSource = self
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var groceryList: UITableView!
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    @IBAction func importButtonDidClick(_ sender: Any) {
        // Present check boxes for selecting items
        // Selected items will be removed from list and moved to pantry
        // Non selected items will stay on list
        print("Import items to Pantry")
    }
    
    @IBAction func editButtonDidClick(_ sender: Any) {
        // Present option to add item?
        // Allow deletion of item or change of text
        print("Edit items now")
    }
    
    func tableView(_ groceryList: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will be the number of grocery list unique items in their data base table
        print("4 rows")
        return 4
    }
    
    func tableView(_ groceryList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryList.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = "Grocery Item"
        return cell
    }
    
    func tableView(_ groceryList: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = groceryList.cellForRow(at:indexPath)! as UITableViewCell
        print(indexPath)
    }
    
}
