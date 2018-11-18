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
    
    init?(name: String, photo: UIImage?) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
        self.photo = photo
    }
}
