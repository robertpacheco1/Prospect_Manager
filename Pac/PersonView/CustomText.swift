//
//  CardButton.swift
//  Pac
//
//  Created by Robert Pacheco on 12/19/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String = "Robert"
    var text2: String = "Pacheco"
    var size: CGFloat = 20
    var body: some View {
        HStack(spacing: 5) {
            Text(text)
            Text(text2)
        }.font(.custom("Ayuthaya", size: size))
    }
}

struct CustomTitle: View {
    var text: String = "Robert"
    var text2: String = "Pacheco"
    var size: CGFloat = 20
    var body: some View {
        HStack(spacing: 5) {
            Text(text)
            Text(text2)
        }.font(.custom("Bradley Hand", size: size))
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomText()
            CustomTitle()
        }.padding()
        //        .preferredColorScheme(.dark)
    }
}
