//
//  EditSaveDoneButton.swift
//  Pac
//
//  Created by Robert Pacheco on 12/17/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct EditSaveDoneButton : View {
    
    var editAction: () -> Void
    var saveAction: () -> Void
    var doneAction: () -> Void
    var dirty: Bool
   
    
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        
        Button(action: {
            if self.editMode?.wrappedValue == .inactive {
                self.editMode?.wrappedValue = .active
                self.editAction()
            } else {
                self.editMode?.wrappedValue = .inactive
                if self.dirty {
                    self.saveAction()
                } else {
                    self.doneAction()
                }
            }
        }, label: {
            if self.editMode?.wrappedValue == .inactive {
                Text("Edit").foregroundColor(Color("c4"))
            } else {
                if self.dirty {
                    Text("Save").foregroundColor(Color("green"))
                } else {
                    Text("Done").foregroundColor(Color("green"))
                }
            }
        })
            
    }
    
}

#if DEBUG
struct EditSaveButton_Previews : PreviewProvider {
    static var previews: some View {
        
        EditSaveDoneButton(editAction: { },
                           saveAction: { },
                           doneAction: { },
                           dirty: true)
    }
}
#endif
