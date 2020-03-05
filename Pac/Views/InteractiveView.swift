//
//  InteractiveView.swift
//  Pac
//
//  Created by Robert Pacheco on 3/4/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct InteractiveView: View {
    
    @State private var currentHeight: CGFloat = 0.0
    @State private var movingOffset: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            MainCard()
                            MainCard(icon: "lock.fill", color: "green", text: "Working")
                        }
                        HStack(spacing: 20) {
                            MainCard(icon: "bookmark.fill", color: "c3", text: "Sold Clients")
                            MainCard(icon: "bookmark.fill", color: "c3", text: "Lost Clients")
                        }
                    }

                        HomeList()
                }.padding(.horizontal)
                    .padding(.bottom, 30)
                    .navigationBarTitle("Contacts")
                    .navigationBarItems(leading:
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chart.bar").resizable().modifier(NavIconStyle())
                        }, trailing:   Button(action: {
                            
                        }) {
                            Image(systemName: "chart.pie").resizable().modifier(NavIconStyle())
                    })
            }
            CustomSheetView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset)
        }
    }
}

struct InteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveView()
    }
}
