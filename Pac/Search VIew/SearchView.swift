//
//  SearchView.swift
//  Pac
//
//  Created by Robert Pacheco on 12/20/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchPredicate: NSPredicate? = NSPredicate(format: "firstName contains[c] %@", "")
    @ObservedObject private var dataSource = CoreDataDataSource<Person>()
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(text: $searchText, predicate: $searchPredicate)
                List {
                    Section(header: Text("Deal Contains: '\(self.searchText)'")) {
                        ForEach(self.dataSource.loadDataSource(predicate: self.searchPredicate)) { person in
                            NavigationLink(destination: PersonEditView(person: person)) {
                                PersonCellView(person: person)
                            }
                        }
                    }
                }
            .listStyle(GroupedListStyle())
            }
            .navigationBarTitle(Text("Search"), displayMode: .large)
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
