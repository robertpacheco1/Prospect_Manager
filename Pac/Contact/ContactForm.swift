//
//  BarChartView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/24/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ContactForm: View, MultiPurposeForm {
    var onCreate: (() -> Void)?
    
    var onUpdate: (() -> Void)?
    
    var onCancel: (() -> Void)?
    
    var enableCreate: Bool?
    
    var enableUpdate: Bool?
    
    var rowActions: [MultiPurposeFormRowAction] = []
    
    @ObservedObject private var keyboardObv = KeyboardObserver()
    @Binding var image: UIImage?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    @Binding var order : String
    @Binding var email: String
    @Binding var notes: String
    @Binding var dateAdded: Date    
    @State private var shown = false
    @State private var popup = false
    @State private var addTask = false
    @State private var datePicker = false
    @State private var keyboard: CGFloat = 0
    var body: some View {
        let form = Form {
            Section(header: Text.topSection("Contact Info")) {
                
                ZStack(alignment: .bottom){
                    Image(uiImage: image ?? UIImage().placeholderImage)
                    .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Button(action: {
                        self.popup.toggle()
                    }){
                        Image(systemName: "plus")
                    }
                    .buttonStyle(SimpleButtonStyle())
                        .rotationEffect(.degrees(popup ? 45 : 0))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
                    .zIndex(10)
                   
                        
                    Button(action: {
                        self.shown.toggle()
                    }) {
                        Image(systemName: "plus")
                        }.buttonStyle(SimpleButtonStyle())
                    .offset(x: popup ? -45: 0, y: popup ? -35: 0)
                    Button(action: {
                        self.image = nil
                    }) {
                        Image(systemName: "minus")
                        }.buttonStyle(SimpleButtonStyle())
                        .offset(x: popup ? 45: 0, y: popup ? -35: 0)
                }
                
                HStack {
                    Spacer()
                    VerticalTextField(text: $order, label: "ID #:", placeholder: "id #")
                        .keyboardType(.numberPad)
                        .frame(width: 50)
                }
                HStack {
                    VerticalTextField(text: $firstName, label: "first name", placeholder: "first name", content: .givenName)
                    VerticalTextField(text: $lastName, label: "last name", placeholder: "last name", content: .familyName)
                }
                
                HStack {
                    VerticalTextField(text: $email, label: "email address", placeholder: "email address", content: .emailAddress)
                    VerticalTextField(text: $phone, label: "phone", placeholder: "phone", content: .telephoneNumber).keyboardType(.phonePad)
                }
                
            }
            Section(header: Text("Notes")) {
                
                MultiTextField(txt: $notes)
                .frame(height: 100)
                
            }
            
            setupRowActionSection()
        }
        .offset(y: keyboard)
        return setupNavItems(forForm: form.eraseToAnyView())
            .sheet(isPresented: self.$shown) {
                ImagePicker(isShown: self.$shown, image: self.$image)}
        
    }
}
extension ContactForm {
    
    func updateOffsetY(keyboardWillShow: Bool) {
        withAnimation {
            self.keyboard = keyboardWillShow ? -200 : 0
        }
    }
}
struct _Previews: PreviewProvider {
    static var previews: some View {
    ContactForm(image: .constant(UIImage().placeholderImage),
    firstName: .constant("Robert"),
    lastName: .constant("Pacheco"), phone: .constant("8052486563"), order: .constant("1"), email: .constant("none@none.com"), notes: .constant("First App made with SwiftUI and CoreData. It's coming along pretty good!"), dateAdded: .constant(Date()))
    }
}
