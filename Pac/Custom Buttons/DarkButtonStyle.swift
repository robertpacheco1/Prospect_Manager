//
//  DarkButtonStyle.swift
//  Pac
//
//  Created by Robert Pacheco on 2/26/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DarkButtonStyle: ButtonStyle {
       func makeBody(configuration: Self.Configuration) -> some View {
         configuration.label
             .padding()
             .contentShape(Circle())
             .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
        )
            .animation(.default)
    }
}

struct DarkButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
       Button(action: {
            
        }) {
            Image(systemName: "trash")
       }
       .buttonStyle(DarkButtonStyle())
    }
}
