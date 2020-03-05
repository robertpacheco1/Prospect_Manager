//
//  MenuButton.swift
//  Pac
//
//  Created by Robert Pacheco on 2/19/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct MenuButton : View {
    @Binding var show: Bool
    var body: some View {
         VStack {
            HStack {
                Button(action: { self.show.toggle() }) {
                    HStack {
                        Spacer()
                        Image("menu")
                            .foregroundColor(.primary)
                    }.padding(17)
                }
                .frame(width: 90, height: 56)
                .background(Color("button"))
                .cornerRadius(30)
                .shadow(color: Color("buttonShadow"), radius: 10, y: 10)
                .offset(x: -42, y: 82)
                Spacer()
            }
            Spacer()
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(show: .constant(true))
    }
}
