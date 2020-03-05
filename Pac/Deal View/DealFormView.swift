//
//  DealFormView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DealFormView: View {
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
        
        VStack {
            ScrollView {
            HStack {
                Text(firstName)
                Text(lastName)
                Spacer()
                Text("#: \(order)")
            }
            .font(.subheadline)
            .foregroundColor(Color("b3"))
            Image(uiImage: photo ?? UIImage().vehicleImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Rounded())
                .frame(minWidth: 300, maxWidth: 400, minHeight: 300, maxHeight: 400)
                VStack {
                    if self.popup {
                        
                        Text("Sold Date: \(self.soldDate, formatter: DateFormatter.shortDate)")
                            .onTapGesture {
                                self.shownDate.toggle()
                        }
                        if self.shownDate {
                            DatePicker("Date Sold:",
                                       selection: self.$soldDate,
                                       displayedComponents: .date)
                                .datePickerStyle(DefaultDatePickerStyle())
                        }
                        
                        VStack {
                            Picker("Condition", selection: self.$type) {
                                Text("New").tag("New")
                                Text("Used").tag("Used")
                            }
                            .accentColor(Color("b3"))
                            .background(Color("gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("b3"), lineWidth: 4))
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        HStack {
                            CustomTextField(bindingvalue: self.$year, placeholder: Text("Year"))
                                .keyboardType(.numberPad)
                            CustomTextField(bindingvalue: self.$make, placeholder: Text("Make"))
                        }
                        HStack {
                            CustomTextField(bindingvalue: self.$model, placeholder: Text("Model"))
                            CustomTextField(bindingvalue: self.$trim, placeholder: Text("Trim"))
                        }
                    } else {
                        HStack {
                            Text("Sold Date: \(self.soldDate, formatter: DateFormatter.shortDate)")
                            Spacer()
                            Text("Condition: \(self.type)")
                        }
                        HStack {
                            Text(self.year)
                            Text(self.make.uppercased())
                            
                            Text(self.model.uppercased())
                            Text(self.trim.uppercased())
                        }.font(.headline)
                    }
                }.padding()
                    .foregroundColor(Color(.white))
                    .background(Color("dark"))
                    .clipShape(Round())
            }
            
            GeometryReader { g in
                
                ZStack {
                    if self.popup {
                        PlusMenuView(add: self.$shown,
                                     delete: self.$photo,
                                     icon: "plus",
                                     icon2: "minus")
                            .offset(y: -g.size.height/12)
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("dark"))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("b3"))
                                .rotationEffect(Angle(radians: self.popup ? 20 : 0))
                        }
                        .offset(y: -g.size.height/10/2)
                        .onTapGesture {
                            withAnimation {
                                self.popup.toggle()
                            }
                        }
                    }
//                    .frame(width: g.size.width, height: g.size.height/20/2)
                   
                    .frame(width: g.size.width, height: g.size.height/10)
                }
            }
                   
            Spacer()
        }
        .sheet(isPresented: self.$shown) { ImagePicker(isShown: self.$shown, image: self.$photo)}
        .onTapGesture {
            self.endEditing(true)
        }
        
    }
}

struct DealFormView_Previews: PreviewProvider {
    static var previews: some View {
        
        Form {
            DealFormView(photo: .constant(UIImage().placeholderImage),
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
}
