//
//  NotrientModifier.swift
//  Pac
//
//  Created by Robert Pacheco on 12/25/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct NutrientModifier: ViewModifier {
    var color : Color = .red
    func body (content: Content) -> some View {
        content.foregroundColor(color)
            .frame(width: 25, height: 25)
        .cornerRadius(4)
    }
}
