//
//  SelectedOrderTableViewCell.swift
//  Demo35-UIPageControl
//
//  Created by 남조선명지대학 on 2016. 10. 10..
//  Copyright © 2016년 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit

class SelectedOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
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
