//
//  MainButton.swift
//  Pac
//
//  Created by Robert Pacheco on 2/28/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct MainButton: View {
    
    @Binding var open: Bool
    @Binding var addTask: Bool
    @Binding var showingAttributeAddView: Bool

    var body: some View {
        ZStack {
            Button(action: {
                self.open.toggle()
            }) {
                Image(systemName: "plus")
                    .rotationEffect(.degrees(open ? 45 : 0))
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .bold))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
                }
            .padding()
            .background(DarkBackground(isHighlighted: open, shape: Circle()))
            .mask(Circle())
            .shadow(color: Color.offWhite, radius: 10)
        .zIndex(10)
            SecondButton(open: $open, icon: "calendar.badge.plus", offsetX: -60, offsetY: 60, delay: 0.2, action: $addTask)
            
            SecondButton(open: $open, icon: "gauge.badge.plus", offsetX: -90, delay: 0.4, action: $showingAttributeAddView)
            
            
        }
    }
}


struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(open: .constant(true),
                   addTask: .constant(true),
                   showingAttributeAddView: .constant(true))
    }
}
