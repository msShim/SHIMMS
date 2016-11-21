//
//  Gra2TableViewCell.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 17..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class Gra2TableViewCell: UITableViewCell {
    
    @IBOutlet weak var starlabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
