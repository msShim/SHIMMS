//
//  OrderList.swift
//  CafeGo
//
//  Created by 심명섭 on 2016. 10. 11..
//  Copyright © 2016년 Team6. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class OrderListService {
    var entityDescription:NSEntityDescription?
    var generalStatus: NSManagedObject?
    let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }
    func create(orderMenu: String, orderBook: Bool, orderNumber:Int64, cafeName:String) -> OrderList {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: OrderList.entityName, into: context) as! OrderList
        
        newItem.orderMenu = orderMenu
        newItem.orderNumber = orderNumber
        newItem.orderBook = orderBook
        newItem.cafeName = cafeName
        
        self.saveChanges()
        return newItem
    }
    
    // Gets a Status by id
    func getById(id: NSManagedObjectID) -> OrderList? {
        return context.object(with: id) as? OrderList
    }
    
    func get() -> OrderList {
        
        let predicate = NSPredicate.init(value: true)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: OrderList.entityName)
        
        fetchRequest.predicate = predicate
        
        do {
            let response = try context.fetch(fetchRequest)
            if(response.count<1){
                return create(orderMenu: "", orderBook: false, orderNumber: 0, cafeName: "")
            } else {
                return response.last as! OrderList
            }
            
        } catch let error as NSError {
            // failure
            print(error)
            return OrderList()
        }
        
    }
    
    func getAll() -> [OrderList]{
        return getWith(withPredicate: NSPredicate(value:true))
    }
    
    func getWith(withPredicate queryPredicate: NSPredicate) -> [OrderList]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: OrderList.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [OrderList]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [OrderList]()
        }
    }
    
    // Updates a Status
    func update(updatedStatus: OrderList){
        if let orderlist = getById(id: updatedStatus.objectID){
            orderlist.cafeName = updatedStatus.cafeName
            orderlist.orderBook = updatedStatus.orderBook
            orderlist.orderMenu = updatedStatus.orderMenu
            orderlist.orderNumber = updatedStatus.orderNumber
        }
    }
    
    // Deletes a Status
    func deleteStatus(id: NSManagedObjectID){
        if let statusToDelete = getById(id: id){
            context.delete(statusToDelete)
        }
    }
}
