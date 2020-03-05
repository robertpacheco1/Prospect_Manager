//
//  PersonEditView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PersonEditView: View {
    var person: Person
    
    @State private var editMode: EditMode = .inactive
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var image: UIImage?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var cellPhone: String = ""
    @State private var email: String = ""
    @State private var note: String = ""
    @State private var order: String = ""
    @State private var date: Date = Date()
    @ObservedObject private var dataSource = CoreDataDataSource<Deal>(predicateKey: "person")
    @ObservedObject private var dB = CoreDataDataSource<ToDo>(predicateKey: "person")
    @State var selectedDate = Date()

    @State private var showingAttributeAddView = false
    
    @State private var addTask = false
    @State private var keyboard: CGFloat = 0.0

    var body: some View {
        
        VStack {
            HStack(alignment: .bottom, spacing: 35) {
                
                ActivateButton(activates: self.$showingAttributeAddView) {
                    VStack {
                        Image(systemName: "plus")
                        Text("Vehicle")
                    }
                }

                ActivateButton(activates: self.$addTask) {
                    VStack {
                        Image(systemName: "plus")
                        Text("Task")
                    }
                }
                
                EditSaveDoneButton(
                    editAction: {
                        self.editMode = .active },
                    saveAction: { self.saveAction() },
                    doneAction: { self.editMode = .inactive },
                    dirty: self.dirty())
                
            }
            .foregroundColor(Color("b3"))
            .padding([.leading, .trailing], 20)
            .padding([.bottom, .top], 10)
            .frame(height: 70)
            .background(Rounded().fill(Color("dark")))
            Form {
                PersonFormView(image: self.$image,
                               firstName: self.$firstName,
                               lastName: self.$lastName,
                               phone: self.$cellPhone,
                               order: self.$order,
                               email: self.$email,
                               notes: self.$note,
                               dateAdded: self.$date,
                               editMode: self.$editMode)
            
                Section(header: Text("Sold Info".uppercased()).foregroundColor(Color("b3"))) {
                    ForEach(dataSource.loadDataSource(relatedTo: person)) { deal in
                        
                        if self.editMode == .active {
                            DealCellView(
                                year: deal.year,
                                make: deal.make,
                                model: deal.model,
                                order: deal.order)
                        } else {
                            NavigationLink(destination: DealEditView(deal: deal)) {
                                DealCellView(
                                    year: deal.year,
                                    make: deal.make,
                                    model: deal.model,
                                    order: deal.order)
                            }
                        }
                    }
                    .onMove(perform: self.dataSource.move)
                    .onDelete(perform: self.dataSource.delete)
                }
                
                Section(header: Text("To Do").foregroundColor(Color("b3"))) {
                    ForEach(dB.loadDataSource(relatedTo: person)) { task in
                        if self.editMode == .active {
                             TaskRow(todo: task, todayDate: self.selectedDate)
                        } else {
                            NavigationLink(destination: TaskEditView(task: task)) {
                                TaskRow(todo: task, todayDate: self.selectedDate)
                            }
                        }
                    }
                    .onMove(perform: self.dB.move)
                    .onDelete(perform: self.dB.delete)
                }
            }
            
            HiddenNavigationLink(destination: DealAddView(person: person),
                                 isActive: self.$showingAttributeAddView)
            HiddenNavigationLink(destination: TaskAddView(person: person), isActive: self.$addTask)

        }
        .onAppear(perform: {
            self.onAppear()

        })
        .navigationBarTitle(Text("\(self.editMode == .active ? "Edit" : "View") Contact Details"),
                            displayMode: .inline)
            .environment(\.editMode, self.$editMode)
    }
    
    func onAppear() {
        
        self.image = UIImage(data: self.person.photo!) ?? UIImage().placeholderImage
        self.firstName = self.person.firstName
        self.lastName = self.person.lastName
        self.cellPhone = self.person.cellPhone
        self.email = self.person.email
        self.note = self.person.note
        self.date = self.person.createdDate
        self.order = String(self.person.order)
        
        
    }
    
    func cancelAction() {
        
        self.image = image?.placeholderImage
        self.firstName = ""
        self.lastName = ""
        self.cellPhone = ""
        self.email = ""
        self.note = ""
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
                
        self.person.update(
            image: self.image ?? UIImage().placeholderImage,
            firstName: self.firstName,
            lastName: self.lastName,
            cellPhone: self.cellPhone,
            note: self.note,
            email: self.email,
            order: self.order)
        
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        
        return !self.firstName.isEmpty && !self.lastName.isEmpty && !self.cellPhone.isEmpty && self.order.isInt  &&
            ((self.firstName != self.person.firstName) || (self.lastName != self.person.lastName) || (self.cellPhone != self.person.cellPhone) || (self.note != self.person.note) || (self.email != self.person.email) || (Int32(self.order) != self.person.order) || (( self.image ?? UIImage(data: person.photo!) != nil)))
    }
    
}

struct PersonEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonEditView(person: Person.preview())
        }.preferredColorScheme(.dark)
    }
}
