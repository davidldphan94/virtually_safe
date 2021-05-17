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
    @ObservedObject var model = BankViewModel()
    @State var addWebsite = true
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    
    var body: some View {
        Text("something")
        /*
            List {
                ForEach(model.bank_info, id: \.self) {
                    bank in NavigationLink (destination: BankView(bank: bank)) {
                    Text(credit_card.name)
                }
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
        
        */
        
            
        
    }
//    func deleteRow(at offsets: IndexSet) {
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser!
//        let card_name = model.credit_cards[offsets.first!].name
//        db.collection("users").document(user.uid)
//            .collection("credit_cards").document(card_name).delete()
//        model.credit_cards.remove(atOffsets: offsets)
//    }
}

struct DriverList_Previews: PreviewProvider {
    static var previews: some View {
        DriverList()
    }
}
