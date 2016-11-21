//
//  MCafeViewController.swift
//  Demo35-UIPageControl
//
//  Created by 남조선명지대학 on 2016. 10. 10..
//  Copyright © 2016년 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit

class MCafeViewController: UIViewController {
    
    
    @IBOutlet weak var coffeehandler: UIPageControl!
    @IBOutlet weak var coffeeimg: UIImageView!
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerManager.sendPhoneNum()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        // add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(MCafeViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(MCafeViewController.handleSwipeRight(_:)))
        
        // add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        
        // set current page number label.
        
        self.coffeehandler.numberOfPages = mCoffee1.count
        self.setCurrentPageLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {                 //이 viewDidAppear를 모든 보이는 화면에 넣어야함
        ServerManager.viewController = self                         //Mcafe, MJuice, MTeaView, MoreView는 넣음
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Utility functio
    // increase page number on swift left
    func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        print(mCoffee1.count)
        if(self.coffeehandler.currentPage == (mCoffee1.count - 1)){
            self.coffeehandler.currentPage = 0
            self.setCurrentPageLabel()
        } else {
            self.coffeehandler.currentPage += 1
            self.setCurrentPageLabel()
        }
    }
    
    
    // reduce page number on swift right
    func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if self.coffeehandler.currentPage != 0 {
            self.coffeehandler.currentPage -= 1
            self.setCurrentPageLabel()
        } else {
            self.coffeehandler.currentPage = mCoffee1.count - 1
            self.setCurrentPageLabel()
        }
    }
    
    // set current page number label
    fileprivate func setCurrentPageLabel(){
        
//        var productImg = mCoffee1[coffeehandler.currentPage].img
//        var escapedAddress = productImg?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
//        print(escapedAddress)
//        if let checkedUrl = URL(string: "http://192.168.40.3:3000/images/" + escapedAddress!) {
//            coffeeimg.contentMode = .scaleAspectFit
//            downloadImage(url: checkedUrl)
//        }
        ImageDownLoader.settingImg(string: mCoffee1[coffeehandler.currentPage].img!, imgView: coffeeimg)
        priceLabel.text = String(describing: mCoffee1[coffeehandler.currentPage].price!)
        nameLabel.text = String(describing: mCoffee1[coffeehandler.currentPage].name!)
    }
}
