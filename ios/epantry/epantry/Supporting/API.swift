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
                    print(response)
                    var pantryItems: [String] = []
                    print("Pantry List Clicked")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        pantryItems = getStringArray(JSON, type: "pantry")
                    }
                    completionHandler(pantryItems)
                case .failure:
                    print("Failure")
                    completionHandler([])
                }
            }
        }
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
                    print("Grocery List Clicked")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        groceryItems = getStringArray(JSON, type: "groceryList")
                    }
                    completionHandler(groceryItems)
                case .failure:
                    print("Failure")
                    completionHandler([])
                }
            }
        }
    }
    
    static func getStringArray(_ pantry:NSDictionary, type:String) -> [String] {
        
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
    static func searchRecipes (query: String, cuisine: String, completionHandler: @escaping ([Int], [String], [Int], [String], Error?) -> Void) {
        DispatchQueue.main.async {
            let MY_API_KEY = "buXuEHzSQhmshfqC8qohBjM7jeJ8p1HIjrtjsnoI3nlENPgxKA"
            let headers: HTTPHeaders = ["X-Mashape-Key": MY_API_KEY, "Accept": "application/json"]
            //let parameters: [String: String] = ["query": query, "cuisine": cuisine]
            Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?cuisine=\(cuisine)&number=10&offset=0&query=\(query)", headers: headers).responseJSON{response in
                switch response.result {
                case .success:
                    var ids: [Int] = []
                    var names: [String] = []
                    var prepTimes: [Int] = []
                    //var images: [String] = []
                    
                    print("API Population...")
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        names = getRecipeNames(JSON, type: "results")
                        ids = getIds(JSON, type: "results")
                        prepTimes = getPrepTimes(JSON, type: "results")
                    }
                    
                    /*print("First recipe: \(names[0])")
                    print("First recipe: \(ids[0])")
                    print("First recipe: \(prepTimes[0])")*/
                    
                    completionHandler(ids, names, prepTimes, ["avocado.png"], nil)
                    
                case .failure:
                    print("Failure")
                    completionHandler([0], [""], [0], [""], nil)
                }
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
    
    /*
     * Returns the recipe names from the API call
     */
    static func getRecipeNames(_ recipe:NSDictionary, type:String) -> [String] {
        let recipeArray = recipe[type]! as! NSArray
        var recipeItems: [String] = []
        
        for i in 0...recipeArray.count - 1 {
            let recipeIndex = recipeArray[i] as! NSDictionary
            let itemName = recipeIndex["title"] as! String
            recipeItems.append(itemName)
        }
        return recipeItems
    }
    
    /*
     * Returns the ids from the API call
     */
    static func getIds(_ id:NSDictionary, type:String) -> [Int] {
        let idArray = id[type]! as! NSArray
        var idItems: [Int] = []
        
        for i in 0...idArray.count - 1 {
            let idIndex = idArray[i] as! NSDictionary
            let idName = idIndex["id"] as! Int
            idItems.append(idName)
        }
        return idItems
    }
    
    /*
     * Returns the prep times from the API call
     */
    static func getPrepTimes(_ prepTime:NSDictionary, type:String) -> [Int] {
        let prepTimeArray = prepTime[type]! as! NSArray
        var prepTimeItems: [Int] = []
        
        for i in 0...prepTimeArray.count - 1 {
            let prepTimeIndex = prepTimeArray[i] as! NSDictionary
            let prepTimeName = prepTimeIndex["readyInMinutes"] as! Int
            prepTimeItems.append(prepTimeName)
        }
        return prepTimeItems
    }
}
