//
//  WebsiteList.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct WebsiteList: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = WebsiteViewModel()
    @State var addWebsite = true
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    
    var body: some View {
            List {
                ForEach(model.websites, id: \.self) {
                    website in NavigationLink (destination: WebsiteView(website: website)) {
                    Text(website.name)
                }
                }.onDelete(perform: deleteRow)
            }.onAppear { model.fetchData()}
        .navigationTitle("Passwords")
        .toolbar{
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
        //.navigationBarBackButtonHidden(true)
        //.navigationBarHidden(true)
            /*
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                HStack{
                    Image(systemName: "chevron.backward").font(.system(size: 25))
                    Text("Back")
                }
            })*/
        
        
        
            
        
    }
    func deleteRow(at offsets: IndexSet) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser!
        let website_name = model.websites[offsets.first!].name
        db.collection("users").document(user.uid)
            .collection("websites").document(website_name).delete()
        model.websites.remove(atOffsets: offsets)
    }
}

struct WebsiteList_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteList()
    }
}
