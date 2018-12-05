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
        assignbackground()
        print("grocery list loaded")
        groceryListTable.delegate = self
        groceryListTable.dataSource = self
        
        API.getGroceryListItems(completionHandler: { items in
            self.groceryList = items
            self.groceryListTable.reloadData()
            
            if (self.groceryList.count == 0) {
                self.emptyList()
            }
        })
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
    
    func emptyList() {
        let dialogMessage = UIAlertController(title: "Empty Grocery List", message: "Grocery list has no items.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var groceryListTable: UITableView!
    
    // Will populate this list from database grocery list items
    var groceryList: [String] = []
    
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
    
    @IBAction func addButtonDidClick(_ sender: Any) {
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
