//
//  PersonListView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI
import CoreData


struct PersonListView: View {
    
    @State private var editMode: EditMode = .inactive
    
    @ObservedObject private var dataSource = CoreDataDataSource<Person>()
    
    @State private var sortAscending: Bool = true
    @State private var showingItemAddView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 25) {
                    ActivateButton(activates: self.$showingItemAddView) {
                        Image(systemName: "plus.square.fill").resizable().frame(width: 25, height: 25)
                    }
                    Divider().frame( height: 25)
                    EditButton()
                }
                .foregroundColor(Color("b3"))
                .padding([.leading, .trailing], 20)
                .padding([.bottom, .top], 5)
                .background(Rounded().fill(Color("dark")))
                List() {
                    Section(header:
                        HStack {
                            Text("All Contacts")
                            Spacer()
                            Image(systemName: (sortAscending ? "arrow.down" : "arrow.up"))
                                .foregroundColor(Color("b3"))
                                .onTapGesture(perform: self.onToggleSort )
                    }) {
                        ForEach(dataSource.fetchedObjects) { person in
                            if self.editMode == .active {
                                PersonCellView(person: person)
                            } else {
                                NavigationLink(destination: PersonEditView(person: person)) {
                                    PersonCellView(person: person)
                                }
                            }
                        }
                            .onMove(perform: (self.sortAscending ? self.dataSource.move : nil))    // Move only allowed if ascending sort
                            .onDelete(perform: self.dataSource.delete)
                    }
                }
                HiddenNavigationLink(destination: PersonAddView(), isActive: self.$showingItemAddView)
            }
            .onAppear(perform: { self.onAppear()})
        .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Clients"), displayMode: .inline)
            .environment(\.editMode, self.$editMode)
        }
    }
    public func onAppear() {
        self.dataSource.loadDataSource()
    }
    public func onToggleSort() {
        
        self.sortAscending.toggle()
        self.dataSource.changeSort(key: "order", ascending: self.sortAscending)
    }
}
struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView()
            .preferredColorScheme(.dark)
    }
}
