//
//  AddItemView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/16/21.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewpass = false
    @State var viewcc = false
    @State var viewbank = false
    @State var viewdriver = false
    
    var body: some View {
        VStack(alignment: .leading){
            Divider()
            VStack(alignment: .leading){
                HStack{
                    NavigationLink(destination: WebsiteViewEdit(), isActive: $viewpass){ EmptyView() }
                    Button(action: {viewpass = true}){
                        Image(systemName: "folder.badge.person.crop")
                            .foregroundColor(.gray)
                    }
                    Text("Password")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack{
                    NavigationLink(destination: CCViewEdit(), isActive: $viewcc){ EmptyView() }
                    Button(action: {viewcc = true}){
                        Image(systemName: "creditcard")
                            .foregroundColor(.gray)
                    }
                    Text("Credit/Debit Card")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack{
                    NavigationLink(destination: BankViewEdit(), isActive: $viewbank){ EmptyView() }
                    Button(action: {viewbank = true}){
                        Image(systemName: "banknote")
                            .foregroundColor(.gray)
                    }
                    Text("Bank")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
        
            VStack(alignment: .leading){
                Divider()
                HStack{
                    NavigationLink(destination: DriverView(), isActive: $viewdriver){ EmptyView() }
                    Button(action: {viewdriver = true}){
                        Image(systemName: "car")
                            .foregroundColor(.gray)
                    }
                    Text("Driver's License")
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
                HStack{
                    Image(systemName: "camera.viewfinder")
                    Text("Add Photo")
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
