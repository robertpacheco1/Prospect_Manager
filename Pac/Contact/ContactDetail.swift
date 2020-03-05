//
//  Tab1.swift
//  Pac
//
//  Created by Robert Pacheco on 1/2/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ContactDetail: View {
    @Binding var image: UIImage?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    @Binding var order : String
    @Binding var email: String
    @Binding var notes: String
    @Binding var dateAdded: Date
//    @Binding var editMode: EditMode
    @State private var shown: Bool = false
    @State private var popup: Bool = false
    @State private var addTask: Bool = false
    @State private var datePicker = false
    @State private var keyboard: CGFloat = 0.0
    var body: some View {
        GeometryReader { g in
            VStack {
                Spacer()
                HStack {
                    Text("\(self.dateAdded, formatter: DateFormatter.shortDate)")
                    Spacer()
                    Text("ID #: \(self.order)")
                }
                .foregroundColor(.white)
                .padding()
                .background(Rounded().fill(Color("dark")))
                
                Image(uiImage: self.image ?? UIImage().placeholderImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: g.size.width, alignment: .center)
                VStack {
                    HStack {
                        Text(self.firstName.uppercased()).bold()
                        Text(self.lastName.uppercased()).bold()
                    }
                    .font(.title)
                    .foregroundColor(.primary)
                    
                    HStack(spacing: 50) {
                        Icon(icon: "phone.fill.arrow.up.right", size: 25, color: Color("green"), bkColor: Color("c3"))
                        
                        Divider().frame(height: 50)
                        
                        Icon(icon: "envelope", size: 25, color: Color("green"), bkColor: Color("c3"))
                    }
                    .shadow(color: Color("button"), radius: 10, x: 0, y: 10)
                    
                    
                    HStack {
                        VStack(alignment: .leading,spacing: 30) {
                            Text("phone: ")
                            Text("email: ")
                        }
                        .foregroundColor(Color("b3"))
                        VStack(alignment: .leading,spacing: 30) {
                            Text(self.phone)
                            Text(self.email)
                        }
                        
                        
                    }
                    .foregroundColor(Color("c3"))
                    
                    VStack(alignment: .leading) {
                        Text("Notes")
                            .foregroundColor(Color("b3"))
                        Divider()
                        Text(self.notes)
                        
                    }
                    .padding()
                }
            }
        }
    }
}


struct ContactDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetail(image: .constant(UIImage().placeholderImage),
        firstName: .constant("Robert"),
        lastName: .constant("Pacheco"),
        phone: .constant("8052486563"),
        order: .constant("1"),
        email: .constant("robertpacheco@teamnissandirect.com"),
        notes: .constant("First App made with SwiftUI and CoreData. It's coming along pretty good!"),
        dateAdded: .constant(Date()))
//        editMode: .constant(.active))
    }
}
