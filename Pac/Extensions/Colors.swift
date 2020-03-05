//
//  Colors.swift
//  Pac
//
//  Created by Robert Pacheco on 12/25/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

extension Color {
    static var ring1color1: Color {
        return Color("ring1color1")
    }
    static var ring1color2: Color {
        return Color("ring1color2")
    }
    static var ring2color1: Color {
        return Color("ring2color1")
    }
    static var ring2color2: Color {
        return Color("ring2color2")
    }
    static var ring3color1: Color {
        return Color("ring3color1")
    }
    static var ring3color2: Color {
        return Color("ring3color2")
    }
    
    static var offWhite : Color {
        return(Color("offWhite"))
    }
    
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    
    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}


extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors),
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing)
    }
}
