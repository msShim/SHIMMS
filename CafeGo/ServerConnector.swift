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

let serverURL:String = "http://192.168.41.25:8000/"

class ServerConnector {
    //    var counter = 0
    //    var timer : Timer = Timer()
    var idx: String?
    var socket = SocketIOClient(socketURL: URL(string: serverURL)!)
    var products:NSMutableArray?
    var mainView:MainViewController?
    var reserveView:ReservationViewController?
    var viewController:UIViewController?
    func addHandlers()
    {
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
        
        socket.on("waitingStatus") {data, ack in
            print("!!!!!!!waitingStatus!!!!!!")
            
            Mwait = (data[0] as AnyObject).int64Value
            Gwait = (data[1] as AnyObject).int64Value
            G3wait = (data[2] as AnyObject).int64Value
            
            print("명지카페 : \(data[0])")  //명지카페 대기순
            print("그라지에 : \(data[1])")  //그라지에 대기순
            print("그라지에3 : \(data[2])")  //그라지에3 대기순
            //            item.category = (waitingStatus(forKey: "category") as! Int?)!
            self.mainView?.setWaitingNumber()
            self.mainView?.reloadInputViews()
        }
        
        socket.on("soldOut") {data, ack in
            print("!!!!!!!soldOut!!!!!!")
            print("판매완료")
            print("해당 주문 소속위치 : \(data[0])")
            let cafeNum = (data[0] as AnyObject).int64Value
            if(cafeNum == 1){
                let number = Int(status.getOrderList().mCoupon!)! + 1
                status.updateMCupon(order: String(number))
            }
            if(cafeNum == 3){
                let number = Int(status.getOrderList().mCoupon!)! + 1
                status.updateMCupon(order: String(number))
            }
            if(cafeNum == 2){
                let number = Int(status.getOrderList().mCoupon!)! + 1
                status.updateMCupon(order: String(number))
            }
            
            for _ in 0..<status.orderList.getAll().count{
                status.updateTime(order: "")
                status.initOrder(order: "")
                status.initQuantity(order: "")
                status.updateOrderNumber(order: 0)
                status.updateOrderBook(book: false)
                status.updatemCafeNumber(order: 0)
            }
            
            let alert = UIAlertController(title: "맛있게 드세요.", message: "감사합니다.", preferredStyle: UIAlertControllerStyle.alert)
            var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                UIAlertAction in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchStartViewControllers()
            }
            self.viewController?.present(alert, animated: true, completion: nil)
            alert.addAction(okAction)
        }
        
        socket.on("cancel") {data, ack in
            print("!!!!!!!cancel!!!!!!")
            print("주문 취소당함")
            status.updateTime(order: "")
            status.initOrder(order: "")
            status.initQuantity(order: "")
            status.updateOrderNumber(order: 0)
            status.updateOrderBook(book: false)
            status.updatemCafeNumber(order: 0)
            
            let alert = UIAlertController(title: "주문 취소.", message: "문의 해보시기 바랍니다.", preferredStyle: UIAlertControllerStyle.alert)
            var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                UIAlertAction in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchStartViewControllers()
            }
            self.viewController?.present(alert, animated: true, completion: nil)
            alert.addAction(okAction)
        }
        
        socket.on("receiveScore"){data, ack in
            print("!!!!!!!receiveScore!!!!!!")
            let scores = data[0] as? NSMutableArray
            var reple = Reple()
            for score in scores! {
                var star:String?
                
                let temp = score as! NSDictionary
                if(temp.value(forKey: "score") as? Int64 == 1){
                    star = "★☆☆☆☆"
                } else if(temp.value(forKey: "score") as? Int64 == 2){
                    star = "★★☆☆☆"
                } else if(temp.value(forKey: "score") as? Int64 == 3){
                    star = "★★★☆☆"
                } else if(temp.value(forKey: "score") as? Int64 == 4){
                    star = "★★★★☆"
                } else {
                    star = "★★★★★"
                }
                if(temp.value(forKey: "cafeID") as! Int == 1){
                    reple.Body = (temp.value(forKey: "text") as? String)!
                    reple.CreatAt = (temp.value(forKey: "createAt") as? String)!

                    reple.Score = star
                    print(reple.Body)
                    MReple.append(reple)
                } else if (temp.value(forKey: "cafeID") as! Int == 2){
                    reple.Body = (temp.value(forKey: "text") as? String)!
                    reple.CreatAt = (temp.value(forKey: "createAt") as? String)!
                    reple.Score = star
                    GReple.append(reple)
                } else {
                    reple.Body = (temp.value(forKey: "text") as? String)!
                    reple.CreatAt = (temp.value(forKey: "createAt") as? String)!
                    reple.Score = star
                    G3Reple.append(reple)
                }
                print("이 덧글의 phoneNum은 \(temp.value(forKey: "phoneNum")) 입니다.")      //temp에 키를 검색해서 접근함
                print("이 덧글의 text는 \(temp.value(forKey: "text")) 입니다.")      //temp에 키를 검색해서 접근함
                print("이 덧글의 score는 \(temp.value(forKey: "score")) 입니다.")      //temp에 키를 검색해서 접근함
                print("이 덧글의 createAt은 \(temp.value(forKey: "createAt")) 입니다.")      //temp에 키를 검색해서 접근함
                print("이 덧글의 cafeID은 \(temp.value(forKey: "cafeID")) 입니다.")      //temp에 키를 검색해서 접근함
            }

        }
        
        socket.on("orderSuccess"){data, ack in
            print("!!!!!!!orderSuccess!!!!!!")
            print(data[0])
            
            let index:Int64 = (data[0] as AnyObject).int64Value
            status.updatemCafeNumber(order: index)
            //넣어
        }
        
        socket.on("successCall"){data, ack in
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // 진동
            let alert = UIAlertController(title: "예약하신 상품이 준비되었습니다.", message: "어서오세요", preferredStyle: UIAlertControllerStyle.alert)
            var orderMenuString: String = ""
            var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                UIAlertAction in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchStartViewControllers()
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
    func setWaitingNumber(Main:MainViewController){
        print("대기인원요청")
        mainView = Main
        self.socket.emit("requestWaitingNum")
    }
    
    func sendPhoneNum(){
        print("폰번호전송")
        self.socket.emit("sendPhoneNum", status.getOrderList().phoneNumber!)
    }
    
    func deleteReserve(View:ReservationViewController){
        print("예약취소")
        reserveView = View
        self.socket.emit("deleteReserve", String(status.getOrderList().mCafeNumber))
    }
    
    func sendScore(star:String, text:String, cafeID:String){
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
        data.append(cafeID)
        self.socket.emit("sendScore", data)
    }
    
    func requestScore(cafeID:String) {
        //명지카페 = 1, 그라지에 = 2, 그라지에3 = 3
        
        print("카페 덧글 요청");
        self.socket.emit("sendOrder", cafeID);
    }
    
    func sendOrder(phoneNum:String, time:String, productName:String, productCnt:String, total:Int64, cafeName:String) {
        
        // var data = Order(phoneNum: phoneNum, time: time, productName: productName, productCnt: productCnt)
        var data:[String] = []
        data.append(phoneNum)
        data.append(time)
        data.append(productName)
        data.append(productCnt)
        data.append(String(total))
        data.append(cafeName)
        
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
