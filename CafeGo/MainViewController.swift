//
//  MainViewController.swift
//  CafeGo
//  Created by 5407-35 on 2016. 10. 30..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var promotionImage: UIImageView!
    var timer : Timer?
    var index:Int = 0
    var img:[String]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPromotion()
        var timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.setPromotion), userInfo: nil, repeats: true);
        timer.fire()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        timer?.invalidate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc fileprivate func setPromotion(){
//        // set current page number label
        switch index{
        case 0:
            self.promotionImage.image = UIImage(named: "promotion.jpeg")
        case 1:
            self.promotionImage.image = UIImage(named: "promotion2.jpeg")
        case 2:
            self.promotionImage.image = UIImage(named: "promotion3.jpeg")
            index = 0
        default:
            print("out of range!!!!")
        }
        index += 1
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
