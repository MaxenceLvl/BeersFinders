//
//  ImagePicker.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 08/04/2022.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var isPresented
    @Binding var data: ImageData?

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()

        picker.delegate = context.coordinator
        picker.sourceType = .camera
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // not needed
    }


}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView

    init(picker: ImagePickerView) {
        self.picker = picker
    }


    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // Should be improve by using PHPicker
        guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }


        guard let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp\(UUID()).png") else {
            return
        }

        let pngData = uiImage.jpegData(compressionQuality: 1.0)
        try? pngData?.write(to: imageURL)

        self.picker.data = ImageData(path: imageURL.path)
        self.picker.isPresented.wrappedValue.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

