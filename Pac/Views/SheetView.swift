//
//  SheetView.swift
//  Pac
//
//  Created by Robert Pacheco on 3/4/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

enum Position {
    case up
    case down
}

struct SheetView<Content>: View where Content: View {
    
    @Binding var currentHight: CGFloat
    @Binding var movingOffset: CGFloat
    var position = Position.up
    var smallHeight: CGFloat = 50
    var onDragedEnded: ((_ position: Position)-> ()) = {_ in }
    var content: () -> Content
    
    var body: some View {
        Group(content: self.content)
            .frame(minHeight: 0.0, maxHeight: .infinity, alignment: .bottom)
            .offset(y: self.movingOffset)
        .gesture(
            DragGesture().onChanged({ drag in
                if self.movingOffset >= 0 {
                    self.movingOffset = drag.translation.height + self.currentHight
                }
            }).onEnded({ drag in
                withAnimation(.spring( dampingFraction: 0.7)) {
                    if self.movingOffset > -50 {
                        self.movingOffset = 0.0
                        self.onDragedEnded(.up)
                    }
                    
                    if drag.translation.height > 80 {
                        self.movingOffset = self.smallHeight
                        self.onDragedEnded(.down)
                    }
                    self.currentHight = self.movingOffset
                }
            })
        ).edgesIgnoringSafeArea(.all)
        
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(currentHight: .constant(0.0), movingOffset: .constant(0.0)) {
            Rectangle().foregroundColor(Color.red).frame(height: 500)
        }
    }
}
