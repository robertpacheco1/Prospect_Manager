//
//  AddNewTaskButtonView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/11/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct AddNewTaskButtonView: View {
    var body: some View {
        Text("Add Task")
            .bold()
            .foregroundColor(.white)
            .font(.system(size: 17))
    }
}

struct AddNewTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskButtonView()
        .padding(8)
        .background(Color("dark"))
        .cornerRadius(12)
    }
}
