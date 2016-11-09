//
//  VerifViewController.swift
//  CafeGo
//
//  Created by 5407-35 on 2016. 10. 29..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class VerifViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBAction func pushButton(_ sender: AnyObject) {
        status.updatePhoneNumber(number: phoneNumber.text!)
        status.updateVerification(verif: true)
        print(status.getOrderList().phoneNumber)
        print(status.getOrderList().verification)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumber.delegate = self
        // Do any additional setup after loading the view.    
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
//    func textFieldShouldReturn(userText: UITextField!) -> Bool {
//        phoneNumber.resignFirstResponder()
//        return true;
//    }
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
