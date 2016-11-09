//
//  ReservationViewCell.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 10. 30..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class ReservationViewCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
