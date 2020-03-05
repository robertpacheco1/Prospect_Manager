//
//  PicDetail.swift
//  Pac
//
//  Created by Robert Pacheco on 2/22/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PicDetail: View {
    var pic: Pictures
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: pic.image ?? UIImage().vehicleImage)
                .renderingMode(.original)
                .resizable()
            .frame(width: screen.size.width, height: screen.size.height/2, alignment: .center)

        }
    }
}

struct PicDetail_Previews: PreviewProvider {
    static var previews: some View {
        PicDetail(pic: Pictures.preview())
    }
}
