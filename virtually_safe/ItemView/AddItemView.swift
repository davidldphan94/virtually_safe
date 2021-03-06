//
//  AddItemView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/16/21.
//

import SwiftUI
import Firebase

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showActionSheet = false
    @State var showImages = false
    @State var viewpass = false
    @State var viewcc = false
    @State var viewbank = false
    @State var viewdriver = false
    @State var viewphoto = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var upload_image:UIImage?
    
    let storage = Storage.storage()
    
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "folder.badge.person.crop")
                        .foregroundColor(.black).padding(.trailing, 10)
                    NavigationLink(destination: WebsiteViewEdit(), isActive: $viewpass){ EmptyView() }
                    Button(action: {viewpass = true}){
                        Text("Password")
                    }
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack{
                    Image(systemName: "creditcard")
                        .foregroundColor(.black).padding(.trailing, 10)
                    NavigationLink(destination: CCViewEdit(), isActive: $viewcc){ EmptyView() }
                    Button(action: {viewcc = true}){
                        Text("Credit/Debit Card")
                    }
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack{
                    Image(systemName: "banknote")
                        .foregroundColor(.black).padding(.trailing, 10)
                    NavigationLink(destination: BankViewEdit(), isActive: $viewbank){ EmptyView() }
                    Button(action: {viewbank = true}){
                        Text("Bank")
                    }
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
        
            VStack(alignment: .leading){
                Divider()
                HStack{
                    Image(systemName: "car")
                        .foregroundColor(.black).padding(.trailing, 10)
                    NavigationLink(destination: DriverViewEdit(), isActive: $viewdriver){ EmptyView() }
                    Button(action: {viewdriver = true}){
                        Text("Driver's License")
                    }
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack{
                    Image(systemName: "camera.viewfinder")
                        .foregroundColor(.black).padding(.trailing, 12)
                    NavigationLink(destination: PhotoView(), isActive: $viewphoto){ EmptyView() }
                    Button(action: {viewphoto = true}){
                        Text("Add Photo")
                    }
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }.padding(.top, 40)
            Spacer()
            
        }.padding(.top, 50)
        .navigationBarTitle("Add Item", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Text("Cancel")
            }
        })
        
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
