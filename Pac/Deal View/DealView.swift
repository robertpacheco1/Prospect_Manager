//
//  DealView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/15/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DealView: View {
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
        
        GeometryReader { g in
            ZStack {
                
            Rectangle()
                .fill(RadialGradient(gradient: Gradient(colors: [Color("b3"), Color("dark"), ]), center: .center, startRadius: 5, endRadius: 320))
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        CustomTitle(text: self.firstName, text2: self.lastName, size: 40)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .frame(height: 70)
                        Text("ID#: \(self.order)")
                         .padding(.top, 0)
                    }
                    .foregroundColor(.white)

                    Image(uiImage: self.photo ?? UIImage().vehicleImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 400)
                    Spacer()
                }
                .padding(.top, 40)
                
                ScrollView {
                    CardBottom(soldDate: self.$soldDate,
                               year: self.$year,
                               make: self.$make,
                               model: self.$model,
                               trim: self.$trim,
                               order: self.$order,
                               edit: self.$popup,
                               photo: self.$photo,
                               type: self.$type)
                        .background(Color.white)
                        .cornerRadius(30)
                        .frame(width: g.size.width, height: g.size.height)
                        .padding(.top, 400)
                }
                .frame(width: g.size.width)
            }
        }
    }
}

struct DealView_Previews: PreviewProvider {
    static var previews: some View {
        DealView(photo: .constant(UIImage().placeholderImage),
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

struct CardBottom : View {
    @Binding var soldDate: Date
    @Binding var year: String
    @Binding var make: String
    @Binding var model: String
    @Binding var trim: String
    @Binding var order: String
    @Binding var edit: Bool
    @Binding var photo: UIImage?
    @Binding var type: String
    @State private var shown: Bool = false
    @State private var shownDate: Bool = false
    @State private var keyboard: CGFloat = 0

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 60, height: 6)
                .cornerRadius(3.0)
                .opacity(0.1)
                .padding(.top, 16)
            VStack {
                if self.edit {
                    PlusMenuView(add: self.$shown,
                                 delete: self.$photo,
                                 icon: "plus",
                                 icon2: "minus")
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
                            .rotationEffect(Angle(radians: self.edit ? 20 : 0))
                    }
                    .onTapGesture {
                        withAnimation {
                            self.edit.toggle()
                        }
                    }
                }
                    if edit == true {
                            DatePicker("Date Sold:",
                                       selection: self.$soldDate,
                                       displayedComponents: .date)
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
                        Text("Sold Date: \(self.soldDate, formatter: DateFormatter.shortDate)")
                            .font(.headline)
                        
                        Divider()
                        HStack {
                            CustomText(text: self.year, text2: self.make, size: 30)
                            CustomText(text: self.model, text2: self.trim, size: 30)
                        }

                }

                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
   
        }
        .background(BlurView(style: .regular))
        .cornerRadius(30)
        .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 0)
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
        .sheet(isPresented: self.$shown) { ImagePicker(isShown: self.$shown, image: self.$photo)}
               .onTapGesture {
                   self.endEditing(true)
               }
    }
}
