//
//  Category+CoreDataProperties.swift
//  TestCoreData
//
//  Created by sok channy on 12/2/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var name: String?
    @NSManaged public var toFood: NSSet?

}

// MARK: Generated accessors for toFood
extension Category {

    @objc(addToFoodObject:)
    @NSManaged public func addToToFood(_ value: Food)

    @objc(removeToFoodObject:)
    @NSManaged public func removeFromToFood(_ value: Food)

    @objc(addToFood:)
    @NSManaged public func addToToFood(_ values: NSSet)

    @objc(removeToFood:)
    @NSManaged public func removeFromToFood(_ values: NSSet)

}
