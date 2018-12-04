//
//  myPantryVC.swift
//  epantry
//
//  Created by Caleb Cain on 10/11/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class myPantryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pantryListTable: UITableView!
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    var pantryList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pantry list loaded")
        pantryListTable.delegate = self
        pantryListTable.dataSource = self
        
        /*
        API.getItems is call to get items and then it reloads the table data ..
        make another API file that has methods (getitems) -> completion blocl
        gives you an array of items that is stored in items.. should be a bunch of
        static methods in the file so that all of our networking code is abstracted
        in to that file and not dealt with in our view controllers
        */
        
        API.getPantryItems(completionHandler: { items in
            self.pantryList = items
            self.pantryListTable.reloadData()
            
            if (self.pantryList.count == 0) {
                self.emptyList()
            }
        })
        
    }
    
    func emptyList() {
        let dialogMessage = UIAlertController(title: "Empty Pantry", message: "Pantry has no items.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    /*
    Load pantry list from backend
    Backend needs updating if we perform edits on pantry screen
        Add? Or just delete functionality? -> add comes from grocery list .. should probably give option though
    */
    
    func tableView(_ groceryList: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will be the number of grocery list unique items in their data base table
        print(pantryList.count)
        return pantryList.count
    }
    
    func tableView(_ groceryList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryList.dequeueReusableCell(withIdentifier: "pantryItemCell", for: indexPath)
        cell.textLabel?.text = pantryList[indexPath.row]
        return cell
    }
    
    func tableView(_ groceryList: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = groceryList.cellForRow(at:indexPath)! as UITableViewCell
        print(indexPath)
    }
    
}
