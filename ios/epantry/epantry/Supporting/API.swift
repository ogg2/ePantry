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
        
        if (pantryArray.count > 0) {
        
            for i in 0...pantryArray.count - 1 {
                let pantryIndex = pantryArray[i] as! NSDictionary
                let itemName = pantryIndex["itemName"] as! String
            
                pantryItems.append(itemName)
            }
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
    
    static func removeItemFromPantry(item: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            var items: [String] = []
            items.append(item)
            let SUCCESS_CODE = 200
            let parameters: [String: [String]] = ["items": items]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/removeFromPantry/" + getUserId(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }
        }
    }
    
    static func removeItemFromGroceryList(item: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            var items: [String] = []
            items.append(item)
            let SUCCESS_CODE = 200
            let parameters: [String: [String]] = ["items": items]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/removeFromGroceryList/" + getUserId(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }
        }
    }
    
    static func addItemToPantry(item: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            var items: [String] = []
            items.append(item)
            let SUCCESS_CODE = 200
            let parameters: [String: [String]] = ["items": items]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/addToPantry/" + getUserId(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }
        }
    }
    
    static func addItemToGrocery(item: String, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            var items: [String] = []
            items.append(item)
            let SUCCESS_CODE = 200
            let parameters: [String: [String]] = ["items": items]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/addToGroceryList/" + getUserId(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }
        }
    }
    
    static func moveItemsToPantry(items: [String], completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let SUCCESS_CODE = 200
            let parameters: [String: [String]] = ["items": items]
            Alamofire.request("https://secret-thicket-47430.herokuapp.com/moveItemsToPantry/" + getUserId(), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var statusCode: Int
                statusCode = response.response!.statusCode
                if (statusCode == SUCCESS_CODE) {
                    print("Validation Successful")
                    completionHandler(true)
                } else {
                    print("Error")
                    completionHandler(false)
                }
            }
        }
    }
    
    /*
     Searching for a variety of recipes given input search conditions
    */
    static func searchRecipes (query: String, cuisine: String, completionHandler: @escaping ([Int], [String], [Int], Error?) -> Void) {
        DispatchQueue.main.async {
            let MY_API_KEY = "buXuEHzSQhmshfqC8qohBjM7jeJ8p1HIjrtjsnoI3nlENPgxKA"
            let headers: HTTPHeaders = ["X-Mashape-Key": MY_API_KEY, "Accept": "application/json"]
            //https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex?query=burger&cuisine=american&limitLicense=true&offset=0&number=10
            //"https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?cuisine=\(cuisine)&number=10&offset=0&query=\(query)"
            Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex?query=\(query)&cuisine=\(cuisine)&limitLicense=true&offset=0&number=10", headers: headers).responseJSON{response in
                switch response.result {
                case .success:
                    var ids: [Int] = []
                    var names: [String] = []
                    var prepTimes: [Int] = []
                    
                    if let result = response.result.value {
                        print (result)
                        let JSON = result as! NSDictionary
                        let json = JSON["results"] as! NSArray
                        if json.count != 0 {
                            names = getRecipeNames(JSON, type: "results")
                            ids = getIds(JSON, type: "results")
                        } /*else {
                            ids = [0]
                            names = [""]
                            prepTimes = [0]
                            images = [""]
                        }*/
                    }
                    
                
                    completionHandler(ids, names, [45, 45, 45, 45, 45, 45, 45, 45, 45, 45], nil)
                    
                case .failure:
                    print (response)
                    print("Failure")
                    completionHandler([0], [""], [0], nil)
                }
            }
        }
    }
    
    /*
     Getting inforation for 1 specific recipe
    */
    static func getRecipeInfo (id: Int, completionHandler: @escaping (String, Int, [String], [String], [String], Error?) -> Void) {
        DispatchQueue.main.async {
            let MY_API_KEY = "buXuEHzSQhmshfqC8qohBjM7jeJ8p1HIjrtjsnoI3nlENPgxKA"
            let headers: HTTPHeaders = ["X-Mashape-Key": MY_API_KEY, "Accept": "application/json"]
            Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/information", headers: headers).responseJSON{response in
                switch response.result {
                case .success:
                    var name: String
                    var prepTime: Int
                    var ingredients: [String] = []
                    var ingredientsName: [String] = []
                    var instructions: [String] = []
                    
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        
                        name = JSON["title"] as! String
                        prepTime = JSON["readyInMinutes"] as! Int
                        ingredients = getIngredients(JSON, type: "extendedIngredients")
                        ingredientsName = getIngredientsName(JSON, type: "extendedIngredients")
                        instructions = getInstructions(JSON, type: "analyzedInstructions")
                        
                        completionHandler(name, prepTime, ingredients, ingredientsName, instructions, nil)
                    }
                    
                    
                case .failure:
                    print("Failure")
                    completionHandler("", 0, [""], [""], [""], nil)
                }
            }
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
    
    /*
     * Returns the list of ingredients from the API call
     */
    static func getIngredients(_ ingredients:NSDictionary, type:String) -> [String] {
        let ingredientsArray = ingredients[type]! as! NSArray
        var ingredientsItems: [String] = []
        
        for i in 0...ingredientsArray.count - 1 {
            let ingredientsIndex = ingredientsArray[i] as! NSDictionary
            let ingredientsName = ingredientsIndex["original"] as! String
            ingredientsItems.append(ingredientsName)
        }
        return ingredientsItems
    }
    
    /*
     * Returns the list of ingredients (name) from the API call
     */
    static func getIngredientsName(_ ingredients:NSDictionary, type:String) -> [String] {
        let ingredientsArray = ingredients[type]! as! NSArray
        var ingredientsItems: [String] = []
        
        for i in 0...ingredientsArray.count - 1 {
            let ingredientsIndex = ingredientsArray[i] as! NSDictionary
            let ingredientsName = ingredientsIndex["name"] as! String
            ingredientsItems.append(ingredientsName)
        }
        return ingredientsItems
    }
    
    /*
     * Returns the instruction steps from the API call
     */
    static func getInstructions(_ instructions:NSDictionary, type:String) -> [String] {
        var instructionsItems: [String] = []
        
        if let analyzedArray = instructions[type] as? NSArray {
            if analyzedArray.count == 0 {
                return ["Sorry, this recipe has no instructions."]
            }
            if let analyzedDictionary = analyzedArray[0] as? NSDictionary {
                let stepsArray = analyzedDictionary["steps"]! as! NSArray
                for i in 0...stepsArray.count - 1 {
                    let instructionsIndex = stepsArray[i] as! NSDictionary
                    let instructionsName = instructionsIndex["step"] as! String
                    instructionsItems.append(instructionsName)
                }
            }
        }
        return instructionsItems
    }
}
