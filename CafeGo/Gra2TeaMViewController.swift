//
//  Gra2TeaMViewController.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 17..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class Gra2TeaMViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func BACK(_ sender: AnyObject) {
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
