//
//  ImagePickerView.swift
//  Swift-Beginners
//
//  Created by 笠井翔雲 on 2024/04/18.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var isShowSheet:Bool
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let parent: ImagePickerView
        
        init(_ parent:ImagePickerView){
            self.parent = parent
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController, didFinishPickingMedhiaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
            
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.captureImage = originalImage
            }
            parent.isShowSheet.toggle()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet.toggle()
        }
    }
}
