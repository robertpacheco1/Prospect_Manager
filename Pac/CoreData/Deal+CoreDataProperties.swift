//
//  Deal+CoreDataProperties.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

extension Deal {
    
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deal> {
        return NSFetchRequest<Deal>(entityName: "Deal")
    }
    @NSManaged public var dateSold: Date
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var year: String
    @NSManaged public var make: String
    @NSManaged public var model: String
    @NSManaged public var trim: String
    @NSManaged public var order: Int32
    @NSManaged public var type: String
    @NSManaged public var photo: Data?
    @NSManaged public var person: Person
    
    
       

}
