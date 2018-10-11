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
    
    @IBAction func backButtonDidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchPage")
        self.present(vc!, animated: false, completion: {
            print("Back to Home")
        })
    }
    
    func tableView(_ groceryList: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will be the number of grocery list unique items in their data base table
        print("4 rows")
        return 4
    }
    
    func tableView(_ groceryList: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groceryList.dequeueReusableCell(withIdentifier: "pantryItemCell", for: indexPath)
        cell.textLabel?.text = "Pantry Item"
        return cell
    }
    
    func tableView(_ groceryList: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = groceryList.cellForRow(at:indexPath)! as UITableViewCell
        print(indexPath)
    }
    
}
