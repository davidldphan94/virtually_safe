//
//  WebsiteViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct WebsiteViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewgenpw = false
    @State var viewsettings = false
    @State var showAlert = false
    @State var errTitle = ""
    @State var errmsg = ""
    @State var name = ""
    @State var url = ""
    @State var username = ""
    @State var password = ""
    @State var notes = ""
    
    let dbRef = Firestore.firestore()
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
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
                Divider()
            }
            
            Spacer()
            Divider()
        }.navigationBarTitle("Password", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    submitWebsite()
                }) {
                    Text("Save")
                        .padding(.trailing, 20)
                }.padding(.trailing, 20)
            }
        }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text(errTitle), message: Text(errmsg))})
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
        if name == "" || url == "" ||
            username == "" || password == "" {
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
            
        } else {
            let w = Website(id: .init(), name: name, url: url, username: username, password: password, notes: notes)
//            let user = Auth.auth().currentUser
            dbRef.collection("Users").document("Temp") //user.uid)
                 .collection("Items").document("websites")
                 .setData(w.dictionary, merge: true)
            name = ""
            url = ""
            username = ""
            password = ""
            notes = ""
            errTitle = "Success"
            errmsg = "Website login info submitted"
        }
        showAlert = true
    }
}

struct WebsiteViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteViewEdit()
    }
}
