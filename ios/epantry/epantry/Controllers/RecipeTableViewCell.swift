//
//  RecipeTableViewCell.swift
//  epantry
//
//  Created by Owen Gibson on 11/14/18.
//  Copyright © 2018 Caleb. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var prepTime: UILabel!
    @IBOutlet weak var missingIngredients: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
