//
//  MultiLineTextField.swift
//  Pac
//
//  Created by Robert Pacheco on 1/3/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct MultiLineTextField: View {
    
    @State private var text = "green"
    var body: some View {
        VStack {
            MultiTextField(txt: self.$text)
                .padding(5)
            .frame(minHeight: 50, maxHeight: 200)
                .background(Color("c6"))
                .cornerRadius(10)
        }.padding()
    }
}

struct MultiLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineTextField()
            .preferredColorScheme(.dark)
    }
}


struct MultiTextField: UIViewRepresentable {
    
    @Binding var txt: String
    var placeholderText: String = "Write..."
    
    func makeCoordinator() -> MultiTextField.Coordinator {
        return Coordinator(self)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let textView = UITextView()
        
        textView.textContainer.lineFragmentPadding = 10
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 16)
        
        textView.text = placeholderText
        textView.textColor = .placeholderText
        
        return textView
    }
    
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        if txt != "" || uiView.textColor == .label {
            uiView.text = txt
            uiView.textColor = .systemTeal
            
        }
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 16).lineHeight * numLines
        return self.frame(height: height)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent : MultiTextField
        
        init(_ parent: MultiTextField) {
            self.parent = parent
        }
                
        func textViewDidChange(_ textView: UITextView) {
            parent.txt = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
                
            }

        }
    }
}

