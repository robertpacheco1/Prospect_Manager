//
//  TaskEditView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/11/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct TaskEditView: View {
    
    var task: ToDo
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var taskName: String = ""
    @State var selectedDate = Date()
    @State var completedDate = Date()
    @State var showSheet: Bool = false
    @State var selectedTask: ToDo? = nil
    @State var isComplete = false
    var presentSheet: ActionSheet {
        ActionSheet(title: Text("Todo Actions"),
                    message: nil,
                    buttons: [
                        CompleteButton,
                        Incomplete,
                        NotifyButton,
                        ActionSheet.Button.cancel({
                            self.showSheet.toggle()
                        })])
    }
    var NotifyButton: ActionSheet.Button {
        ActionSheet.Button.default(Text("Save")) {
            self.save()
            self.showSheet.toggle()
        }
    }
    var Incomplete: ActionSheet.Button {
        ActionSheet.Button.default(Text("Incomplete")) {
            self.task.isComplete = false
            self.showSheet.toggle()
        }
    }
    var CompleteButton: ActionSheet.Button {
        ActionSheet.Button.default(Text("Mark Complete")) {
            self.task.isComplete = true
            self.completedDate = Date()
            self.showSheet.toggle()
        }
    }
    var body: some View {
        ZStack {
            VStack {
                
                TaskFormView(taskName: self.$taskName, dueDate: self.$selectedDate, dateCompleted: self.$completedDate, show: self.$isComplete)
                
            }
            Button(action: {
                self.selectedTask = self.task
                self.showSheet = true
            }) {
                Image(systemName: "slider.horizontal.3").imageScale(.large)
            }.buttonStyle(SimpleButtonStyle())
            
            
            
        }
        .onAppear(perform: {self.onAppear()})
        .actionSheet(isPresented: self.$showSheet, content: {
            presentSheet
        })
    }
    func onAppear() {
        
        self.taskName = self.task.title 
        self.selectedDate = self.task.due
        self.isComplete = self.task.isComplete
        self.completedDate = Date()
        
        
    }
    func save() {
        task.updateTask(title: self.taskName, isComplete: self.task.isComplete)
        self.cancelAction()
    }
    func cancelAction() {
        self.taskName = ""
        self.selectedDate = Date()
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskEditView(task: ToDo.preview(),
                         selectedDate: Date.currentYMDHM,
                         showSheet: false)
        }
    }
}
