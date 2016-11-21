//
//  GraTableViewCell.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 16..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class GraTableViewCell: UITableViewCell{
    
    @IBOutlet weak var starlabel: UILabel!
    @IBOutlet weak var textlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
