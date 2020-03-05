//
//  Icon.swift
//  Pac
//
//  Created by Robert Pacheco on 1/24/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct Icon: View {
    
    var icon = "phone.arrow.up.right"
    var size: CGFloat = 25
    var color: Color = Color("green")
    var bkColor: Color = Color("dark")
    var body: some View {
        
        ZStack {
            Circle()
            .foregroundColor(bkColor)
            .frame(width: size * 2, height: size * 2)
            Image(systemName: icon)
            .resizable()
                .frame(width: size, height: size, alignment: .center)
            .foregroundColor(color)
        }
        .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)

    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        Icon()
    }
}


