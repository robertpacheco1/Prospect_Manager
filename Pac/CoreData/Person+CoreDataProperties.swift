//
//  Person+CoreDataProperties.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension Person {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
           return NSFetchRequest<Person>(entityName: "Person")
       }
    
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var email: String
    @NSManaged public var photo: Data?
    @NSManaged public var createdDate: Date
    @NSManaged public var order: Int32
    @NSManaged public var selected: Bool
    @NSManaged public var cellPhone: String
    @NSManaged public var note: String
    @NSManaged public var deal: Deal
    @NSManaged public var todo: ToDo
    
    var image : UIImage? {
        guard let data = self.photo else {
            return nil
        }
        return UIImage(data: data)
    }
    
}


