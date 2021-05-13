//
//  WebsiteViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/12/21.
//

import SwiftUI

struct WebsiteViewEdit: View {
    @State var name = ""
    @State var url = ""
    @State var username = ""
    @State var password = ""
    @State var notes = ""
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Spacer()
                Text("Password")
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                Spacer()
                /*
                NavigationLink(destination: someView()){
                Text("Edit")
                }
                .padding(.trailing, 20)
                */
                Text("Save")
                    .padding(.trailing, 20)
            }.padding(.bottom, 30)
            
            ScrollView{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Website Name").foregroundColor(.gray).font(.headline)
                    TextField("name", text: $name)
                    Divider()
                    Text("URL").foregroundColor(.gray).font(.headline)
                    TextField("url", text: $url)
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    TextField("username", text: $username)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    TextField("password", text: $password)
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField("notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
            }
            
            Spacer()
            Divider()
            HStack{
                Image(systemName: "key.fill").resizable().frame(width: 20, height: 30)
                    .foregroundColor(.black)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                Divider()
                Image(systemName: "lock.rotation").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                Divider()
                Image(systemName: "person.crop.circle").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
            }.frame(width: 350, height: 40, alignment: .center)
        }
    }
}

struct WebsiteViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteViewEdit()
    }
}
