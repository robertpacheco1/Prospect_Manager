//
//  DealAddView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DealAddView: View {
    @ObservedObject var person: Person
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var photo: UIImage?
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
        .onAppear(perform: {self.onAppear()})
        .navigationBarTitle(Text("Add Deal info"), displayMode: .large)
        .navigationBarItems(leading: Button(action:{ self.cancelAction() }) { Text("Cancel") },
                            trailing: Button(action:{ self.saveAction() }) { Text("Save") }.disabled(!self.dirty()) )
    }
    func onAppear() {
        let order = Deal.nextOrderFor(person: person)
        self.order = String(order)
        self.photo = photo?.placeholderImage
    }
    
    func cancelAction() {
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {

        _ = Deal.createDealFor(person: person,
                               image: self.photo ?? UIImage().vehicleImage,
                               dateSold: self.dateSold,
                               firstName: person,
                               lastName: person,
                               type: self.type,
                               year: self.year,
                               make: self.make,
                               model: self.model,
                               trim: self.trim,
                               order: Int(self.order))
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        
        return !self.year.isEmpty && !self.make.isEmpty && !self.model.isEmpty && self.order.isInt
    }

}

struct DealAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            DealAddView(person: Person.allInOrder().first!)
        }
    }
}
