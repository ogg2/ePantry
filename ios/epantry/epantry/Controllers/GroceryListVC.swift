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
        groceryListTable.delegate = self
        groceryListTable.dataSource = self
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var groceryListTable: UITableView!
    
    // Will populate this list from database grocery list items
    var groceryList: [String] = ["Apple", "Pear", "Bread"]
    
    /*
     Need a function to populate the grocery list from the database
     Need a function to update the database when the list is updated
        Don't need to send data between view controllers because it is all being stored on the backend
        Just need to make sure that the presentation is correct
    */
    
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
        // Database operation to add selected items to pantry
        // Database operation to remove selected items from grocery list
        print("Import items to Pantry")
    }
    
    @IBAction func editButtonDidClick(_ sender: Any) {
        // Present option to add item?
        // Allow deletion of item or change of text
        print("Edit items now")
    }
    
    func tableView(_ groceryListTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will be the number of unique grocery list items in their data base table
        return groceryList.count
    }
    
    func tableView(_ groceryListTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryListTable.dequeueReusableCell(withIdentifier: "groceryItemCell", for: indexPath)
        cell.textLabel?.text = groceryList[indexPath.row]
        return cell
    }
    
    func tableView(_ groceryListTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = groceryListTable.cellForRow(at:indexPath)! as UITableViewCell
        print(indexPath.row)
    }
    
}
