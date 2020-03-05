//
//  CustomSheetView.swift
//  Pac
//
//  Created by Robert Pacheco on 1/2/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CustomSheetView : View {
    @Binding var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    
    var body: some View {
        SheetView(currentHight: self.$currentHeight, movingOffset: self.$movingOffset, smallHeight: 300, onDragedEnded: { position in
            
        }) {
            ZStack(alignment: .top) {
                CreateNewContactView(movingOffset: self.$currentHeight)
                ToolBarView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset)
            }.background(Color.white).clipShape(RoundedShape())
                .shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0.0, y: -5)
        }
    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSheetView(currentHeight: .constant(0.0), movingOffset: .constant(0.0))
    }
}
