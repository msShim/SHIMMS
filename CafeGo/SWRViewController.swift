//
//  SWRViewController.swift
//  CafeGo
//
//  Created by 5407-35 on 2016. 10. 31..
//  Copyright © 2016년 SMS. All rights reserved.
//

import Foundation

class SWRViewController: SWRevealViewController, SWRevealViewControllerDelegate {

    var coverView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.tapGestureRecognizer()
        self.panGestureRecognizer()
        
        
        coverView = UIView(frame: UIScreen.main.bounds)
        coverView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Do any additional setup after loading the view.
    }

    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition){
        if position == FrontViewPosition.right {
            self.frontViewController.view.isUserInteractionEnabled = false
            self.frontViewController.view.addSubview(coverView!)
        }else{
            self.frontViewController.view.isUserInteractionEnabled = true
            coverView!.removeFromSuperview()
        }
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
