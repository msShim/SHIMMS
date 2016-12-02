//
//  OrderList+CoreDataProperties.swift
//  
//
//  Created by 남조선명지대학 on 2016. 12. 1..
//
//

import Foundation
import CoreData


extension OrderList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderList> {
        return NSFetchRequest<OrderList>(entityName: "OrderList");
    }

    @NSManaged public var cafeName: String?
    @NSManaged public var mCafeNumber: Int64
    @NSManaged public var orderBook: Bool
    @NSManaged public var orderCount: Int64
    @NSManaged public var orderMenu: String?
    @NSManaged public var orderNumber: Int64
    @NSManaged public var orderQuantity: String?
    @NSManaged public var orderTime: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var verification: Bool
    @NSManaged public var mCoupon: String?
    @NSManaged public var gCoupon: String?

}
