//
//  ContentView.swift
//  Swift-Beginners
//
//  Created by 笠井翔雲 on 2024/04/18.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var photoPickerSlectedImage: PhotosPickerItem? = nil
    var body: some View {
        VStack {
            Spacer()
            
            Button{
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    print("カメラは利用できます")
                    captureImage = nil
                    isShowSheet.toggle()
                }else{
                    print("カメラは利用できません")
                }
            }label: {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                
                    .frame(height:50)
                
                    .multilineTextAlignment(.center)
                
                    .background(Color.blue)
                
                    .foregroundColor(Color.white)
            }
            .padding()
            
            .sheet(isPresented: $isShowSheet){
                if let captureImage{
                    EffectView(isShowSheet: $isShowSheet, captureImage: captureImage)
                }else{
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }
            }
            PhotosPicker(selection: $photoPickerSlectedImage, matching: .images, preferredItemEncoding: .automatic,photoLibrary: .shared()){
                
                Text("フォトライブラリーから選択する")
                    .frame(maxWidth:.infinity)
                    .frame(height:50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .padding()
            }
            .onChange(of: photoPickerSlectedImage, initial: true, { oldValue,newValue in
                if let newValue{
                    newValue.loadTransferable(type: Data.self){result in
                        switch result{
                        case .success(let data):
                            if let data{
                                captureImage = UIImage(data: data)
                            }
                        case .failure:
                            return
                        }
                    }
                }
            })
            
        }
        .onChange(of: captureImage,initial: true,{oldValue, newValue in
            if let _ = newValue{
                isShowSheet.toggle()
            }
        })
    }
}

#Preview {
    ContentView()
}
