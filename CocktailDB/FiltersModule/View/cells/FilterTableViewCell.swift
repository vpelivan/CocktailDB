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
    
//    var isChecked: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterLabel.isHidden = false
//        setupCheckmark()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
//    private func setupCheckmark() {
//        if isChecked == false {
//            filterLabel.isHidden = true
//        }
//    }
    
}
