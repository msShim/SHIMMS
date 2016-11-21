//
//  Gra2SelectedOrderTableViewCell.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 17..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class Gra2SelectedOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var beverageLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
