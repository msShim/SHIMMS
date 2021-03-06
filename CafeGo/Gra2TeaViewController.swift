//
//  Gra2TeaViewController.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 17..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class Gra2TeaViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var teahandler: UIPageControl!
    @IBOutlet weak var teaimg: UIImageView!
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        //add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(MTeaViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(MTeaViewController.handleSwipeRight(_:)))
        
        //add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        
        // set current page number label.
        //        self.teaimg.settr
        self.teahandler.numberOfPages = gCoffee3.count
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
        print(gCoffee1.count)
        if(self.teahandler.currentPage == (gCoffee3.count - 1)){
            self.teahandler.currentPage = 0
            self.setCurrentPageLabel()
        } else {
            self.teahandler.currentPage += 1
            self.setCurrentPageLabel()
        }
    }
    
    
    // reduce page number on swift right
    func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if self.teahandler.currentPage != 0 {
            self.teahandler.currentPage -= 1
            self.setCurrentPageLabel()
        } else {
            self.teahandler.currentPage = gCoffee3.count - 1
            self.setCurrentPageLabel()
        }
    }
    
    // set current page number label
    fileprivate func setCurrentPageLabel(){
        
        // set current page number label
        // set current page number label
        //        teaimg.image = UIImage(named: "cafelatte.png")
        ImageDownLoader.settingImg(string: gCoffee3[teahandler.currentPage].img!, imgView: teaimg)
        priceLabel.text = String(describing: gCoffee3[teahandler.currentPage].price!)
        menuLabel.text = String(describing: gCoffee3[teahandler.currentPage].name!)
        
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
