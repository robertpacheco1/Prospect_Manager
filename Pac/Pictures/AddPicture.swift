//
//  AddPicture.swift
//  Pac
//
//  Created by Robert Pacheco on 2/22/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct AddPicture: View {
    @ObservedObject private var dataSource = CoreDataDataSource<Pictures>()
    @State private var showingItemAddView: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack(spacing: 25) {
                    ActivateButton(activates: self.$showingItemAddView) {
                        Image(systemName: "plus.square.fill").resizable().frame(width: 25, height: 25)
                    }
                }
                .foregroundColor(Color("b3"))
                .padding([.leading, .trailing], 20)
                .padding([.bottom, .top], 5)
                .background(Rounded().fill(Color("dark")))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(dataSource.fetchedObjects, id: \.self) { p in
                            NavigationLink(destination: PicDetail(pic: p)) {
                            PicCellView(img: p)
                            }
                        }
                    }
                }
                HiddenNavigationLink(destination: PicAddView(), isActive: self.$showingItemAddView)

            }
            
        }
    }
}

struct AddPicture_Previews: PreviewProvider {
    static var previews: some View {
        AddPicture()
    }
}
