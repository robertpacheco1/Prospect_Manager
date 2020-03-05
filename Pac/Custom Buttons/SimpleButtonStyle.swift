//
//  SimpleButtonStyle.swift
//  Pac
//
//  Created by Robert Pacheco on 2/26/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.offWhite)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                        )
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                        )
                        
                    } else {
                        Circle()
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)
                        
                    }
                }
        )
    }
}

struct SimpleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {
            
        }) {
            Image(systemName: "trash")
        }.buttonStyle(SimpleButtonStyle())
    }
}
