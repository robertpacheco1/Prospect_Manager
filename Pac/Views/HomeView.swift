//
//  HomeView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/13/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var add = false
    @State var viewState = CGSize.zero
    @State var show = false
    @State var menu: [Menu] = menuData
    var body: some View {
        ZStack {
            HomeList()
                .blur(radius: show ? 50 : 0)
                .animation(.default)
                .blur(radius: add ? 20-viewState.height/10 : 0)
            
            ZStack {
                Spacer()
            }
            .background(Color.black)
            .opacity(add ? Double(35-viewState.height/5)/100 : 0)
            .animation(.default)
            
            MenuButton(show: $show)
            .blur(radius: add ? 5-viewState.height/30 : 0)
            .offset(y: -viewState.height/10)
            .animation(.default)
            
            MenuRight(add: add)
                .blur(radius: add ? 6-viewState.height/30 : 0)
                .offset(y: -viewState.height/20)
                .animation(.default)

            MenuView(menu: menu)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
            .animation(.easeInOut(duration: 0.3))
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.show.toggle()
            }
            
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
