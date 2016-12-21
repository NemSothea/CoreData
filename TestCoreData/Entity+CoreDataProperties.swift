//
//  Entity+CoreDataProperties.swift
//  TestCoreData
//
//  Created by sok channy on 12/5/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity");
    }

    @NSManaged public var name: String?

}
