//
//  MenuRight.swift
//  Pac
//
//  Created by Robert Pacheco on 2/13/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct MenuRight: View {
    @State var add: Bool = false
    
    var body: some View {
          VStack {
            HStack(spacing: 12) {
                Spacer()
                Button(action: {
                    self.add.toggle()
                }){
                    Image(systemName: "plus.app")
                        .frame(width: 44, height: 44)
                        .background(Color("button"))
                        .foregroundColor(.primary)
                        .cornerRadius(22)
                        .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
                        .sheet(isPresented: $add) {
                            NavigationView{
                                PersonAddView()
                            }
                    }
                }
            }
            .padding().offset(y: 70)
            Spacer()
        }
    }
}

struct MenuRight_Previews: PreviewProvider {
    static var previews: some View {
        MenuRight()
    }
}
