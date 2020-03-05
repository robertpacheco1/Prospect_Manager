//
//  PicAddView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/22/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct PicAddView: View {
    @State private var image: UIImage?
    @State private var show: Bool = false
    @State private var date: Date = Date()
    @State private var order: String = ""
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: image ?? UIImage().placeholderImage).renderingMode(.original)
            .resizable()
                .frame(width: screen.size.width, height: screen.size.height/2, alignment: .center)
                .onTapGesture {
                    self.show.toggle()
            }
            Text("Added Date: \(date, formatter: DateFormatter.shortTime)")
                .font(.headline)
                .foregroundColor(.pink)
        }
    .padding()
        .navigationBarItems(leading: Button(action: {
            _ = Pictures.addImage(image: self.image ?? UIImage().placeholderImage,
                                  dateAdded: self.date, order: Int(self.order))
        }) {
            Text("Save")
        })
        .sheet(isPresented: self.$show) {
            ImagePicker(isShown: self.$show, image: self.$image)
        }
    }
}

struct PicAddView_Previews: PreviewProvider {
    static var previews: some View {
        PicAddView()
    }
}
