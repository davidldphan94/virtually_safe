//
//  PhotoView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/16/21.
//

import SwiftUI
import Firebase

struct PhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    let storage = Storage.storage().reference()
    
    @State var showActionSheet = false
    @State var showImages = false
    @State var showAlert = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var downloadImg: UIImage?
    @State var uploadImg: UIImage?
    @State var filename = ""
    @State var errTitle = ""
    @State var errMsg = ""
    
    @State var count = 1
    
    var alert : Alert {
        Alert(title: Text(errTitle),
              message: Text(errMsg))
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                
                VStack{
                    Text("Enter a file name").foregroundColor(.gray).font(.headline)
                    Divider()
                    TextField("File name", text: $filename)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                if uploadImg != nil {
                    Image(uiImage: uploadImg!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .padding(.top, 30)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                }
                Spacer()
                
            }.padding(.top, 50)
            .onAppear{
                self.showActionSheet = true
            }
            .actionSheet(isPresented: $showActionSheet){
                ActionSheet(title: Text("Add a photo"), message: nil,
                            buttons: [
                                .default(Text("Camera"), action: {
                                    self.showImages = true
                                    self.sourceType = .camera
                                }),
                                .default(Text("Photo Library"), action: {
                                    self.showImages = true
                                    self.sourceType = .photoLibrary
                                }),
                                .cancel()
                            ])
            }
            .sheet(isPresented: $showImages){
                imageSelect(img: self.$uploadImg, showImgSelect: self.$showImages, sourceType: self.sourceType)
            }
            .onAppear {
                storage.child("myImage").getData(maxSize: 10 * 1024 * 1024) {
                    (imgData, err) in
                    if err != nil {
                            print("Error downloading image")
                    } else {
                        if let imgData = imgData {
                            self.downloadImg = UIImage(data: imgData)
                        } else {
                            print("Couldn't unwrap image")
                        }
                    }
                }
            }
            VStack {
                Button (action: {showActionSheet=true}){
                Text("Select Photo")
                }
                .frame(width:150, height: 50, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                Spacer()
            }.padding()
        }.navigationBarTitle("Add Photo", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button (action: {
                    if filename == "" {
                        errTitle = "Field empty"
                        errMsg = "Please enter a name for the file"
                    } else {
                        uploadImage(image: self.uploadImg!)
                        errTitle = "Success"
                        errMsg = "Photo uploaded successfully"
                        
                        filename = ""
                        uploadImg = nil
                    }
                    showAlert = true
                }){
                Text("Save")
                }
            }
        }
        .alert(isPresented: $showAlert) {self.alert}
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Text("Cancel")
            }
        })
    }
    
    func uploadImage(image: UIImage){
        if let imageData = image.jpegData(compressionQuality: 1){
            storage.child("\(filename).jpeg").putData(imageData, metadata: nil) {
                (_, err) in
                if err != nil {
                    print("Error occurred")
                } else {
                    print("Upload successful")
                    //count += 1
                }
            }
        } else {
            print("Couldn't unwrap image to data")
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
