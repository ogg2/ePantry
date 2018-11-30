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
    static func getPantryItems(completionHandler: @escaping ([String]) -> Void) {
        DispatchQueue.main.async {
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/pantry/" + getUserId(), method: .get, encoding: JSONEncoding.default).responseJSON{ response in
                switch response.result {
                case .success:
                    var pantryItems: [String] = []
                    print("Pantry List Clicked")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        pantryItems = getItemNameArray(JSON, type: "pantry")
                    }
                    completionHandler(pantryItems)
                case .failure:
                    print("Failure")
                    completionHandler([])
                }
            }
        }
    }
    
    static func getItemNameArray(_ pantry:NSDictionary, type:String) -> [String] {
        
        let pantryArray = pantry[type]! as! NSArray
        var pantryItems: [String] = []
        
        for i in 0...pantryArray.count - 1 {
            let pantryIndex = pantryArray[i] as! NSDictionary
            let itemName = pantryIndex["itemName"] as! String
            
            pantryItems.append(itemName)
        }
        
        return pantryItems
    }
    
    /*
     Perform networking code to access grocery list items for specific user
    */
    static func getGroceryListItems(completionHandler: @escaping ([String]) -> Void) {
        DispatchQueue.main.async {
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/groceryList/" + getUserId(), method: .get, encoding: JSONEncoding.default).responseJSON{ response in
                switch response.result {
                case .success:
                    var groceryItems: [String] = []
                    print("Pantry List Clicked")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        groceryItems = getItemNameArray(JSON, type: "groceryList")
                    }
                    completionHandler(groceryItems)
                case .failure:
                    print("Failure")
                    completionHandler([])
                }
            }
        }
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
                        setUserId(userId: JSON["userid"]! as! String)
                        print(getUserId())
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
    
    /*
     Searching for a variety of recipes given input search conditions
    */
    static func searchRecipes (query: String, cuisine: String, completionHandler: @escaping ([Int], [String], [Int], [UIImage], Error?) -> Void) {
        DispatchQueue.main.async {
            let MY_API_KEY = "buXuEHzSQhmshfqC8qohBjM7jeJ8p1HIjrtjsnoI3nlENPgxKA"
            let headers: HTTPHeaders = ["X-Mashape-Key": MY_API_KEY, "Accept": "application/json"]
            //let parameters: [String: String] = ["query": query, "cuisine": cuisine]
            Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?cuisine=\(cuisine)&number=10&offset=0&query=\(query)", headers: headers).responseJSON{response in
                //loop 1 - 10
                //var id[i] = response[0].id
                print(response)
            }
        }
    }
    
    /*
     Getting inforation for 1 specific recipe
    */
    static func getRecipe (id: String, completionHandler: @escaping (Bool, Any?, Error?) -> Void) {
        DispatchQueue.main.async {
            /*Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/479101/information")
                .header("X-RapidAPI-Key", "buXuEHzSQhmshfqC8qohBjM7jeJ8p1HIjrtjsnoI3nlENPgxKA")
                .end(function (result) {
                    console.log(result.status, result.headers, result.body);
                });)*/
        }
    }
    
    static func getUserId() -> String {
        return UserDefaults.standard.value(forKey: "userId") as! String
    }
    
    static func setUserId(userId: String) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
}
