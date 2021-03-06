//
//  CCList.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CCList: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = CCViewModel()
    @State var addWebsite = true
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    @State var searching = false
    @State var searchText = ""
    @State var favorite = false
    
    let user = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
    var body: some View {
        SearchBar(searchText: $searchText, searching: $searching).padding()
        
            List {
                ForEach((model.credit_cards).filter({ "\($0)".contains(searchText) || searchText.isEmpty}), id: \.self) {
                    credit_card in
                    /*
                    HStack{
                        HStack{
                            HStack{}
                            Button(action: { toggleFav()}, label: {
                                if favorite == false {
                                    Image(systemName: "star")
                                } else {
                                    Image(systemName: "star.fill")
                                }
                            }).padding(.trailing, 20)
                            
                        }*/
                        HStack{
                            NavigationLink (destination: CCView(credit_card: credit_card)) {
                            
                                HStack{
                                    Text(credit_card.name)
                                }
                                .onAppear{
                                    if favorite == false {
                                        db.collection("users").document(user.uid).collection("credit_card").document(credit_card.name).updateData(["fav": false])
                                    } else {
                                        db.collection("users").document(user.uid).collection("credit_card").document(credit_card.name).updateData(["fav": true])
                                    }
                                }
                            }
                            
                        }
                    //}
                   
                    
                }.onDelete(perform: deleteRow)
            }.onAppear { model.fetchData()}
        .navigationTitle("Credit Cards")
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
    
    func toggleFav(){
        if favorite == false {
            favorite = true
        } else {
            favorite = false
        }
    }
    
    func deleteRow(at offsets: IndexSet) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser!
        let card_name = model.credit_cards[offsets.first!].name
        db.collection("users").document(user.uid)
            .collection("credit_cards").document(card_name).delete()
        model.credit_cards.remove(atOffsets: offsets)
    }
}

//struct CCList_Previews: PreviewProvider {
//    static var previews: some View {
//        CCList()
//    }
//}
