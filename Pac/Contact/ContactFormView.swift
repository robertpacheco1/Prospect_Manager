//
//  Practice.swift
//  Pac
//
//  Created by Robert Pacheco on 1/2/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ContactFormView: View {
    @Binding var image: UIImage?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    @Binding var order : String
    @Binding var email: String
    @Binding var notes: String
    @Binding var dateAdded: Date
    @Binding var editMode: EditMode
    @State private var shown: Bool = false
    @State private var popup: Bool = false
    @State private var addTask: Bool = false
    @State private var datePicker = false
    @State private var keyboard: CGFloat = 0.0

    var body: some View {
        GeometryReader { g in
            VStack {
                Image(uiImage: self.image ?? UIImage().placeholderImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: g.size.width)
                    .padding(.top, 8)
                
                ZStack {

                    if self.popup {
                        PlusMenuView(add: self.$shown,
                                     delete: self.$image,
                                     icon: "plus",
                                     icon2: "minus")
                            .offset(y: -g.size.height/12)
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("dark"))
                                .frame(width: 50, height: 50)
                            Image(systemName: "photo.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("green"))
                                .rotationEffect(Angle(radians: self.popup ? 12.6 : 0))
                        }
                        .offset(y: -g.size.height/10/2)
                        .onTapGesture {
                            if self.editMode == .active {
                                withAnimation {
                                    self.popup.toggle()
                                }
                            }
                        }
                    }
                    .frame(width: g.size.width, height: g.size.height/20/2)
                }
                
                VStack(alignment: .leading) {
                HStack {
                    Text("Created Date: \(self.dateAdded, formatter: DateFormatter.shortDate)")
                    
                    Spacer()
                    
                    Text("ID #: \(self.order)")
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(Color.white)
//                .background(Round().fill(Color("dark")))

                    Text("Full Name: ")
                        .foregroundColor(Color("c5"))
                HStack {
                    CustomTextField(bindingvalue: self.$firstName, placeholder: Text("first name"), color: Color("c8"))
                    CustomTextField(bindingvalue: self.$lastName, placeholder: Text("last name"), color: Color("c8"))
                    
                    }
                    Text("Phone & Email ")
                    .foregroundColor(Color("c5"))
                HStack {
                    CustomTextField(bindingvalue: self.$phone, placeholder: Text("phone number"), color: Color("c8"))
                    CustomTextField(bindingvalue: self.$email, placeholder: Text("@email"), color: Color("c8"))
                    
                }
                HStack {
                    Text("ID #: ")
                    .foregroundColor(Color("c5"))
                    CustomTextField(bindingvalue: self.$order, placeholder: Text("ID #:"), color: Color("c8"))
                }
                .frame(width: 120)
                    
                    Text("Notes: ")
                        .foregroundColor(Color("b3"))
                    MultiTextField(txt: self.$notes)
                    .frame(height: 100)

                }
                .padding()
            .foregroundColor(Color("c8"))
                .background(BlurView(style: .systemMaterial))
                .cornerRadius(10)
                Spacer()
                
            }
            .offset(y: -self.keyboard)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                    guard let keyboardFrame = notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                        return
                    }
                    self.keyboard = keyboardFrame.height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (notification) in
                    self.keyboard = 0
                }
            }
            }
            .onTapGesture {
                self.endEditing(true)
            }
            .sheet(isPresented: self.$shown) {
                ImagePicker(isShown: self.$shown, image: self.$image)}
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormView(image: .constant(UIImage().placeholderImage),
                        firstName: .constant("Robert"),
                        lastName: .constant("Pacheco"),
                        phone: .constant("8052486563"),
                        order: .constant("1"),
                        email: .constant("none@none.com"),
                        notes: .constant("First App made with SwiftUI and CoreData. It's coming along pretty good!"),
                        dateAdded: .constant(Date()),
                        editMode: .constant(.active)
        )
            .preferredColorScheme(.dark)
    }
}

