//
//  API.swift
//  epantry
//
//  Created by Caleb Cain on 10/22/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    /*
     Perform networking code in here to access backend and get pantry items for specific user
     */
    static func getPantryItems(userId: String, completionHandler: (_ result:[String]) -> Void) {
        Alamofire.request("url")
        completionHandler(["Bread", "Soup", "Pear", "Tomato"])
    }
    
    /*
     Perform networking code to access grocery list items for specific user
    */
    static func getGroceryListItems(userId: String, completionHandler: (_ result:[String]) -> Void) {
        Alamofire.request("url")
        completionHandler(["Tomato", "Pear", "Soup", "Bread"])
    }
    
    static func loginAttempt(username: String, password: String, completionHandler: (Bool, Any?, Error?) -> Void) {
        Alamofire.request("url")
        var responseContent: Any?
        if (username == "admin" && password == "12345"/*request login is successful statusZ*/) {
            completionHandler(true, responseContent, nil)
        } else {
            completionHandler(false, responseContent, nil)
        }
    }
    
}
