//
//  PicCellView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/22/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PicCellView: View {
    
    @ObservedObject var img: Pictures
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: img.image ?? UIImage().placeholderImage).renderingMode(.original)
                .resizable()
                .frame(width: screen.size.width, height: screen.size.height/2, alignment: .center)
            
            Text("Added Date: \(img.dateAdded, formatter: DateFormatter.shortDate)")
                .font(.subheadline)
                .foregroundColor(Color("b3"))
        }
        .padding()
    }
}

struct PicCellView_Previews: PreviewProvider {
    static var previews: some View {
        PicCellView(img: Pictures.preview())
            .preferredColorScheme(.dark)
    }
}
