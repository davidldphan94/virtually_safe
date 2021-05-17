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
    @State var searching = false
    @State var searchText = ""
    
    var body: some View {
        SearchBar(searchText: $searchText, searching: $searching)
        
            List {
                ForEach((model.websites).filter({ "\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) {
                    website in NavigationLink (destination: WebsiteView(website: website)) {
                    Text(website.name)
                }
                }.onDelete(perform: deleteRow)
            }.onAppear { model.fetchData()}
        .navigationTitle("Websites")
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar){
                Spacer()
                HStack{
                    NavigationLink(destination: ListView(), isActive: $viewvault){ EmptyView() }
                    Button(action: {viewvault = true}){
                        Image(systemName: "key.fill").resizable().frame(width: 20, height: 30)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                HStack{
                    NavigationLink(destination: GeneratePasswordView(), isActive: $viewgenpw){ EmptyView() }
                    Button(action: {viewgenpw = true}){
                        Image(systemName: "lock.rotation").resizable().frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                HStack{
                    NavigationLink(destination: SettingsView(), isActive: $viewsettings){ EmptyView() }
                    Button(action: {viewsettings = true}){
                        Image(systemName: "gearshape.fill").resizable().frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    }
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
