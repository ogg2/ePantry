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
    
    /*
     Perform networking code to attempt to login
    */
    static func loginAttempt(username: String, password: String, completionHandler: @escaping (Bool, Any?, Error?) -> Void) {
        DispatchQueue.main.async {
            let parameters: [String: String] = ["username": username, "password": password]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        //print(JSON["userid"]!)
                        var userId: String
                        userId = JSON["userid"]! as! String
                        Defaults.userId = userId
                        print(Defaults.userId!)
                    }
                    completionHandler(true, response, nil)
                case .failure(let error):
                    print(error)
                    completionHandler(false, response, nil)
                }
            }
        }
    }
    
    /*
     Perform networking code to attempt to register a user
    */
    static func registrationAttempt(username: String, password: String, completionHandler: @escaping (Bool, Any?, Error?) -> Void) {
        let SUCCESS_CODE: Int
        SUCCESS_CODE = 200
        DispatchQueue.main.async {
            let parameters: [String: String] = ["username": username, "password": password]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true, response, nil)
                } else {
                    print("Error")
                    completionHandler(false, response, nil)
                }
            }
        }
    }
    
}

