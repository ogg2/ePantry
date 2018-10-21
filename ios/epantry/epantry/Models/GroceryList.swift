//
//  List.swift
//  epantry
//
//  Created by Caleb Cain on 10/21/18.
//  Copyright © 2018 Caleb. All rights reserved.
//
import Alamofire
import Foundation

public struct GroceryItem {
    
    public enum Category {
        case produce
        case nonProduce
    }
    
    let price: Double
    let name: String
    let category: Category
    
}

typealias GroceryList = [GroceryItem]

extension Collection where Element == GroceryItem {
    
    public func total() -> Double {
        return reduce(0, { total, item in
            return total + item.price
        })
    }
    
}

struct User: Codable {
    
    let id: Int
    let name: String
    
}

let jsonEncoder = JSONEncoder()
let user = User(id: 0, name: "Jack")
let data = try! jsonEncoder.encode(user)


