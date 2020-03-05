//
//  TaskRow.swift
//  Pac
//
//  Created by Robert Pacheco on 2/14/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct Tasks: View {
    
    @ObservedObject var dB = CoreDataDataSource<ToDo>()
    @State var complete: Bool = true
    
    var body: some View {
        
         VStack(alignment: .leading) {
            Text("Tasks")
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .padding(.leading, 50)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(dB.fetchedObjects.sorted(by: {$0.title > $1.title})) { task in
                        TaskRow(todo: task, todayDate: task.due)
                            .contextMenu {
                            Button(action: {
                                self.complete.toggle()
                                if self.complete {
                                    task.isComplete.toggle()
                                }
                            }){
                                HStack {
                                    if task.isComplete{
                                        Text("Incomplete")} else {
                                        Text("complete")
                                    }
                                    Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(Color("c2"))
                                        .imageScale(.large)
                                }
                            }
                        }
                    }
                }
                .padding(.leading, 30)
                .padding(.top, 10)
                
                Spacer()
            }
            .frame(height: 200)
            .onAppear(perform: {self.onAppear()})
        }
    }
    public func onAppear() {
        self.dB.loadDataSource()
        
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Tasks()
    }
}
