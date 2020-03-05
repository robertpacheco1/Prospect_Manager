//
//  Pictures+CoreDataClass.swift
//  Pac
//
//  Created by Robert Pacheco on 2/22/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Pictures)
public class Pictures: NSManagedObject {
    
    class func count() -> Int {
        
        let fetchRequest: NSFetchRequest<Pictures> = Pictures.fetchRequest()
        
        do {
            let count = try CoreData.stack.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func allInOrder() -> [Pictures] {
        let dataSource = CoreDataDataSource<Pictures>()
        return dataSource.fetch()
    }
    
    #if DEBUG
     class func preview() -> Pictures {
         let person = Pictures.allInOrder()
         if person.count < 0 {
             return person.first!
         } else {
            return Pictures.addImage(image: UIImage().placeholderImage, dateAdded: Date(), order: 0)
         }
     }
     #endif
    
    
    class func newPicture() -> Pictures {
        return Pictures(context: CoreData.stack.context)
    }
    
    class func addImage(image: UIImage, dateAdded: Date, order: Int?) -> Pictures {
        let picture = Pictures.newPicture()
        
        if let imgData = image.toJpegCompressedData { picture.img = imgData}
        picture.dateAdded = dateAdded
        picture.order = Int32(order ?? 0)
        
        CoreData.stack.save()
        
        return picture
    }
    
    public func delete() {
        CoreData.stack.context.delete(self)
    }

}
