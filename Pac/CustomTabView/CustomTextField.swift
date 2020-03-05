//
//  CustomTextField.swift
//  Pac
//
//  Created by Robert Pacheco on 1/24/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var bindingvalue: String
    var placeholder: Text
    var color: Color = .offWhite
    var body: some View {
        
        ZStack(alignment: .leading) {
            if bindingvalue.isEmpty { placeholder.foregroundColor(Color.darkStart) }
            TextField("", text: self.$bindingvalue)
                
        }
        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 2))
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(bindingvalue: .constant(""), placeholder: Text("First Name"))
    }
}
