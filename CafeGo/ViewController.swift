//  testViewController.swift
//  CafeGo
//
//  Created by 남조선명지대학 on 2016. 10. 4..
//  Copyright © 2016년 SMS. All rights reserved.

import UIKit
import SocketIO

public let tree = RBTree<Int>()
let status:StatusService = StatusService()

open class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    // outlet - page control
    @IBOutlet var myPageControl: UIPageControl!
    
    // current page number label
    @IBOutlet var currentPageLabel: UILabel!

    
    @IBOutlet weak var test: UILabel!
    open var cafemenu:[Coffee] = []
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
//      test.text = "TestLabel"
        
        // set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        // add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(ViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(ViewController.handleSwipeRight(_:)))
        
        // add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        
        // set current page number label.
        self.setCurrentPageLabel()
        
        // Do any additional setup after loading the view.
    }
    
    func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        if self.myPageControl.currentPage < 4 {
            if(self.myPageControl.currentPage == 3){
                self.myPageControl.currentPage = 0
                self.setCurrentPageLabel()
                return
            }
            
            self.myPageControl.currentPage += 1
            self.setCurrentPageLabel()
        }
    }
    
    // reduce page number on swift right
    func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        
        if self.myPageControl.currentPage != 0 {
            self.myPageControl.currentPage -= 1
            self.setCurrentPageLabel()
        } else {
            self.myPageControl.currentPage = 3
            self.setCurrentPageLabel()
        }
    }
    
    // set current page number label
    fileprivate func setCurrentPageLabel(){
        
        // set current page number label
        
        
        switch myPageControl.currentPage {
        
        case 0:
            self.img.image = UIImage(named: "coffee4.jpeg")
        case 1:
            self.img.image = UIImage(named: "coffee5.jpeg")
        case 2:
            self.img.image = UIImage(named: "coffee6.jpeg")
        case 3:
            self.img.image = UIImage(named: "tea.jpeg")
        default:
            print("out of range!!!!")
        }
        
    }
    
    func loadData(){
        for i in 0..<cafemenu.count {
            print(cafemenu[i].id, "/", cafemenu[i].name, "-->")
        }
        //id
        if(tree.findId(10000).value?.id == 10000){
            print(tree.findId(10000).value?.name, tree.findId(10000).value?.id, "Founded")
        }
        /*
         for _ in 0..<10 {
         let rand = arc4random_uniform(UInt32(values.count))
         let index = Int(rand)
         let value = values.remove(at: index)
         tree.delete(value)
         }
         tree.verify()
         }
         */
    }
    public func getMenu() -> [Coffee]{
        return cafemenu
    }
    func makeCell(_ value:Coffee){
        cafemenu.append(value)
    }
}
