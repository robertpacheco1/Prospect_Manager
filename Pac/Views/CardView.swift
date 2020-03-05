//
//  CardView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/13/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var person: Person
    @State private var editPerson: Bool = false
    
    
    var body: some View {
        VStack {
            VStack {
                
                HStack(spacing: 5){
                    Text(person.firstName).bold()
                    Text(person.lastName).bold()
                }
                .font(.title)
                .foregroundColor(Color.primary)
                .lineLimit(nil)
                .padding(.top, 5)
            
                Image(uiImage: person.image ?? UIImage().placeholderImage)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 246, height: 200, alignment: .center)
                    .clipped()

                HStack {
                    Icon(icon: "phone.fill.arrow.up.right", size: 25, color: Color("green"), bkColor: Color("offWhite"))
                        .onTapGesture {
                            let tel = "tel://"
                            let formattedString = tel + self.person.cellPhone
                            let url = URL(string: formattedString)!
                            UIApplication.shared.open(url)
                    }
                    Spacer()
                    if self.person.selected {
                        Icon(icon: "rosette", size: 25, color: Color("b3"), bkColor: Color("offWhite"))
                        
                    } else {
                        Icon(icon: "rosette", size: 25, color: Color("gray"), bkColor: Color("offWhite"))
                    }
                }.shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 10)
                    .padding([.leading, .trailing, .bottom], 20)
            }
           .background(Color("offWhite"))
            .cornerRadius(25)
            .frame(width: 246, height: 360)
            .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.editPerson.toggle()
            }
            .sheet(isPresented: self.$editPerson) {
                NavigationView {
                    ContactEditView(person: self.person)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(person: Person.preview())
    }
}
