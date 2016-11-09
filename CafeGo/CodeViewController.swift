//
//  QrcodeViewController.swift
//  CafeGo
//
//  Created by 5407-35 on 2016. 10. 12..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBOutlet var Image: UIImageView!
    let status:StatusService = StatusService()
    override func viewDidLoad() {
        super.viewDidLoad()
        Image.image = generateQrcodeFromString(string: status.getOrderList().phoneNumber!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func deleteData(_ sender: AnyObject) {
        self.status.orderList.deleteStatus(id: self.status.getOrderList().objectID)
    }
    func generateBarcodeFromString(string : String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name:"CICode218BarcodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform.init(scaleX: Image.frame.width, y: Image.frame.height)
        let output = filter?.outputImage?.applying(transform)
        
        if output != nil {
            return UIImage(ciImage: output!)
        }
        return nil
    }
    
    func generateQrcodeFromString(string : String) -> UIImage {
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name:"CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform.init(scaleX: Image.frame.width, y: Image.frame.height)
        let output = filter?.outputImage?.applying(transform)
        
        if output != nil {
            return UIImage(ciImage: output!)
        }
        return UIImage(named: "coffee1")!
    }
}
