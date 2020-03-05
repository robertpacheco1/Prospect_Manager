//
//  Ring.swift
//  Pac
//
//  Created by Robert Pacheco on 12/25/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CreateNewContactView: View {
    @Binding var movingOffset: CGFloat
    let screenSize = UIScreen.main.bounds.size
    @State private var textTitle = ""
    
    var body: some View {
        let screenWidth = screenSize.width
        let phoneRatio = String(format: "%.3f", screenSize.width / screenSize.height)
        let refRatio = String(format: "%.3f", 9.0 / 16.0)
        let isXorAbove = phoneRatio != refRatio
        
        return VStack(spacing: 25) {
            Rectangle()
                .frame(width: 80, height: 7)
                .cornerRadius(5)
                .foregroundColor(Color.gray.opacity(0.5))
            Text("Create New Contact")
            
            VStack {
                TextField("Type Name", text: self.$textTitle)
                    .multilineTextAlignment(.center)
                Divider().padding(.horizontal, 50)
            }
            
            VStack(spacing: 15) {
                WikiButton(icon: "plus", color: "green", text: "Create New Contact", isFolder: true, action: { print("adding new folder")})
                
                WikiButton(icon: "folder.fill.badge.plus", color: "orange", text: "Create New Folder", isFolder: true, action: { print("adding new folder")})
            }
            
            Text("+Only Visible to you, if you want you can share with others later")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: screenWidth * 0.8)
                .foregroundColor(Color.gray)
        }.padding(.bottom, isXorAbove ? 60: 50)
            .padding(.top, 15).offset(y: movingOffset)
    }
    
}

struct CreateNewContactView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewContactView(movingOffset: .constant(0.0))
    }
}
