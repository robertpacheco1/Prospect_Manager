//
//  DarkBackground.swift
//  Pac
//
//  Created by Robert Pacheco on 2/26/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DarkBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4)
                        .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                        .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
                )
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: 4)
                        .shadow(color: Color.darkStart, radius: 10, x: -5, y: -5)
                        .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                )
            }
        }
    }
}

struct DarkBackground_Previews: PreviewProvider {
    static var previews: some View {
        DarkBackground(isHighlighted: false, shape: Circle())
    }
}
