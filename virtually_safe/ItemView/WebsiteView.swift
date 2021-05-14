//
//  WebsiteView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI

struct WebsiteView: View {
    @State var favorite = false
    @State var seepw = false
    @State var name = "name"
    @State var url = "url"
    @State var username = "username"
    @State var password = "password"
    @State var notes = "haha"
    
    let board = UIPasteboard.general
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Website Name").foregroundColor(.gray).font(.headline)
                            Text(name)
                        }
                        Spacer()
                        Button(action: {
                            if (name != ""){
                                board.string = name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("URL").foregroundColor(.gray).font(.headline)
                            Text(url)
                        }
                        Spacer()
                        Button(action: {
                            if (url != ""){
                                board.string = url
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Username").foregroundColor(.gray).font(.headline)
                            Text(username)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (username != ""){
                                board.string = username
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Password").foregroundColor(.gray).font(.headline)
                            if seepw == false {
                                Text(hide(hid: password))
                            } else {
                                Text(password)
                            }
                        }
                        Spacer()
                        Button(action: { togglePw() }, label: {
                            if seepw == false{
                                Image(systemName: "eye").foregroundColor(.blue)
                                    .frame(width: 35, height: 30, alignment: .center)
                            } else {
                                Image(systemName: "eye.fill").foregroundColor(.blue)
                            }
                        })
                        Button(action: {
                            if (password != ""){
                                board.string = password
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    Text(notes)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            Spacer()
            NavigationLink(destination: WebsiteViewEdit()){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50)
            //Spacer()
            Divider()
            HStack{
                NavigationLink(destination: WebsiteView()){
                    Image(systemName: "key.fill").resizable().frame(width: 20, height: 30)
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
                Divider()
                NavigationLink(destination: GeneratePasswordView()){
                    Image(systemName: "lock.rotation").resizable().frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
                Divider()
                Image(systemName: "person.crop.circle").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
            }.frame(width: 350, height: 40, alignment: .center)
        }.navigationBarTitle("Password", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: { toggleFav()}, label: {
                    if favorite == false {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }).padding(.trailing, 20)
            }
        }
    }
    
    func toggleFav(){
        if favorite == false {
            favorite = true
        } else {
            favorite = false
        }
    }
    
    func togglePw(){
        if seepw == false {
            seepw = true
        } else {
            seepw = false
        }
    }
    
    func hide(hid: String) -> String{
        var x = ""
        for _ in hid {
            x = x+"*"
        }
        return x
    }
}

struct WebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteView()
    }
}
