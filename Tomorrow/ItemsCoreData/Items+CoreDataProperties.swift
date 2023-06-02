//
//  Items+CoreDataProperties.swift
//  Tomorrow
//
//  Created by Kerem Demır on 10.05.2023.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged var order: Int16
}

extension Items : Identifiable {

}
