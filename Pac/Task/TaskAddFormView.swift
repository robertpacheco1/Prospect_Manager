//
//  Task.swift
//  Pac
//
//  Created by Robert Pacheco on 2/11/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct TaskAddView: View {
    @ObservedObject var person: Person
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var title: String = ""
    @State private var dueDate = Date()
    @State private var year: String = ""
    
    
    
    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    self.cancelAction()
                }) {
                    Text("Cancel")
                        .foregroundColor(Color("orange"))
                }
                Spacer()
                Button(action: {
                    self.saveAction()
                }) {
                    Text("Save")
                        .foregroundColor(Color("green"))
                }
            }
            .padding()
            TaskFormView(taskName: self.$title, dueDate: self.$dueDate, dateCompleted: self.$dueDate, show: .constant(false))
            
        }
    }

    func cancelAction() {
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        
        _ = ToDo.addTask(person: person,
                         taskName: self.title,
                         dueDate: self.dueDate)
        self.cancelAction()
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskAddView(person: Person.allInOrder().first!)
        }
    }
}
