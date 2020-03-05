//
//  ToDo+CoreDataClass.swift
//  Pac
//
//  Created by Robert Pacheco on 2/7/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(ToDo)
public class ToDo: NSManagedObject, Identifiable {
    
    
    class func allInOrder() -> [ToDo] {
        
        let dataSource = CoreDataDataSource<ToDo>(sortKey1: "person.order",
                                                       sortKey2: "order",
                                                       sectionNameKeyPath: "person.firstName")
        let objects = dataSource.fetch()
        return objects
    }
    
    #if DEBUG
    class func preview() -> ToDo {
        
        let task =  ToDo.allInOrder()
        if task.count > 0 {
            return task.first!
        } else {
            let person = Person.createPerson(image: (UIImage().placeholderImage),
                                             firstName: "Robert",
                                             lastName: "Pacheco",
                                             cellPhone: "1234567890",
                                             email: "n@n.com",
                                             note: "Something about the customer",
                                             dateAdded: Date.currentYMDHM,
                                             order: 000)
            
            return ToDo.addTask(person: person,
                                taskName: "call customer",
                                dueDate: Date())
        }
    }
    #endif
    class func newTask() -> ToDo {
        return ToDo(context: CoreData.stack.context)
    }
    
    class func addTask(person: Person,
                       taskName: String,
                       dueDate: Date) -> ToDo {
        
        let task = ToDo.newTask()
        task.title = taskName
        task.due = dueDate
        task.isComplete = false
        task.person = person
        CoreData.stack.save()
        return task
    }
   
    public func updateTask(title: String,
                           isComplete: Bool) {
        
        self.isComplete = isComplete
        self.title = title
        
        CoreData.stack.save()
    }
    
    public func delete() {
        CoreData.stack.context.delete(self)
    }
    
}
