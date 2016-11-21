//
//  ServerConnector.swift
//  CafeGo
//
//  Created by Kimminchan on 2016. 10. 21..
//  Copyright © 2016년 SMS. All rights reserved.
//

import Foundation
import SocketIO
import AudioToolbox

<<<<<<< HEAD
let serverURL:String = "http://192.168.41.8:8000/"
=======
let serverURL:String = "http://192.168.44.179:8000/"
>>>>>>> 80119f7132054c7482e1157b24da5ba2e5ab7577

class ServerConnector {
//    var counter = 0
//    var timer : Timer = Timer()
    var idx: String?
    var socket = SocketIOClient(socketURL: URL(string: serverURL)!)
    var products:NSMutableArray?
    var mainView:MainViewController?
    var viewController:UIViewController?
    func addHandlers()
    {
        var menu:Int = 0;
        
        socket.on("connectSuccess") {data, ack in
            print("!!!!!!!connectSuccess!!!!!!")
            print(data)
//            print(data[0] as! NSMutableArray)
            self.products = data[0] as? NSMutableArray
//            if(status.getOrderList().verification == true){
//                self.socket.emit("sendPhoneNum", status.getOrderList().phoneNumber!)
//            }
            for product in self.products! {
                var item = Coffee()
                print(product as! NSDictionary)
                let temp = product as! NSDictionary
//                print("이 제품의 이름은 \(temp.value(forKey: "name")) 입니다.")      //temp에 키를 검색해서 접근함
                item.id = Int(temp.value(forKey: "productID") as! String)
                item.name = (temp.value(forKey: "name") as! String?)!
                item.category = (temp.value(forKey: "category") as! Int?)!
                item.img = (temp.value(forKey: "img") as! String?)!
                item.price = (temp.value(forKey: "price") as! Int?)!
                tree.insert(item)
            }
            tree.categoryMenu(tree.root)
//            self.idx = data as? String;
        }
        
        socket.on("orderSuccess"){data, ack in
            print("!!!!!!!orderSuccess!!!!!!")
            print(data[0])
            let index:Int64 = (data[0] as AnyObject).int64Value
            status.updatemCafeNumber(order: index)
            //넣어
        }
        
        socket.on("successCall"){data, ack in
//            print("!!!!!!!successCall!!!!!!")
//            print("진동아 와라!")
//            self.counter = 0
//            self.timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: Selector("vibratePhone"), userInfo: nil, repeats: true)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            let alert = UIAlertController(title: "예약하신 상품이 준비되었습니다.", message: "어서오세요", preferredStyle: UIAlertControllerStyle.alert)
            var orderMenuString: String = ""
            var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                UIAlertAction in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchViewControllers()
            }
            self.viewController?.present(alert, animated: true, completion: nil)
            alert.addAction(okAction)

        }
        
        
    }
    
//    func vibratePhone() {
//        self.counter += 1
//        print("!!")
//        switch self.counter {
//        case 1, 2:
//            print("!!!")
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//        default:
//            self.timer.invalidate()
//        }
//    }

    
    func connect(){
        self.addHandlers()
        self.socket.connect()
    }
    
    func disconnect(){
        print("disconnect 간다아아아!!")
        self.socket.disconnect()
    }
    
//    struct Order {
//        var phoneNum:String
//        var time:String
//        var productName:String
//        var productCnt:String
//    }
    
    func sendPhoneNum(){
        print("폰번호전송")
        self.socket.emit("sendPhoneNum", status.getOrderList().phoneNumber!)
    }
    
    func sendScore(star:String, text:String){
        print("리뷰전송")
        var score:String
        switch star {
            case "★★★★★":
                score = "5";
                break
            case "★★★★☆":
                score = "4";
                break
            case "★★★☆☆":
                score = "3";
                break
            case "★★☆☆☆":
                score = "2";
                break
            case "★☆☆☆☆":
                score = "1";
                break
            default:
                score = "0";
        }
        var data:[String] = []
        data.append(status.getOrderList().phoneNumber!)
        data.append(text)
        data.append(score)
        self.socket.emit("sendScore", data)
    }
    
    func sendOrder(phoneNum:String, time:String, productName:String, productCnt:String, total:Int64) {
        
//        var data = Order(phoneNum: phoneNum, time: time, productName: productName, productCnt: productCnt)
        var data:[String] = []
        data.append(phoneNum)
        data.append(time)
        data.append(productName)
        data.append(productCnt)
        data.append(String(total))
    
        self.socket.emit("sendOrder", data)
    }

}

class ProductAdapter: AnyObject {
    var productID: NSNumber = NSNumber()
    var cafeID: NSNumber = NSNumber()
    var category: NSNumber = NSNumber()
    var productNum: NSNumber = NSNumber()
    var name: String = String()
    var price: NSNumber = NSNumber()
}

var ServerManager = ServerConnector()
