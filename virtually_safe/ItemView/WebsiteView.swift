//
//  WebsiteView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct WebsiteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var website : Website
    @State var favorite = false
    @State var seepw = false
    
    let user = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
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
                .onAppear{
                    if website.fav == true {
                        favorite = true
                    }
                }
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
        //.navigationBarHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
            }
        })
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: { toggleFav()}, label: {
                    if favorite == false {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }).padding(.trailing, 20)
                .onAppear{
                    if favorite == false {
                        db.collection("users").document(user.uid).collection("websites").document(website.name).updateData(["fav": false])
                    } else {
                        db.collection("users").document(user.uid).collection("websites").document(website.name).updateData(["fav": true])
                    }
                }
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
