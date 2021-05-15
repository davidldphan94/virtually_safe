//
//  CreateProfileView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct CreateProfileView: View {
    //let user = Auth.auth().currentUser
    @State var showActionSheet = false
    @State var showImages = false
    @State private var emptyAlert = false
    //@State var imageUploaded = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @ObservedObject var profileModel = UserProfileViewModel()
    
    @State var upload_image:UIImage?
    @State var first_name = ""
    @State var lName = ""
    @State var state = ""
    @State var editProf = false
    
    let storage = Storage.storage()
    //let storageRef = storage.reference()
    //let imageRef = storageRef.child("profileImage.jpeg")
    
    var ref: DatabaseReference!
    //ref = Database.database().reference()
   
    var alert: Alert {
        Alert(title: Text("Field(s) Empty"),
              message: Text("Please make sure something is written in the First Name, Last Name, or State fields."))
    }
    
    var body: some View {
        //Image(uiImage: UIImage(named: "person.crop.circle")!)
        /*
        if editProf == false{
            VStack{
                if upload_image != nil {
                    Image(uiImage: upload_image!)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        //.scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(.top, 30)
                    /*
                    if let thisImage = self.upload_image{
                        uploadImage(image: self.upload_image)
                    }
                    */
                    
                } else {
                    Image(systemName: "person.crop.circle").resizable().frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                        //.padding(.bottom, 50)
                }
                
                Button(action: {
                    self.showActionSheet = true
                    //uploadNow()
                }) {
                    Text("Add Profile Image")
                }.actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Add a picture to your profile"), message: nil,
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
                } /*
                .sheet(isPresented: $showImages){
         imageSelect(image: self.$upload_image, showImagePicker: self.$showImages, sourceType: self.sourceType)
                }
                .padding(.bottom, 50)
                */
                //uploadNow()
                    
                HStack{
                    Text("Please enter your first name: ")
                        .padding(.leading, 20)
                        //.foregroundColor(.gray)
                    Spacer()
                }
                /*
                TextField(profileModel.profile?.fName ?? "First Name", text: $fName)
                    .font(.system(size: 20))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                
                HStack{
                    Text("Please enter your last name: ")
                        .padding(.leading, 20)
                        //.foregroundColor(.gray)
                    Spacer()
                }
                
                TextField(profileModel.profile?.lName ?? "Last Name", text: $lName)
                    .font(.system(size: 20))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                
                HStack{
                    Text("Please enter the name of your State: ")
                        .padding(.leading, 20)
                        //.foregroundColor(.gray)
                    Spacer()
                }
                
                TextField(profileModel.profile?.state ?? "State", text: $state)
                    .font(.system(size: 20))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                */
                if (fName == "" || lName == "" || state == "") {
                    //emptyAlert = true
                    Button (action: { empty() }){
                    Text("Continue")
                    }.alert(isPresented: $emptyAlert,
                           content: { self.alert })
                    .frame(width:100, height: 30, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    Spacer()
                } else {
                    VStack{
                        NavigationLink(destination: WebsiteView().navigationBarHidden(true)) {
                            Text("Continue")
                                //.bold()
                                .frame(width:100, height: 30, alignment: .center)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                //.navigationBarHidden(true)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            uploadProfile()
                            if let thisImage = self.upload_image {
                                uploadImage(image: thisImage)
                            } else {
                                print("No image present")
                            }
                        })
                        Spacer()
                    }
                }
                
                Spacer()
            }.onAppear()
            .navigationBarHidden(true)
        }
        else {*/
            if upload_image != nil {
                Image(uiImage: upload_image!)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    //.scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(.top, 30)
                /*
                if let thisImage = self.upload_image{
                    uploadImage(image: self.upload_image)
                }
                */
                
            } else {
                Image(systemName: "person.crop.circle").resizable().frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                    //.padding(.bottom, 50)
            }
            
            Button(action: {
                self.showActionSheet = true
                //uploadNow()
            }) {
                Text("Edit Profile Image")
            }.actionSheet(isPresented: $showActionSheet){
                ActionSheet(title: Text("Add a picture to your profile"), message: nil,
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
                imageSelect(img: self.$upload_image, showImgSelect: self.$showImages, sourceType: self.sourceType)
            }
            .padding(.bottom, 50)
            
            //uploadNow()
                
            HStack{
                Text("Please enter your first name: ")
                    .padding(.leading, 20)
                    //.foregroundColor(.gray)
                Spacer()
            }
            
            TextField(profileModel.profile?.first_name ?? "First Name", text: $first_name)
                .font(.system(size: 20))
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 30)
            /*
            HStack{
                Text("Please enter your last name: ")
                    .padding(.leading, 20)
                    //.foregroundColor(.gray)
                Spacer()
            }
            
            TextField(profileModel.profile?.lName ?? "Last Name", text: $lName)
                .font(.system(size: 20))
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 30)
            
            HStack{
                Text("Please enter the name of your State: ")
                    .padding(.leading, 20)
                    //.foregroundColor(.gray)
                Spacer()
            }
            
            TextField(profileModel.profile?.state ?? "State", text: $state)
                .font(.system(size: 20))
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 30)
            */
            
            VStack{
                NavigationLink(destination: ListView().navigationBarHidden(true)) {
                    Text("Continue")
                        //.bold()
                        .frame(width:100, height: 30, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        //.navigationBarHidden(true)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    uploadProfile()
                    if let thisImage = self.upload_image {
                        uploadImage(image: thisImage)
                    } else {
                        print("No image present")
                    }
                })
                Spacer()
            }
            
            
            Spacer()
        //}
        
    
    }

    func empty() {
        emptyAlert = true
    }
    func uploadProfile(){
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser!
        db.collection("users").document(String(user.uid)).setData([
            "Username": String(user.email ?? ""),
            "FirstName": first_name,
            "LastName": lName,
            "State": state
        ])
    }
}

func uploadImage(image: UIImage){
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage = Storage.storage()
        storage.reference().child("profileImage.jpeg").putData(imageData, metadata: nil){
            (_, err) in
            if let err = err {
                print("Error occurred")
            } else {
                print("Upload successful")
            }
        }
    } else {
        print("Couldn't unwrap image to data")
    }
}


struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}
