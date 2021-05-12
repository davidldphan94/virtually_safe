//
//  imageSelect.swift
//  MovieListApp
//
//  Created by David Phan on 4/25/21.
//

import Foundation
import SwiftUI

struct imageSelect: UIViewControllerRepresentable {
    @Binding var img: UIImage?
    @Binding var showImgSelect: Bool
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = imageSelectCoordinator
    
    var sourceType:UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imageSelect>) -> UIImagePickerController {
        let myImage = UIImagePickerController()
        myImage.sourceType = sourceType
        myImage.delegate = context.coordinator
        return myImage
    }
    
    func makeCoordinator() -> imageSelect.Coordinator {
        return imageSelectCoordinator(image: $img, showImageSelect: $showImgSelect)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:
                                    UIViewControllerRepresentableContext<imageSelect>) {}
    
}

class imageSelectCoordinator: NSObject, UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
    @Binding var image: UIImage?
    @Binding var showImageSelect: Bool
    
    init(image:Binding<UIImage?>, showImageSelect: Binding<Bool>) {
        _image = image
        _showImageSelect = showImageSelect
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                                info: [UIImagePickerController.InfoKey: Any]) {
        if let uiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiimage
            showImageSelect = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showImageSelect = false
    }
}
