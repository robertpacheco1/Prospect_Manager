//
//  BarView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/24/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DealForm: View, MultiPurposeForm{
    var onCreate: (() -> Void)?
    
    var onUpdate: (() -> Void)?
    
    var onCancel: (() -> Void)?
    
    var enableCreate: Bool?
    
    var enableUpdate: Bool?
    
    var rowActions: [MultiPurposeFormRowAction] = []
    
    
    @Binding var photo: UIImage?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var year: String
    @Binding var make: String
    @Binding var model: String
    @Binding var trim: String
    @Binding var order: String
    @State private var shown: Bool = false
    @State private var popup: Bool = false
    @Binding var type: String
    @Binding var soldDate: Date
    @State private var shownDate: Bool = false
    var body: some View {
        
        let form = Form {
                ZStack(alignment: .bottom) {
                Image(uiImage: self.photo ?? UIImage().vehicleImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    
                    Button(action: {
                               self.shown.toggle()
                           }){
                               Image(systemName: "plus")
                                   .foregroundColor(.white)
                                   .font(.system(size: 30, weight: .bold))
                               
                           }.buttonStyle(DarkButtonStyle())
                    .offset(y: 40)
                }
            Section(header: Text.topSection("DEAL INFO")) {
                Picker("Condition", selection: self.$type) {
                    Text("New").tag("New")
                    Text("Used").tag("Used")
                }
                .pickerStyle(SegmentedPickerStyle())
                HStack {
                    VerticalTextField(text: $year, label: "Year", placeholder: "2020")
                        .keyboardType(.numberPad)
                    
                    VerticalTextField(text: $make, label: "Make", placeholder: "make")
                }
                HStack {
                    VerticalTextField(text: $model, label: "Model", placeholder: "model")
                    
                    VerticalTextField(text: $trim, label: "Trim", placeholder: "trim")
                }
            }
            .sheet(isPresented: self.$shown) { ImagePicker(isShown: self.$shown, image: self.$photo)}
            .onTapGesture {
                self.endEditing(true)
            }
            
        }
        return setupNavItems(forForm: form.eraseToAnyView())
    }
}

struct DealForm_Previews: PreviewProvider {
    static var previews: some View {
        DealForm(photo: .constant(UIImage().vehicleImage),
        firstName: .constant("Roberto"),
        lastName: .constant("Pacheco"),
        year: .constant("2020"),
        make: .constant("Nissan"),
        model: .constant("Altima"),
        trim: .constant("SR"),
        order: .constant("1"),
        type: .constant("New"),
        soldDate: .constant(Date.currentYMDHM))
    }
}
struct bt: View {
    @Binding var open: Bool
    @Binding var show: Bool
    var body: some View {
        ZStack {
            Button(action: {
                self.open.toggle()
            }){
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .bold))
                
            }.buttonStyle(DarkButtonStyle())
                .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            
            SecondButton(open: $open, icon: "plus.circle", offsetX: -60, offsetY: -60, delay: 0.02, action: $show)
//            SecondButton(open: $open, icon: "minus", offsetX: 60, action: $delete)
              
        }
    }
}
