//
//  ProfileView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @ObservedObject var userModel = UserProfileViewModel()
    @ObservedObject var imageLoader = ImageLoader()
    @State var download_image:UIImage?
    @State var viewedit = false
    @State var first_name = ""
    @State var last_name = ""
    @State var location = ""
    @State var birthday = ""
    @State var url = ""
    @State var editProf = true
    
    let storage = Storage.storage().reference()
    
    var body: some View {
        VStack{
            Text("Your Profile")
                .font(.title)
                .bold()
                .padding(.bottom, 25)
            HStack{
                if download_image != nil {
                    /*
                    Image(uiImage: download_image!)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 200, height: 200)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(.top, 30)*/
                    
                    
                } else {
                    Image(systemName: "person.crop.circle").resizable().frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                }
            }.onAppear{
                storage.child("profileImage.jpeg").downloadURL {(url, error) in
                    if error != nil {
                        print("Error displaying image")
                    } else {
                        //download_image = UIImage(url: url!)
                        self.url = "\(url!)"
                        print(self.url)
                        var profileImgURL: URL {
                            return URL(string: self.url)!
                        }
                        self.imageLoader.load(with: profileImgURL)
                    }
                }
            }
            .padding(.bottom, 50)
            
            VStack {
                Divider()
                /*
                HStack {
                    Text("Username")
                    Spacer()
                    Text(userModel.profile?.email ?? "Email")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()*/
                HStack {
                    Text("First name")
                    
                    Spacer()
                    Text(userModel.profile["first_name"] ?? "firstname")
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack {
                    Text("Last name")
                    Spacer()
                    Text(userModel.profile["last_name"] ?? "lastname")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack {
                    Text("State")
                    Spacer()
                    Text(userModel.profile["location"] ?? "location")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack {
                    Text("Date of Birth")
                    Spacer()
                    Text(userModel.profile["birthday"] ?? "bday")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.onAppear {
            self.userModel.fetchData(userID: Auth.auth().currentUser!.uid)
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                NavigationLink(destination: CreateProfileView(editProf: editProf), isActive: $viewedit){ EmptyView() }
                Button(action: {viewedit = true}){
                    Text("Edit").padding(.trailing, 20)
                }
            }
        }
    }
}

struct Loader:UIViewRepresentable{
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
    
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
