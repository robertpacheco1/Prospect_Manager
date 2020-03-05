//
//  DealCellView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct DealCellView: View {
    
    var year: String
    var make: String
    var model: String
    var order: Int32
    
    var body: some View {
        HStack(spacing: 5) {
            
            Text(self.year)
            Text(self.make)
            Text(self.model)
            
            Spacer()
            
        }
        .padding(10)
        .padding(.trailing, 40)
        .padding(.leading, 5)
        .font(.headline)
        .foregroundColor(.white)
        .background(Color("dark"))
        .cornerRadius(25)
        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("b3"), lineWidth: 1))
    }
}


struct DealCellView_Previews: PreviewProvider {
    static var previews: some View {
        DealCellView(year: "2020", make: "Infiniti", model: "Q50", order: 0)
    }
}
