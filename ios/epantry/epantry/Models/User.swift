//
//  User.swift
//  epantry
//
//  Created by Caleb Cain on 11/27/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation

struct Defaults {
    static var userId: String? {
        set {
            UserDefaults.setValue(newValue, forKey: #function)
        }
        
        get {
            return UserDefaults.standard.string(forKey: #function)
        }
    }
}

struct LoginResponse {
    let userId: String
}
