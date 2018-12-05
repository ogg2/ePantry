//
//  MyRecipe.swift
//  epantry
//
//  Created by Owen Gibson on 12/1/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class MyRecipe {
    var name: String
    var prepTime: Int
    var ingredients: [String]
    var ingredientsName: [String]
    var instructions: [String]
    
    init?(name: String, prepTime: Int, ingredients: [String], ingredientsName: [String], instructions: [String]) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
        self.prepTime = prepTime
        self.ingredients = ingredients
        self.ingredientsName = ingredientsName
        self.instructions = instructions
    }
}
