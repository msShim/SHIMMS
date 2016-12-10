//
//  StatusService.swift
//  CafeGo
//
//  Created by 5407-35 on 2016. 10. 11..
//  Copyright © 2016년 SMS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class StatusService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    let orderList = OrderListService()
    
    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }
    
    func getOrderList() -> OrderList{
        return orderList.get()
    }
    
    func addValue(value1:String, value2:String) -> String {
        
        var result = value1 + "|"
        result = result + value2
        
        return result
    }
    func updateOrder(order:String){
        let menu = getOrderList()
        
        menu.orderMenu = addValue(value1: menu.orderMenu!, value2: order)
        orderList.update(updatedStatus: menu)
        self.saveChanges()
    }
    func initOrder(order:String){
        let menu = getOrderList()
        
        menu.orderMenu = order
        orderList.update(updatedStatus: menu)
        self.saveChanges()
    }
    func updateQuantity(order:String){
        let menu = getOrderList()
        
        menu.orderQuantity = addValue(value1: menu.orderQuantity!, value2: order)
        orderList.update(updatedStatus: menu)
        self.saveChanges()
    }
    func initQuantity(order:String){
        let menu = getOrderList()
        
        menu.orderQuantity = order
        orderList.update(updatedStatus: menu)
        self.saveChanges()
    }
    func updateCafeName(order:String){
        let name = getOrderList()
        
        name.cafeName = order
        orderList.update(updatedStatus: name)
        self.saveChanges()
    }
    func updateOrderNumber(order:Int64){
        let number = getOrderList()
        
        number.orderNumber = order
        orderList.update(updatedStatus: number)
        self.saveChanges()
    }
    func updateMCupon(order:String){
        let number = getOrderList()
        
        number.mCoupon = order
        orderList.update(updatedStatus: number)
        self.saveChanges()
    }
    func updateGCupon(order:String){
        let number = getOrderList()
        number.gCoupon = order
        orderList.update(updatedStatus: number)
        self.saveChanges()
    }
    func updateOrderBook(book:Bool){
        let order = getOrderList()
        
        order.orderBook = book
        orderList.update(updatedStatus: order)
        self.saveChanges()
    }
    func updateOrderCount(order:Int64){
        let number = getOrderList()
        
        number.orderCount = order
        orderList.update(updatedStatus: number)
        self.saveChanges()
    }
    func updatemCafeNumber(order:Int64){
        let number = getOrderList()
        
        number.mCafeNumber = order
        orderList.update(updatedStatus: number)
        self.saveChanges()
    }
    func updateTime(order:String){
        let book = getOrderList()
        
        book.orderTime = order
        orderList.update(updatedStatus: book)
        self.saveChanges()
    }
    func updatePhoneNumber(number:String){
        let phone = getOrderList()
        
        phone.phoneNumber = number
        orderList.update(updatedStatus: phone)
        self.saveChanges()
    }
    func updateVerification(verif:Bool){
        let verification = getOrderList()
        
        verification.verification = verif
        orderList.update(updatedStatus: verification)
        self.saveChanges()
    }
    func updateMCoupon(couponNum:String){
        let coupon = getOrderList()
        
        coupon.mCoupon = couponNum
        orderList.update(updatedStatus: coupon)
        self.saveChanges()
    }
    func updateGCoupon(couponNum:String){
        let coupon = getOrderList()
        
        coupon.gCoupon = couponNum
        orderList.update(updatedStatus: coupon)
        self.saveChanges()
    }
}
