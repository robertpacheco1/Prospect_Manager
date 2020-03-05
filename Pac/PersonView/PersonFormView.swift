//
//  PersonFormView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PersonFormView: View {
    @ObservedObject private var keyboardObv = KeyboardObserver()
    @Binding var image: UIImage?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    @Binding var order : String
    @Binding var email: String
    @Binding var notes: String
    @Binding var dateAdded: Date
    @Binding var editMode: EditMode
    
    @State private var shown = false
    @State private var popup = false
    @State private var addTask = false
    @State private var datePicker = false
    @State private var keyboard: CGFloat = 0
    var body: some View {
        
        Section(header:
            HStack {
                
                Text("Created Date: \(dateAdded, formatter: DateFormatter.shortTime)")
                Spacer()
                CustomText(text: "ID#:", text2: self.order, size: 12)
            }
        ) {
            VStack {
                Image(uiImage: image ?? UIImage().placeholderImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rounded())
                    .frame(minWidth: 300, maxWidth: 400, minHeight: 300, maxHeight: 400)
                
                Spacer()
                if self.editMode == .active {
                    GeometryReader { g in
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
                                    Image(systemName: "pencil.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color("c4"))
                                        .rotationEffect(Angle(radians: self.popup ? 10 : 0))
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

                    }
                }
            
            }
                
            .sheet(isPresented: self.$shown) {
                ImagePicker(isShown: self.$shown, image: self.$image)}
            
            if editMode == .active {
                VStack {
                    HStack {
                        CustomTextField(bindingvalue: self.$firstName, placeholder: Text("first name"))
                        CustomTextField(bindingvalue: self.$lastName, placeholder: Text("last name"))
                    }

                    HStack {
                        CustomTextField(bindingvalue: self.$phone, placeholder: Text("phone"))
                        CustomTextField(bindingvalue: self.$order, placeholder: Text("client #"))
                    }.keyboardType(.phonePad)
                    CustomTextField(bindingvalue: self.$email, placeholder: Text("email@")).keyboardType(.emailAddress)
                    
                    
                }
                .padding(.top, 10)
                VStack(alignment: .leading) {
                    Text("Notes:").font(.footnote)
                        .foregroundColor(Color("b3"))
                    MultiTextField(txt: self.$notes, placeholderText: "Write notes here")
                        .frame(height: 100)
                        .padding(.bottom, self.keyboardObv.keyboardHeight).animation(.easeInOut(duration: 0.3))
                }
                .padding(5)
                .background(Color("dark"))
                .cornerRadius(5)
                
            } else {
                VStack {
                    HStack {
                        Spacer()
                        CustomTitle(text: self.firstName, text2: self.lastName, size: 30)
                        Spacer()
                    }
                    HStack(spacing: 20) {
                        Icon(icon: "phone.arrow.up.right", color: Color("c4"))
                            .onTapGesture {
                                let tel = "tel://"
                                let formattedString = tel + self.phone
                                let url = URL(string: formattedString)!
                                UIApplication.shared.open(url)
                        }
                        Divider()
                        
                        Icon(icon: "envelope.fill", color: Color("c4"))
                    }
                    
                    Text("phone").font(.footnote)
                        .foregroundColor(Color("b3"))
                    Text(phone)
                    Divider()
                    Text("email").font(.footnote)
                        .foregroundColor(Color("b3"))
                    Text(email)
                    
                    
                }.font(.custom("Menlo Bold", size: 16))
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Round())
                
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Notes:").italic()
                            .foregroundColor(Color("b3"))
                        Spacer()
                    }
                    Text(notes)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }.font(.custom("Noteworthy Bold", size: 15))
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Rounded())
            }
            
        }
        .foregroundColor(Color("green"))
            
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

struct PersonFormView_Previews : PreviewProvider {
    
    static var previews: some View {
        
        NavigationView {
            PersonFormView(image: .constant(UIImage().placeholderImage),
                           firstName: .constant("Robert"),
                           lastName: .constant("Pacheco"), phone: .constant("8052486563"), order: .constant("1"), email: .constant("none@none.com"), notes: .constant("First App made with SwiftUI and CoreData. It's coming along pretty good!"), dateAdded: .constant(Date()), editMode: .constant(.inactive))
            
        }.preferredColorScheme(.light)
    }
}


struct PersonFormView1: View {
    @Binding var image: UIImage?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    @Binding var order : String
    @Binding var email: String
    @Binding var notes: String
    @Binding var dateAdded: Date
    @Binding var editMode: EditMode
    @State private var shown = false
    @State private var popup = false
    @State private var addTask = false
    @State private var datePicker = false
    var body: some View {
        Group {
            if editMode == .active {
                ContactFormView(image: self.$image, firstName: self.$firstName, lastName: self.$lastName, phone: $phone, order: $order, email: $email, notes: $notes, dateAdded: $dateAdded, editMode: $editMode)
            } else {
                ContactDetail(image: self.$image, firstName: self.$firstName, lastName: self.$lastName, phone: $phone, order: $order, email: $email, notes: $notes, dateAdded: $dateAdded)
            }
        }
    }
}
