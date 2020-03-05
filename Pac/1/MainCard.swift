//
//  DEalView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/19/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct  MainCard: View {
    
    var icon = "book.fill"
    var color = "b3"
    var text = "All Contacts"
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: icon).foregroundColor(Color.white)
                Text(text).foregroundColor(Color.white)
            }.padding()
                .frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                .background(Color(color))
                .cornerRadius(15)
            
            HStack {
                Spacer()
                Image(systemName: icon).resizable()
                    .foregroundColor(Color.white.opacity(0.3))
                .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fit)
            }.padding()
        }.shadow(color: Color(color), radius: 10, x: 0, y: 5)
    }
}
struct MainCard_Previews: PreviewProvider {
    static var previews: some View {
        MainCard()
    }
}


