//
//  AnyView.swift
//  Pac
//
//  Created by Robert Pacheco on 3/3/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

extension AnyView {
    
    static var emptyView: AnyView {
        AnyView(EmptyView())
    }
}


extension View {
    
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(true)}
    }
    
    /// Flat view to `AnyView`.
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func hidden(_ hidden: Bool) -> some View {
        hidden ? AnyView(EmptyView()) : AnyView(self)
    }
}
