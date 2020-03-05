//
//  ToDo+CoreDataProperties.swift
//  Pac
//
//  Created by Robert Pacheco on 2/7/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String
    @NSManaged public var firstName: String
    @NSManaged public var due: Date
    @NSManaged public var isComplete: Bool
    @NSManaged public var person: Person
    @NSManaged public var photo: Data?
    @NSManaged public var order: Int32
}



