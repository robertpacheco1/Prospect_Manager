//
//  ColorfulBackground.swift
//  Pac
//
//  Created by Robert Pacheco on 2/26/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    var body: some View {
        
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4)
                        .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                        .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
                )
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4)
                        .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                        .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                )
            }
        }
    }
}

struct ColorfulBackground_Previews: PreviewProvider {
    static var previews: some View {
        ColorfulBackground(isHighlighted: true, shape: Circle())
    }
}
