//
//  DealEditView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DealEditView: View {
    
    
    var deal: Deal
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var photo: UIImage? = nil
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var year: String = ""
    @State private var make: String = ""
    @State private var model: String = ""
    @State private var trim: String = ""
    @State private var order: String = ""
    @State private var type: String = ""
    @State private var dateSold: Date = Date()
    
    var body: some View {
        
        Group {
            DealForm(photo: self.$photo,
                         firstName: self.$firstName,
                         lastName: self.$lastName,
                         year: self.$year,
                         make: self.$make,
                         model: self.$model,
                         trim: self.$trim,
                         order: self.$order,
                         type: self.$type,
                         soldDate: self.$dateSold)
        }
        .onAppear(perform:{ self.onAppear()})
        .navigationBarTitle(Text("Deal Info"))
        .navigationBarItems(leading: Button(action: { self.cancelAction() }) { Text("Cancel") },
                            trailing: Button(action: { self.saveAction()}) { Text("Save")
                            }.disabled(!self.dirty()))
    }
    
    func onAppear() {
        self.photo = (UIImage(data: deal.photo!) ?? UIImage().vehicleImage)
        self.dateSold = self.deal.dateSold
        self.firstName = self.deal.firstName
        self.lastName = self.deal.lastName
        self.year = self.deal.year
        self.make = self.deal.make
        self.model = self.deal.model
        self.trim = self.deal.trim
        self.order = String(self.deal.order)
        self.type = self.deal.type
    }
    
    func cancelAction() {
        self.photo = nil
        self.firstName = ""
        self.lastName = ""
        self.year = ""
        self.make = ""
        self.model = ""
        self.trim = ""
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        self.deal.update(image: self.photo ?? UIImage().vehicleImage,
                         dateSold: self.dateSold,
                         firstName: self.firstName,
                         lastName: self.lastName,
                         type: self.type,
                         year: self.year,
                         make: self.make,
                         model: self.model,
                         trim: self.trim,
                         order: self.order)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.year.isEmpty && !self.make.isEmpty && !self.model.isEmpty && !self.trim.isEmpty && (  (self.year != self.deal.year) || (self.make != self.deal.make) || (self.model != self.deal.model) || (self.trim != self.deal.trim) || (Int32(self.order) != self.deal.order) || (( self.photo ?? UIImage(data: deal.photo!) != nil)))
    }
}

struct DealEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DealEditView(deal: Deal.preview())
        }
    }
}
