//
//  Deal+CoreDataClass.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

@objc(Deal)
public class Deal: NSManagedObject, Identifiable {
    
    //MARK: Helpers
    
    class func count() -> Int {
        
        let context = CoreData.stack.context
        
        let fetchRequest: NSFetchRequest<Deal> = Deal.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func nextOrderFor(person: Person) -> Int {
        
        let keyPathExpression = NSExpression.init(forKeyPath: "order")
        let maxNumberExpression = NSExpression.init(forFunction: "max:", arguments: [keyPathExpression])
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "maxNumber"
        expressionDescription.expression = maxNumberExpression
        expressionDescription.expressionResultType = .decimalAttributeType
        
        var expressionDescriptions = [AnyObject]()
        expressionDescriptions.append(expressionDescription)
        
        let predicate = NSPredicate(format: "person == %@", person)
        
        // Build out our fetch request the usual way
        let request: NSFetchRequest<NSFetchRequestResult> = Deal.fetchRequest()
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = expressionDescriptions
        request.predicate = predicate
        
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
    
    class func allInOrder() -> [Deal] {
        
        let dataSource = CoreDataDataSource<Deal>(sortKey1: "person.order",
                                                       sortKey2: "order",
                                                       sectionNameKeyPath: "person.firstName")
        let objects = dataSource.fetch()
        return objects
    }
    
    #if DEBUG
    class func preview() -> Deal {
        
        let deal =  Deal.allInOrder()
        if deal.count > 0 {
            return deal.first!
        } else {
            let person = Person.createPerson(image: UIImage().placeholderImage,
                                             firstName: "Robert",
                                             lastName: "Pacheco",
                                             cellPhone: "1234567890",
                                             email: "n@n.com",
                                             note: "Something about the customer",
                                             dateAdded: Date(),
                                             order: 000)
            
            return Deal.createDealFor(person: person,
                                      image: UIImage().placeholderImage,
                                      dateSold: Date(),
                                      firstName: person,
                                      lastName: person,
                                      type: "New",
                                      year: "2017",
                                      make: "Nissan",
                                      model: "Altima",
                                      trim: "SR",
                                      order: 999)
        }
    }
    #endif
    
    //MARK: CRUD
    
    class func newAttribute() -> Deal {
        
        return Deal(context: CoreData.stack.context)
    }
    
    class func createDealFor(person: Person,
                             image: UIImage?,
                             dateSold: Date,
                             firstName: Person,
                             lastName: Person,
                             type: String,
                             year: String,
                             make: String,
                             model: String,
                             trim: String,
                             order: Int?) -> Deal {
        
        let deal = Deal.newAttribute()
        if let imgData = image?.toJpegCompressedData { deal.photo = imgData}
        deal.dateSold = dateSold
        deal.firstName = person.firstName
        deal.lastName = person.lastName
        deal.type = type
        deal.year = year
        deal.make = make
        deal.model = model
        deal.trim = trim
        deal.order = Int32(order ?? 0)
        deal.person = person
        CoreData.stack.save()
        
        return deal
    }
    
    public func update(image: UIImage?,
                       dateSold: Date,
                       firstName: String,
                       lastName: String,
                       type: String,
                       year: String,
                       make: String,
                       model: String,
                       trim: String,
                       order: String) {
        
        if let imgData = image?.toJpegCompressedData { photo = imgData}
        self.type = type
        self.dateSold = dateSold
        self.firstName = person.firstName
        self.lastName = person.lastName
        self.year = year
        self.make = make
        self.model = model
        self.trim = trim
        self.order = Int32(order)!
        
        CoreData.stack.save()
    }
    
    public func delete() {
        
        CoreData.stack.context.delete(self)
    }
    
}
