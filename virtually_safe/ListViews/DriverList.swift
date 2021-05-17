//
//  DriverList.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import SwiftUI
import Firebase
import FirebaseStorage


struct DriverList: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = DriverViewModel()
    @State var addWebsite = true
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    @State var searching = false
    @State var searchText = ""
    
    var body: some View {
        SearchBar(searchText: $searchText, searching: $searching).padding()
        List {
            ForEach((model.licenses).filter({ "\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) {
                license in
                NavigationLink (destination: DriverView(license: license)) {
                    Text(license.name)
                }
            }.onDelete(perform: deleteRow)
        }.onAppear { model.fetchData()}
        .navigationTitle("Licenses")
        .toolbar{
            ToolbarItem {
                HStack {
                }
            }
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
        
    }
    func deleteRow(at offsets: IndexSet) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser!
        let delete_license = model.licenses[offsets.first!].name
        db.collection("users").document(user.uid)
            .collection("licenses").document(delete_license).delete()
        model.licenses.remove(atOffsets: offsets)
    }
}

struct DriverList_Previews: PreviewProvider {
    static var previews: some View {
        DriverList()
    }
}
