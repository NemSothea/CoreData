//
//  Food+CoreDataProperties.swift
//  TestCoreData
//
//  Created by sok channy on 12/2/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food");
    }

    @NSManaged public var create: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var toCategory: Category?
    @NSManaged public var toImage: Image?
    @NSManaged public var toIncredient: NSSet?

}

// MARK: Generated accessors for toIncredient
extension Food {

    @objc(addToIncredientObject:)
    @NSManaged public func addToToIncredient(_ value: Incredient)

    @objc(removeToIncredientObject:)
    @NSManaged public func removeFromToIncredient(_ value: Incredient)

    @objc(addToIncredient:)
    @NSManaged public func addToToIncredient(_ values: NSSet)

    @objc(removeToIncredient:)
    @NSManaged public func removeFromToIncredient(_ values: NSSet)

}
