//
//  WebsiteView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI

struct WebsiteView: View {
    @State var website : Website
    @State var favorite = false
    @State var seepw = false
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    
    let board = UIPasteboard.general
    
    var body: some View {
        VStack{
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Website Name").foregroundColor(.gray).font(.headline)
                            Text(website.name)//name)
                        }
                        Spacer()
                        Button(action: {
                            if (website.name != "") {//name != ""){
                                board.string = website.name//name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("URL").foregroundColor(.gray).font(.headline)
                            Text(website.url)//url)
                        }
                        Spacer()
                        Button(action: {
                                if (website.url != "") {//url != ""){
                                board.string = website.url//url
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Username").foregroundColor(.gray).font(.headline)
                            Text(website.username)//username)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (website.username != "") {//username != ""){
                                board.string = website.username//username
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Password").foregroundColor(.gray).font(.headline)
                            if seepw == false {
                                Text(hide(hid: website.password))//password))
                            } else {
                                Text(website.password)//password)
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
                                if (website.password != "") {
                                board.string = website.password//password
                            }}) {
                            Text("Copy")
                        }
                    }
                    
                    if website.notes != "" {
                        Divider()
                        Text("Notes").foregroundColor(.gray).font(.headline)
                        Text(website.notes)
                    }
                    
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            Spacer()
            NavigationLink(destination: WebsiteViewEdit(website : website)){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50)
            
        }.navigationBarTitle("Password", displayMode: .inline)
//        .navigationBarHidden(false)
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
            ToolbarItemGroup(placement: .bottomBar){
                Spacer()
                NavigationLink(destination: ListView(), isActive: $viewvault){ EmptyView() }
                Button(action: {viewvault = true}){
                    Image(systemName: "key.fill").resizable().frame(width: 42, height: 50)
                        .foregroundColor(.black)
                }
                Spacer()
                NavigationLink(destination: GeneratePasswordView(), isActive: $viewgenpw){ EmptyView() }
                Button(action: {viewgenpw = true}){
                    Image(systemName: "lock.rotation")
                        .foregroundColor(.gray)
                }
                Spacer()
                NavigationLink(destination: SettingsView(), isActive: $viewsettings){ EmptyView() }
                Button(action: {viewsettings = true}){
                    Image(systemName: "gearshape.fill").resizable().frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                Spacer()
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

//struct WebsiteView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebsiteView()
//    }
//}
