//
//  Food+CoreDataClass.swift
//  TestCoreData
//
//  Created by sok channy on 12/2/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import Foundation
import CoreData


public class Food: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.create = NSDate()
    }
}
