//
//  RingGraph.swift
//  Pac
//
//  Created by Robert Pacheco on 12/25/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ToolbarButton: View {
    var icon = "bubble.left"
    var isSelected = false
    var isPlus = false
    var action: (()->()) = {}
    
    var body: some View {
        let selectedColor = "b3"
        
        return Button(action: {
            self.action()
        }) {
            HStack {
                Image(systemName: self.icon)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(isPlus ? Color.white : isSelected ? Color(selectedColor) : Color.gray)
            }.padding(10)
                .background(isPlus ? Color("green") : isSelected ? Color(selectedColor).opacity(0.2) : Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
    
}

struct ToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarButton()
    }
}
