//
//  ModalView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/15/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ModalView : View {
    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial)
            LottieView(filename: "TwitterHeart")
        }
        .frame(width: 360, height: 360)
        .cornerRadius(30)
        .shadow(radius: 30)
    }
}

#if DEBUG
struct ModalView_Previews : PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
#endif
