//
//  CoreData.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import CoreData
import SwiftUI

class CoreData: NSObject {
    static let stack = CoreData()   // Singleton
    
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pac")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }() 
    
    public var context: NSManagedObjectContext {
        get {
            return self.persistentContainer.viewContext
        }
    }
    // MARK: - Core Data Saving support
    
    public func save() {
        
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("In CoreData.stack.save()")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Database setup
    
    public class func initialDbSetup() -> Void {
        if Person.count() == 0 {
            for i in 0...4 {
                let person = Person.createPerson(
                    image: (UIImage().placeholderImage),
                    firstName: "First",
                    lastName: "Last",
                    cellPhone: "",
                    email: "",
                    note: "Notes",
                    dateAdded: Date(),
                    order: i)
                for j in 0...4 {
                    _ = Deal.createDealFor(person: person,
                                           image: (UIImage().placeholderImage),
                                           dateSold: Date(),
                                           firstName: person,
                                           lastName: person,
                                           type: "New",
                                           year: "Year",
                                           make: "Make",
                                           model: "Model",
                                           trim: "Trim",
                                           order: j)
                }
                
            }
        }
    }
    
    // MARK: - Managed Object Helpers
    
    class func executeBlockAndCommit(_ block: @escaping () -> Void) {
        block()
        CoreData.stack.save()
    }
    
}
