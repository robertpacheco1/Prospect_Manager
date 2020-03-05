//
//  ContactEditView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/26/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ContactEditView: View {
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
    @State private var open = false
    
    @State private var keyboard: CGFloat = 0.0
    var body: some View {
                
        ContactForm(image: self.$image,
                    firstName: self.$firstName,
                    lastName: self.$lastName,
                    phone: self.$cellPhone,
                    order: self.$order,
                    email: self.$email,
                    notes: self.$note,
                    dateAdded: self.$date)
            .onAppear(perform: {self.onAppear()})
            .navigationBarTitle(Text("\(self.editMode == .active ? "Edit" : "") \(person.firstName)"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.saveAction()
            }) {
                Text("Save")
                }.buttonStyle(SimpleButtonStyle())
        )
        
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
}

struct ContactEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactEditView(person: Person.preview())
        }
        //        .preferredColorScheme(.dark)
    }
}

//(open: $open, icon: "person.crop.circle.fill.badge.plus", color: "b3", offsetX: -90)




//ContactDetail(image: $image, firstName: $firstName, lastName: $lastName, phone: $cellPhone, order: $order, email: $email, notes: $note, dateAdded: $date)
//if self.showingAttributeAddView == true {
//    HiddenNavigationLink(destination: DealAddView(person: person),
//                         isActive: self.$showingAttributeAddView)
//}
//if self.addTask == true {
//    HiddenNavigationLink(destination: TaskAddView(person: person), isActive: self.$addTask)
//}
