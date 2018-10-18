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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("grocery list loaded")
        pantryListTable.delegate = self
        pantryListTable.dataSource = self
    }
    
    var pantryList: [String] = ["Apple", "Pear", "Bread"]
    
    
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
