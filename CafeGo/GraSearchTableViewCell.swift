//
//  GraSearchTableViewCell.swift
//  CafeGo
//
//  Created by 남조선명지대학 on 2016. 11. 24..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class GraSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var menuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
