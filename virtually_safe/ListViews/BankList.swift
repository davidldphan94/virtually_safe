//
//  BankList.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct BankList: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = BankViewModel()
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    @State var searching = false
    @State var searchText = ""
    
    var body: some View {
        SearchBar(searchText: $searchText, searching: $searching)
        List {
            ForEach((model.bank_info).filter({ "\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) {
                bank in NavigationLink (destination: BankView(bank: bank)) {
                    Text(bank.name)
        }
        }.onDelete(perform: deleteRow)
    }.onAppear { model.fetchData()}
    .navigationTitle("Bank Information")
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
}
    
    func deleteRow(at offsets: IndexSet) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser!
        let name = model.bank_info[offsets.first!].name
        db.collection("users").document(user.uid)
            .collection("banks").document(name).delete()
        model.bank_info.remove(atOffsets: offsets)
    }
}

struct BankList_Previews: PreviewProvider {
    static var previews: some View {
        BankList()
    }
}
