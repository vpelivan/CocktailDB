//
//  FilterTableViewCell.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 19.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    var isChecked: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
