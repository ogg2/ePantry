//
//  Defaults.swift
//  epantry
//
//  Created by Caleb Cain on 11/27/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation

extension UserDefaults {
    var userId: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
}
