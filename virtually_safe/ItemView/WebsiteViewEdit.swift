//
//  WebsiteViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import RNCryptor

struct WebsiteViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var website : Website?
    
    @State var showAlert = false
    @State var errTitle = ""
    @State var errmsg = ""
    @State var name = ""
    @State var url = ""
    @State var username = ""
    @State var password = ""
    @State var notes = ""
    
    let crypto = Encryption()
    
    let dbRef = Firestore.firestore()
    let key = "mZ4!IY$o8T"
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Website Name").foregroundColor(.gray).font(.headline)
                    TextField(website?.name ?? "name", text: $name)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("URL").foregroundColor(.gray).font(.headline)
                    TextField(website?.url ?? "url", text: $url)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    TextField(website?.username ?? "username", text: $username)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    TextField(website?.password ?? "password", text: $password)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField(website?.notes ?? "notes", text: $notes)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Password", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    submitWebsite()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .padding(.trailing, 20)
                })
            }
        }
        .alert(isPresented: $showAlert) {self.alert}
        .padding(.trailing, 20)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Text("Cancel")
            }
        })
    }
    
    func submitWebsite() {
        if (website != nil) {
            name = name != "" ? name : website?.name ?? ""
            url = url != "" ? url : website?.url ?? ""
            username = username != "" ? username : website?.username ?? ""
            password = password != "" ? password : website?.password ?? ""
            notes = notes != "" ? notes : website?.notes ?? ""
        }
        if (name == "" || url == "" ||
            username == "" || password == "") {
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
            let w = Website(id: .init(), name: self.crypto.encrypt(plainTxt: name, encryptionKey: key),
                            url: self.crypto.encrypt(plainTxt: url, encryptionKey: key),
                            username: self.crypto.encrypt(plainTxt: username, encryptionKey: key),
                            password: self.crypto.encrypt(plainTxt: password, encryptionKey: key),
                            notes: self.crypto.encrypt(plainTxt: notes, encryptionKey: key))
            let user = Auth.auth().currentUser!
            if (name != website?.name ?? name) {
                dbRef.collection("users").document(user.uid).collection("websites").document(name).setData(w.dictionary, merge: true)
                dbRef.collection("users").document(user.uid).collection("websites").document(website!.name).delete()
            } else {
                dbRef.collection("users").document(user.uid).collection("websites").document(name).setData(w.dictionary, merge: true)
            }
            name = ""
            url = ""
            username = ""
            password = ""
            notes = ""
            errTitle = "Success"
            errmsg = "Review submitted. Values will be updated upon revisit."
        }
        showAlert = true
    }
    var alert : Alert {
        Alert(title: Text(errTitle),
              message: Text(errmsg))
    }
    
    func encrypt(plainTxt: String, encryptionKey: String) -> String {
            let messageData = plainTxt.data(using: .utf8)!
            let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
            return cipherData.base64EncodedString()
        }
    
}

struct WebsiteViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteViewEdit()
    }
}
