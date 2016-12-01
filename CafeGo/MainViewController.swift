//
//  MainViewController.swift
//  CafeGo
//  Created by 5407-35 on 2016. 10. 30..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var G3WaitingNumber: UILabel!
    @IBOutlet weak var GWaitingNumber: UILabel!
    @IBOutlet weak var MWaitingNumber: UILabel!
    @IBOutlet weak var promotionImage: UIImageView!
    
    var timer : Timer?
    var index:Int = 0
    var img:[String]?
    var contentSize: CGFloat = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPromotion()
        ServerManager.setWaitingNumber(Mainview: self)
        promotionImage.contentMode = UIViewContentMode.scaleAspectFit
        
        promotionImage.frame.origin.y = 660
        
        scrollView.addSubview(promotionImage)
        
        scrollView.layoutSubviews()
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setPromotion), userInfo: nil, repeats: true);
        timer.fire()
        
        contentSize = promotionImage.frame.origin.y
        scrollView.contentSize.height = promotionImage.frame.size.height + promotionImage.frame.origin.y
        self.view.addSubview(scrollView)
        var a = scrollView.contentSize.height
        var b = promotionImage.frame.origin.y
        var c = promotionImage.frame.height
        var d = "되라"
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    @IBAction func ClickMCafe(_ sender: AnyObject) {
        status.updateCafeName(order: "명지카페")
    }
    @IBAction func ClickGrazie1(_ sender: AnyObject) {
        status.updateCafeName(order: "그라지에1")
    }
    @IBAction func ClcikGrazie2(_ sender: AnyObject) {
        status.updateCafeName(order: "그라지에2")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        timer?.invalidate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setWaitingNumber(mnumber : String, gnumber : String, g1number : String){
        self.MWaitingNumber.text = mnumber
        self.GWaitingNumber.text = gnumber
        self.G3WaitingNumber.text = g1number
    }
    @objc fileprivate func setPromotion(){
//        // set current page number label
        switch index{
        case 0:
            self.promotionImage.image = UIImage(named: "promotion.jpeg")
            index += 1
        case 1:
            self.promotionImage.image = UIImage(named: "promotion2.jpeg")
            index += 1
        case 2:
            self.promotionImage.image = UIImage(named: "promotion3.jpeg")
            index = 0
        default:
            print("out of range!!!!")
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

}
