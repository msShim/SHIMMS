//
//  GraCouponView.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 26..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class GraCouponView: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var myImages : [String] = []
    let imageWidth:CGFloat = 100
    let imageHeight:CGFloat = 100
    var yPosition:CGFloat = 100
    var xPosition:CGFloat = 30
    var scrollViewContentSize:CGFloat = 0
    var couponCount = 15
    @IBOutlet weak var scrollVIew: UIScrollView!
    @IBAction func back(_ sender: AnyObject) {
        appDelegate.switchStartViewControllers()

    }
    override func viewDidLoad() {
        
        for _ in 0..<couponCount {
            myImages.append("stamp.png")
        }
        
        super.viewDidLoad()
        for i in 0 ..< myImages.count{
            let myImage:UIImage = UIImage(named: myImages[i])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.contentMode = UIViewContentMode.scaleAspectFit
            
            myImageView.frame.size.width = imageWidth
            myImageView.frame.size.height = imageHeight
            myImageView.frame.origin.x = xPosition
            myImageView.frame.origin.y = yPosition
            scrollVIew.addSubview(myImageView)
            
            let spacer:CGFloat = 10
            
            
            xPosition+=imageWidth + spacer
            if(xPosition > 265){
                yPosition+=imageHeight + spacer
                xPosition = 30
            }
            
            scrollVIew.contentSize.height = scrollViewContentSize
            scrollVIew.contentSize.width = imageWidth
        }
    }
    
    public func makeCoupon(count: Int ){
        couponCount = count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func addCoupon(){
        myImages.append("stamp.png")
        let i = couponCount + 1
        couponCount = i
    }
    
    public func deleteCoupon(){ // 쿠폰 취소
        myImages.removeLast()
        let i = couponCount - 1
        couponCount = i
    }
    public func UseCoupon(){// 10장 사용
        if(myImages.count > 9){
            for _ in 0 ..< 10 {
                myImages.removeLast()
            }
            let i = couponCount - 10
            couponCount = i
        }
    }}
