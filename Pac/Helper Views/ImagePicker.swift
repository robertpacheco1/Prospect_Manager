//
//  ImagePicker.swift
//  Pac
//
//  Created by Robert Pacheco on 1/7/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
       Coordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isShown: Bool
        @Binding var image: UIImage?
        
        init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
            _isShown = isShown
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            image = uiImage
            isShown = false
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(
            isShown: .constant(false),
            image: .constant(UIImage().placeholderImage)
        )
    }
}
