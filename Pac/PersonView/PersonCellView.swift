//
//  PersonCellView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PersonCellView: View {
    @ObservedObject var person: Person

    
    var body: some View {
        
        return HStack {
            VStack {
                HStack(spacing: 5) {
                    Image(uiImage: person.image ?? UIImage().placeholderImage)
                            .resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("b3"), lineWidth: 2))
                            .shadow(color: .secondary, radius: 2)
                    
                    CustomTitle(text: person.firstName, text2: person.lastName, size: 20)
                    Spacer()
                    Icon(icon: "phone.fill.arrow.up.right")
                        .onTapGesture {
                            let tel = "tel://"
                            let formattedString = tel + self.person.cellPhone
                            let url = URL(string: formattedString)!
                        UIApplication.shared.open(url)
                }
                    if self.person.selected {
                        Image(systemName: "checkmark")
                    }
                }
                .foregroundColor(.white)
            }
        .padding(5)
            }
        .background(Color("dark"))
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("b3"), lineWidth: 1))

    }
}

struct PersonCellView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCellView(person: Person.preview())
    }
}


