//
//  TaskFormView.swift
//  Pac
//
//  Created by Robert Pacheco on 2/11/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct TaskFormView: View, MultiPurposeForm {
    var onCreate: (() -> Void)?
    
    var onUpdate: (() -> Void)?
    
    var onCancel: (() -> Void)?
    
    var enableCreate: Bool?
    
    var enableUpdate: Bool?
    
    
    @Binding var taskName: String
    @Binding var dueDate: Date
    @Binding var dateCompleted: Date
    @Binding var show: Bool
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        return min...max
    }
    
    var alert: Alert {
        Alert(title: Text("Please enter the Task name"), message: Text("Next Task to Do"), dismissButton: .default(Text("OK")))
    }
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
    }
    
    var rowActions: [MultiPurposeFormRowAction] = []
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        let form = Form {
            Section(header: Text.topSection("Task")) {
                VerticalTextField(text: $taskName, label: "Task", placeholder: "Task")
                
            }
            Section(header:
                Text("Task Details")
                    .foregroundColor(Color("orange")),
                    footer: Text("Completed date: \(dateCompleted)")
                   
            ) {
                
                DatePicker(
                    selection: $dueDate,
                    in: dateClosedRange) {
                        
                        HStack {
                            Image(systemName: "calendar")
                            Text("Due Date")
                        }
                }
                .datePickerStyle(DefaultDatePickerStyle())
                
                HStack {
                    
                    Text("Status").bold()
                    Spacer()
                    if self.show {
                        Text("Completed")
                    } else {
                        Text("incomplete")
                    }
                }.font(.headline)
            }
            setupRowActionSection()
        }
        return setupNavItems(forForm: form.eraseToAnyView())
    }
}

struct TaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        
        TaskFormView(taskName: .constant("Call Customer"),
                     dueDate: .constant(Date()),
                     dateCompleted: .constant(Date()),
                     show: .constant(false)
        )
        
    }
}

extension TaskFormView {
    
    func updateOffsetY(keyboardWillShow: Bool) {
        withAnimation {
            self.offsetY = keyboardWillShow ? -200 : 0
        }
    }
}
//VStack(alignment: .leading) {
//    MultiTextField(txt: self.$taskName, placeholderText: "To Do")
//        .padding()
//        .frame(height: 120)
//
//
//    HStack {
//        Text("Due Date:")
//            .padding(.leading, 5)
//            .foregroundColor(Color("orange"))
//        Text("\(dueDate, formatter: DateFormatter.shortTime)")
//            .padding()
//            .foregroundColor(Color("green"))
//    }
//    DatePicker(
//        selection: $dueDate,
//        in: dateClosedRange,
//        label: {Text("")})
//        .datePickerStyle(DefaultDatePickerStyle())
//
//}
//.padding(.leading, 5)
//.background(Color("dark"))
//    .cornerRadius(15)
