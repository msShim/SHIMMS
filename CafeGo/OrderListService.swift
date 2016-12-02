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
    
    //시간 메뉴 예약 총액 카페이름 수량
    func create(orderMenu: String, orderTime: String, orderNumber:Int64, cafeName:String, orderBook:Bool, orderQuantity:String) -> OrderList {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: OrderList.entityName, into: context) as! OrderList
        
        newItem.orderMenu = orderMenu
        newItem.orderNumber = orderNumber
        newItem.orderTime = orderTime
        newItem.cafeName = cafeName
        newItem.orderBook = orderBook
        newItem.orderQuantity = orderQuantity
        self.saveChanges()
        return newItem
    }
    
    func isVerification(verification :Bool) -> Bool{
        return get().verification
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
                return create(orderMenu: "", orderTime: "", orderNumber: 0, cafeName: "", orderBook: false, orderQuantity: "")
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
            orderlist.orderTime = updatedStatus.orderTime
            orderlist.orderMenu = updatedStatus.orderMenu
            orderlist.orderNumber = updatedStatus.orderNumber
            orderlist.phoneNumber = updatedStatus.phoneNumber
            orderlist.verification = updatedStatus.verification
            orderlist.mCafeNumber = updatedStatus.mCafeNumber
            orderlist.orderCount = updatedStatus.orderCount
            orderlist.orderBook = updatedStatus.orderBook
            orderlist.orderQuantity = updatedStatus.orderQuantity
            orderlist.mCoupon = updatedStatus.mCoupon
            orderlist.gCoupon = updatedStatus.gCoupon
        }
    }
    
    // Deletes a Status
    func deleteStatus(id: NSManagedObjectID){
        if let statusToDelete = getById(id: id){
            context.delete(statusToDelete)
        }
    }
}
