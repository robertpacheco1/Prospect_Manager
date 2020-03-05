//
//  TabView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/31/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var selected : Int
    
    var body: some View {
        HStack {
            
            Button(action: {
                self.selected = 3
            }) {
                Image(systemName: self.selected == 3 ? "flowchart.fill": "flowchart")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.foregroundColor(self.selected == 3 ? Color("b3"): Color("gray"))
            
            Spacer(minLength: 10)
            
            Button(action: {
                self.selected = 1
            }) {
                Image(systemName:self.selected == 1 ? "magnifyingglass.circle": "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.foregroundColor(self.selected == 1 ? Color("b3") : Color("gray"))
            
            Spacer().frame(width: 120)
            
            Button(action: {
                self.selected = 2
            }) {
                Image(systemName: self.selected == 2 ? "person.crop.circle": "person.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.foregroundColor(self.selected == 2 ? Color("b3") : Color("gray"))
                .offset(x: -10)
            
            Spacer(minLength: 12)
            
            Button(action: {
                self.selected = 4
            }) {
                
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .foregroundColor(self.selected == 4 ? Color("b3") : Color("gray"))
        }

    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selected: .constant(1))
    }
}
