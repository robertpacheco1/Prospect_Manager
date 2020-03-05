//
//  Pictures+CoreDataProperties.swift
//  Pac
//
//  Created by Robert Pacheco on 2/22/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Pictures {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pictures> {
        return NSFetchRequest<Pictures>(entityName: "Pictures")
    }

    @NSManaged public var img: Data?
    @NSManaged public var dateAdded: Date
    @NSManaged public var order: Int32
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var person: Person

    var image : UIImage? {
         guard let data = self.img else {
             return nil
         }
         return UIImage(data: data)
     }
}
