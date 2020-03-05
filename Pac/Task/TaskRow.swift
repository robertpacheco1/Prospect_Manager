//
//  TaskRow.swift
//  Pac
//
//  Created by Robert Pacheco on 2/12/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    @State var todo: ToDo
    @State var todayDate: Date
    
    var body: some View {
        return VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(todo.title)
                    .bold()
                    .foregroundColor(todo.isComplete ? Color("green"): Color("b3"))
                Text("\(todo.due, formatter: DateFormatter.shortTime)")
                    .bold()
                    .foregroundColor(todo.isComplete ? Color("c4") : Color("b3"))
                Divider()
                HStack(alignment: .bottom) {
                    
                    Image(systemName: "phone.arrow.up.right")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(5)
                        .foregroundColor(Color("green"))
                        .background(Color("dark")).cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("green"), lineWidth: 2))
                        .onTapGesture {
                            let tel = "tel://"
                            let formattedString = tel + self.todo.person.cellPhone
                            let url = URL(string: formattedString)!
                            UIApplication.shared.open(url)
                    }
                    Spacer()
                    Image(systemName: todo.isComplete ? "checkmark.seal.fill" : "xmark.seal.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(todo.isComplete ? Color("c4"): Color("c2"))
                        .padding(5)
                        .background(Color("dark")).cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke((todo.isComplete ? Color("c4"): Color("c2")), lineWidth: 2))
                       
                }
                .shadow(color: Color("gray").opacity(0.8), radius: 10, x: 0, y: 1)
            }
            .padding()
            .font(.system(size: 17))
            .lineLimit(nil)
        }
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("green"), lineWidth: 1))
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(todo: ToDo.preview(), todayDate: Date.distantFuture)
    }
}
