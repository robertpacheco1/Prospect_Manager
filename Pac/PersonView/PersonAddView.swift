//
//  PersonAddView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

extension String {
    
    var isInt: Bool {
        return Int(self) != nil
    }
}

struct PersonAddView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var image: UIImage?
    @State private var selectedSegment = 0
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var cellPhone: String = ""
    @State private var email: String = ""
    @State private var note: String = ""
    @State private var isPayed: Bool = false
    @State private var order: String = ""
    @State private var date = Date()


    var body: some View {
        Group {
            ContactForm(
                image: self.$image,
                firstName: self.$firstName,
                lastName: self.$lastName,
                phone: self.$cellPhone,
                order: self.$order,
                email: self.$email,
                notes: self.$note,
                dateAdded: self.$date)
        }
        .onAppear(perform: { self.onAppear() })
        .navigationBarTitle(Text("Add Contact"), displayMode: .inline)
        .navigationBarItems(
            leading: Button(action:{ self.cancelAction() }) { Text("Cancel") },
            trailing: Button(action:{ self.saveAction() }) { Text("Save") }
                .disabled(!self.dirty()) )
    }
    
    func onAppear() {
        
        let order = Person.nextOrder()
        self.image = image?.placeholderImage
        self.firstName = ""
        self.lastName = ""
        self.cellPhone = ""
        self.email = ""
        self.note = ""
        self.date = Date.currentYMDHM
        self.order = String(order)
    }
    
    func cancelAction() {
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        
        
        _ = Person.createPerson(
            image: self.image ?? UIImage().placeholderImage,
            firstName: self.firstName,
            lastName: self.lastName,
            cellPhone: self.cellPhone,
            email: self.email,
            note: self.note,
            dateAdded: self.date,
            order: Int(self.order))
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        
        return !self.firstName.isEmpty && !self.lastName.isEmpty && !self.cellPhone.isEmpty && self.order.isInt
    }
}

struct PersonAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonAddView()
        }.preferredColorScheme(.dark)
    }
}
