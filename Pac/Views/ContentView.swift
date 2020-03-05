//
//  ContentView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var selection = 0

    var body : some View {
        VStack {
            if self.selection == 0 {
                HomeView()
            } else if self.selection == 1 {
                SearchView()
            } else if self.selection == 2 {
                Tasks()
            } else if self.selection == 3 {
               InteractiveView()
            } else if self.selection == 4 {
                PersonListView()
            }
            Spacer()
            ZStack(alignment: .top) {
                CustomTabView(selected: self.$selection)
                    .padding()
                    .padding(.horizontal,22)
                    .background(CurvedShape())
                
                Button(action: {
                    self.selection = 0
                }) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.selection == 0 ? Color("b3") : Color("gray"))
                        .padding(14)
                }
                .background(Color("dark"))
                .clipShape(Circle())
                .offset(y: -25)
                .shadow(radius: 5)
                
            }
        }.background(Color("b3").edgesIgnoringSafeArea(.top))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .preferredColorScheme(.dark)
    }
}
