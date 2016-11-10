//
//  CoffeeSelectViewController.swift
//  Demo35-UIPageControl
//
//  Created by 남조선명지대학 on 2016. 10. 9..
//  Copyright © 2016년 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit

class CoffeeSelectViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func Back(_ sender: AnyObject) {
        appDelegate.switchStartViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
