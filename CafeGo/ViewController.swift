//  testViewController.swift
//  CafeGo
//
//  Created by 남조선명지대학 on 2016. 10. 4..
//  Copyright © 2016년 SMS. All rights reserved.

import UIKit
import SocketIO

public let tree = RBTree<Int>()
let status:StatusService = StatusService()

open class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var img: UIImageView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if(status.getOrderList().verification == true){
            appDelegate.switchStartViewControllers()
        } else{
            appDelegate.switchPreViewControllers()
        }
    }
}
