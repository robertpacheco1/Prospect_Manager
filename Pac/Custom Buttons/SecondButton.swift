//
//  SecondButton.swift
//  Pac
//
//  Created by Robert Pacheco on 2/28/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct SecondButton: View {
    
    @Binding var open: Bool
    var icon = "pencil"
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    @Binding var action: Bool
    
    var body: some View {
        Button(action: {
            self.action.toggle()
        }) {
            Image(systemName: icon)
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .bold))
        }
    .padding()
            .background(DarkBackground(isHighlighted: action, shape: Circle()))
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY): 0)
        .scaleEffect(open ? 1: 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }
    
}
struct SecondButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondButton(open: .constant(true), action: .constant(true))
    }
}
