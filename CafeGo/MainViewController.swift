//
//  MainViewController.swift
//  CafeGo
//  Created by 5407-35 on 2016. 10. 30..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

var Mwait:String = "0"
var Gwait:String = "0"
var G3wait:String = "0"

class MainViewController: UIViewController {

    @IBOutlet weak var G3WaitingNumber: UILabel!
    @IBOutlet weak var GWaitingNumber: UILabel!
    @IBOutlet weak var MWaitingNumber: UILabel!
    @IBOutlet weak var promotionImage: UIImageView!
    
    var timer : Timer?
    var index:Int = 0
    var contentSize: CGFloat = 0
    var promotion:[String] = ["promotion1.png", "promotion2.jpg", "promotion3.jpeg", "promotion4.jpg"]
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promotionImage.frame.origin.y = 667
        promotionImage.contentMode = UIViewContentMode.scaleAspectFill
        self.setPromotion()
        ServerManager.setWaitingNumber()
        setWaitingNumber()
        
        scrollView.addSubview(promotionImage)
        
        scrollView.layoutSubviews()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setPromotion), userInfo: nil, repeats: true);
        timer?.fire()
        
        contentSize = promotionImage.frame.origin.y
        scrollView.contentSize.height = promotionImage.frame.size.height + promotionImage.frame.origin.y
        self.view.addSubview(scrollView)
        var a = scrollView.contentSize.height
        var b = promotionImage.frame.origin.y
        var c = promotionImage.frame.height
        var d = "되라"
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
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
    func setWaitingNumber(){
        self.MWaitingNumber.text = Mwait
        self.GWaitingNumber.text = Gwait
        self.G3WaitingNumber.text = G3wait
    }
    @objc fileprivate func setPromotion(){
//        // set current page number label
        self.promotionImage.image = UIImage(named: promotion[index])
        index += 1
        if(index == promotion.count){
            index = 0
        }
    }
}
