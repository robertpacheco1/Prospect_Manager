//
//  SearchBar.swift
//  Pac
//
//  Created by Robert Pacheco on 12/20/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var predicate: NSPredicate?
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var predicate: NSPredicate?
        
        init(text: Binding<String>, predicate: Binding<NSPredicate?>) {
            
            _text = text
            _predicate = predicate
            
        }
        
        // UISearchBarDelegate
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            text = searchText
            predicate = NSPredicate(format: "firstName contains[c] %@", searchText)
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, predicate: $predicate)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .words
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = false
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}



struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBar(text: .constant("search"), predicate: .constant(NSPredicate() ))
    }
}

