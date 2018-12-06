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
            print("empty list OK")
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
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    @IBAction func importButtonDidClick(_ sender: Any) {
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to import all items to your pantry?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            API.moveItemsToPantry(items: self.groceryList, completionHandler: { success in
                if (success) {
                    API.getGroceryListItems(completionHandler: { items in
                        self.groceryList = items
                        self.groceryListTable.reloadData()
                        
                        if (self.groceryList.count == 0) {
                            self.emptyList()
                        }
                    })
                    self.importSuccessful()
                } else {
                    self.itemsNotImported()
                }
            })
            print("Import items to Pantry")
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func itemsNotImported() {
        let dialogMessage = UIAlertController(title: "Import Failed", message: "Could not import items to pantry", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func importSuccessful() {
        let dialogMessage = UIAlertController(title: "Import Success", message: "Items successfully imported to pantry", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func addButtonDidClick(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Add item to Grocery List", preferredStyle: .alert)
        
        dialogMessage.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Item to add"
        })
        
        let textField: UITextField = dialogMessage.textFields![0] as UITextField
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            let item: String = textField.text!
            print(item)
            API.addItemToGrocery(item: item, completionHandler: { success in
                if (success) {
                    API.getGroceryListItems(completionHandler: { items in
                        self.groceryList = items
                        self.groceryListTable.reloadData()
                        
                        if (self.groceryList.count == 0) {
                            self.emptyList()
                        }
                    })
                } else {
                    print("Failed to add")
                }
            })
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func removeFromGroceryList(item: String) {
        let dialogMessage = UIAlertController(title: "Remove Item", message: "Are you sure you want to remove this item?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            API.removeItemFromGroceryList(item: item, completionHandler: { success in
                if (success) {
                    print("Item removed")
                    API.getGroceryListItems(completionHandler: { items in
                        self.groceryList = items
                        self.groceryListTable.reloadData()
                        
                        if (self.groceryList.count == 0) {
                            self.emptyList()
                        }
                    })
                } else {
                    print("Failed to remove")
                }
            })
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
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
        //currentCell.accessoryType = UITableViewCell.AccessoryType.checkmark
        let item: String = currentCell.textLabel!.text!
        removeFromGroceryList(item: item)
        print(currentCell.textLabel!.text!)
    }
    
}
