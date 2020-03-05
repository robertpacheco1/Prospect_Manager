//
//  Text.swift
//  Pac
//
//  Created by Robert Pacheco on 2/28/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

extension Text {
    
    /// Text for `Section`'s header with top padding. The default is 20.
    /// - Parameter text: Header text.
    /// - Parameter padding: Top padding.
    static func topSection(_ text: String, padding: CGFloat? = nil) -> some View {
        Text(text).padding(.top, padding ?? 20)
    }
    
    /// A contact info view display an image and the info text.
    /// - Parameter image: Image represent the info.
    /// - Parameter text: Info text.
    static func contactInfo(image: Image, text: String) -> some View {
        guard !text.isEmpty else { return AnyView.emptyView }
        return HStack {
            image
            Text(text)
        }
        .eraseToAnyView()
    }
}
