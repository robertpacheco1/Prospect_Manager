//
//  Person+CoreDataClass.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

@objc(Person)
public class Person: NSManagedObject, Identifiable {
    
    class func count() -> Int {
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let count = try CoreData.stack.context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func nextOrder() -> Int {
        
        let keyPathExpression = NSExpression.init(forKeyPath: "order")
        let maxNumberExpression = NSExpression.init(forFunction: "max:", arguments: [keyPathExpression])
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "maxNumber"
        expressionDescription.expression = maxNumberExpression
        expressionDescription.expressionResultType = .decimalAttributeType
        
        var expressionDescriptions = [AnyObject]()
        expressionDescriptions.append(expressionDescription)
        
        // Build out our fetch request the usual way
        let request: NSFetchRequest<NSFetchRequestResult> = Person.fetchRequest()
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = expressionDescriptions
        request.predicate = nil
        
        // Our result should to be an array of dictionaries.
        var results: [[String:AnyObject]]?
        
        do {
            results = try CoreData.stack.context.fetch(request) as? [[String:NSNumber]]
            
            if let maxNumber = results?.first!["maxNumber"]  {
                // Return one more than the current max order
                return maxNumber.intValue + 1
            } else {
                // If no items present, return 0
                return 0
            }
        } catch _ {
            // If any failure, just return default
            return 0
        }
    }
    
    class func allInOrder() -> [Person] {
        
        let datasource = CoreDataDataSource<Person>()
        return datasource.fetch()
    }
    
    #if DEBUG
    class func preview() -> Person {
        let person = Person.allInOrder()
        if person.count < 0 {
            return person.first!
        } else {
            return Person.createPerson(
                image: UIImage().placeholderImage,
                firstName: "Robert",
                lastName: "Pacheco",
                cellPhone: "8052486562",
                email: "n@n.com",
                note: "something",
                dateAdded: Date(),
                order: 999)
        }
    }
    #endif
    
    class func allSelectedItems() -> [Person] {
        
        let predicate = NSPredicate(format:"selected = true")
        let datasource = CoreDataDataSource<Person>(predicate: predicate)
        return datasource.fetch()
    }
    
    //MARK: CRUD
    
    class func newPerson() -> Person {
        
        return Person(context: CoreData.stack.context)
    }
    
 
    class func createPerson(
        image: UIImage?,
        firstName: String,
        lastName: String,
        cellPhone: String,
        email: String,
        note: String,
        dateAdded: Date,
        order: Int?
    ) -> Person {
    
        
        let person = Person.newPerson()
        if let imgData = image?.toJpegCompressedData { person.photo = imgData}
        
        person.createdDate = dateAdded
        person.firstName = firstName
        person.lastName = lastName
        person.cellPhone = cellPhone
        person.email = email
        person.note = note
        person.order = Int32(order ?? 0)
        
        CoreData.stack.save()
        
        return person
    }
    public func update(
        image: UIImage?,
        firstName: String,
        lastName: String,
        cellPhone: String,
        note: String,
        email: String,
        order: String) {
        
        if let imgData = image?.toJpegCompressedData { self.photo = imgData}
        self.firstName = firstName
        self.lastName = lastName
        self.cellPhone = cellPhone
        self.email = email
        self.note = note 
        self.order = Int32(order)!
        CoreData.stack.save()
    }
    public func update(selected: Bool, commit: Bool) {
        
        self.selected = selected
        CoreData.stack.save()
    }
    
    public func delete() {
        
        CoreData.stack.context.delete(self)
    }
}
