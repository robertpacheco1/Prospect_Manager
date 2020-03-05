//
//  HomeList.swift
//  Pac
//
//  Created by Robert Pacheco on 2/13/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeList: View {
    
    @ObservedObject  var dataSource = CoreDataDataSource<Person>()
    
    var body: some View {
        
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Clients").font(.largeTitle).fontWeight(.heavy)
                        Text("Recently Added").foregroundColor(Color("b3"))
                       
                    }
                    Spacer()
                }
                .padding(.top, 78)
                .padding(.leading, 60)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(dataSource.fetchedObjects) { person in
                            GeometryReader { geometry in
                                CardView(person: person)
                                    .rotation3DEffect(Angle(degrees: Double(
                                        (geometry.frame(in: .global).minX - 30) / -30
                                    )), axis: (x: 0, y: 10, z: 0))
                            }.frame(width: 246, height: 360)
                        }
                    }.padding(30)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: 480)
                
                Tasks()
                
                PictureListView()

                Spacer()
                
               
            }
            .onAppear(perform: { self.onAppear()})
         
    }
    public func onAppear() {
        self.dataSource.loadDataSource()
    }

    
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}

//.sorted(by: { $0.createdDate > $1.createdDate})
