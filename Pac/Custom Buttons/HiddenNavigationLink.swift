//
//  HiddenNavigationLink.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct HiddenNavigationLink<Destination : View>: View {
    
    var destination:  Destination
    var isActive: Binding<Bool>
    
    var body: some View {
        
        NavigationLink(destination: self.destination, isActive: self.isActive)
        { EmptyView() }
            .frame(width: 0, height: 0)
            .disabled(true)
            .hidden()
    }
}

struct HiddenNavigationLink_Previews: PreviewProvider {
    
    static var previews: some View {
        HiddenNavigationLink(destination: EmptyView(), isActive: .constant(true))
    }
}
