//
//  MJuiceViewController.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 10. 28..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class MJuiceViewController: UIViewController {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var juicehandler: UIPageControl!
    @IBOutlet weak var juiceimg: UIImageView!
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        // add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(MJuiceViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(MJuiceViewController.handleSwipeRight(_:)))
        
        // add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        
        // set current page number label.
        self.juicehandler.numberOfPages = mCoffee2.count
        self.setCurrentPageLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ServerManager.viewController = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Utility functio
    // increase page number on swift left
    func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        print(mCoffee1.count)
        if(self.juicehandler.currentPage == (mCoffee2.count - 1)){
            self.juicehandler.currentPage = 0
            self.setCurrentPageLabel()
        } else {
            self.juicehandler.currentPage += 1
            self.setCurrentPageLabel()
        }
    }
    
    
    // reduce page number on swift right
    func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if self.juicehandler.currentPage != 0 {
            self.juicehandler.currentPage -= 1
            self.setCurrentPageLabel()
        } else {
            self.juicehandler.currentPage = mCoffee2.count - 1
            self.setCurrentPageLabel()
        }
    }
    
    // set current page number label
    fileprivate func setCurrentPageLabel(){
        
        // set current page number label
        
        // set current page number label
//        juiceimg.image = UIImage(named: "cafelatte.png")
        ImageDownLoader.settingImg(string: mCoffee2[juicehandler.currentPage].img!, imgView: juiceimg)
        priceLabel.text = String(describing: mCoffee2[juicehandler.currentPage].price!)
        menuLabel.text = String(describing: mCoffee2[juicehandler.currentPage].name!)
        
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
