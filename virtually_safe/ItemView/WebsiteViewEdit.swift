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
            /*
             HStack {
                 Button(action: {
                     submitReview()
                 }) {Text("Submit Review")}.alert(isPresented: $showAlert, content: {self.alert})
             }
             */
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    submitWebsite()
                }, label: {
                    Text("Save")
                        .padding(.trailing, 20)
                }).padding(.trailing, 20)
                .alert(isPresented: $showAlert, content: {self.alert})
            }
        }
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
            showAlert = true
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
//            let r = Review(movie_title: movie.title, name: name, title: title, review_text: review)
            let w = Website(id: .init(), name: name, url: url, username: username, password: password, notes: notes)
            let _ = dbRef.collection("Users").document("something").collection("Websites").document().setData(w.dictionary, merge: true)
            name = ""
            url = ""
            username = ""
            password = ""
            errTitle = "Success"
            errmsg = "Review submitted"
            showAlert = true
            
        }
    }
    var alert : Alert {
        Alert(title: Text(errTitle),
              message: Text(errmsg))
    }
}

struct WebsiteViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteViewEdit()
    }
}
