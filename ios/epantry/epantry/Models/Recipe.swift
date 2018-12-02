//
//  Recipe.swift
//  epantry
//
//  Created by Owen Gibson on 11/18/18.
//  Copyright © 2018 Caleb. All rights reserved.
//
import UIKit
import Foundation

class Recipe {
    var name: String
    var photo: UIImage?
    var prepTime: Int
    var id: Int
    
    init?(name: String, photo: UIImage?, prepTime: Int, id: Int) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.prepTime = prepTime
        self.id = id
    }
}
