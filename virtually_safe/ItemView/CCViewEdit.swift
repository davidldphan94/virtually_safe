//
//  CCViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/13/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CCViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var name = ""
    @State var bank = ""
    @State var cardname = ""
    @State var ccnum = ""
    @State var holdername = ""
    @State var valid = ""
    @State var code = ""
    @State var username = ""
    @State var password = ""
    @State var notes = ""
    
    @State var showAlert = false
    @State var errTitle = ""
    @State var errmsg = ""
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    Text("Name").foregroundColor(.gray).font(.headline)
                    TextField("My card name", text: $name)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("Bank").foregroundColor(.gray).font(.headline)
                    TextField("Bank name", text: $bank)
                    Divider()
                    Text("Card Name").foregroundColor(.gray).font(.headline)
                    TextField("Card name", text: $cardname)
                    Divider()
                   
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    Text("Credit Card Number").foregroundColor(.gray).font(.headline)
                    TextField("CC #", text: $ccnum)
                    Divider()
                    Text("Holder's Name").foregroundColor(.gray).font(.headline)
                    TextField("CC holder's name", text: $holdername)
                    Divider()
                    Text("Valid Thru").foregroundColor(.gray).font(.headline)
                    TextField("Valid until Date", text: $valid)
                    Divider()
                    Text("Security Code").foregroundColor(.gray).font(.headline)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    TextField("Security code on back", text: $code)
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    TextField("username", text: $username)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    TextField("password", text: $password)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField("notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Credit Card", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {uploadCC()}, label: {
                    Text("Save")
                        .padding(.trailing, 20)
                }).padding(.trailing, 20)
            }
        }
        .alert(isPresented: $showAlert) {self.alert}
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Text("Cancel")
            }
        })
    }
    
    func uploadCC() {
        if name == "" || bank == "" ||
            cardname == "" || ccnum == "" ||
            holdername == "" || valid == "" ||
            code == "" {
            showAlert = true
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
            let credit_card = CC(id: .init(), name: name, bank: bank, card_name: cardname, card_number: ccnum, holder_name: holdername, valid_thru: valid, security_code: code, username: username, password: password, notes: notes)
            let user = Auth.auth().currentUser!
            let dbRef = Firestore.firestore()
            dbRef.collection("users").document(user.uid).collection("credit_cards").document(name).setData(credit_card.dictionary, merge: true)
            name = ""
            bank = ""
            cardname = ""
            ccnum = ""
            holdername = ""
            valid = ""
            code = ""
            username = ""
            password = ""
            notes = ""
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

struct CCViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        CCViewEdit()
    }
}
