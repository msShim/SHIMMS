//
//  JuiceMViewController.swift
//  CafeGo
//
//  Created by 5407-35 on 2016. 11. 10..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class JuiceMViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func Back(_ sender: AnyObject) {
        appDelegate.switchStartViewControllers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
