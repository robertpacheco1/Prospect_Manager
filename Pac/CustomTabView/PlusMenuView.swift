//
//  PlusMenuView.swift
//  Pac
//
//  Created by Robert Pacheco on 1/2/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PlusMenuView: View {
    @Binding var add: Bool
    @Binding var delete: UIImage?
    var icon = ""
    var icon2 = ""
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(Color("green"))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("b3"))
            }
            .onTapGesture {
                self.add.toggle()
            }
            
            ZStack {
                Circle()
                    .foregroundColor(Color("green"))
                    .frame(width: 40, height: 40)
                Image(systemName: icon2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("orange"))
                
            }.onTapGesture {
                self.delete = nil
            }
        }.transition(.scale)
    }
}

struct PlusMenuView_Previews: PreviewProvider {
    static var previews: some View {
        PlusMenuView(add: .constant(false), delete: .constant(UIImage().placeholderImage), icon: "plus", icon2: "minus")
    }
}
