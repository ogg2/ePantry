//
//  alerts.swift
//  epantry
//
//  Created by Caleb Cain on 11/14/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import Foundation
import UIKit

class Alerts {
    static func alertPopup(alertMessage: String) {
        let dialogMessage = UIAlertController(title: "Invalid Login", message: alertMessage, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
