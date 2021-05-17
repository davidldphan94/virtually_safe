//
//  CCViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/13/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import RNCryptor

struct CCViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var credit_card : CC?
    
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
    
    let crypto = Encryption()
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    Text("Name").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.name ?? "My card name", text: $name)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("Bank").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.bank ?? "Bank name", text: $bank)
                    Divider()
                    Text("Card Name").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.card_name ?? "Card name", text: $cardname)
                    Divider()
                   
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    Text("Credit Card Number").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.card_number ?? "CC #", text: $ccnum)
                    Divider()
                    Text("Holder's Name").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.holder_name ?? "CC holder's name", text: $holdername)
                    Divider()
                    Text("Valid Thru").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.valid_thru ?? "Valid until Date", text: $valid)
                    Divider()
                    Text("Security Code").foregroundColor(.gray).font(.headline)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    TextField(credit_card?.security_code ?? "Security code on back", text: $code)
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.username ?? "username", text: $username)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.password ?? "password", text: $password)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Divider()
                    
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField(credit_card?.notes ?? "notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Credit Card", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    uploadCC()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
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
        if (credit_card != nil) {
            name = name != "" ? name : credit_card?.name ?? ""
            bank = bank != "" ? bank : credit_card?.bank ?? ""
            cardname = cardname != "" ? cardname : credit_card?.card_name ?? ""
            ccnum = ccnum != "" ? ccnum : credit_card?.card_number ?? ""
            holdername = holdername != "" ? holdername : credit_card?.holder_name ?? ""
            valid = valid != "" ? valid : credit_card?.valid_thru ?? ""
            code = code != "" ? code : credit_card?.security_code ?? ""
            username = username != "" ? username : credit_card?.username ?? ""
            password = password != "" ? password : credit_card?.password ?? ""
            notes = notes != "" ? notes : credit_card?.notes ?? ""
        }
        if name == "" || bank == "" ||
            cardname == "" || ccnum == "" ||
            holdername == "" || valid == "" ||
            code == "" {
            showAlert = true
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
            let new_card = CC(id: .init(), name: self.crypto.encrypt(plainTxt: name, encryptionKey: key),
                              bank: self.crypto.encrypt(plainTxt: bank, encryptionKey: key),
                              card_name: self.crypto.encrypt(plainTxt: cardname, encryptionKey: key),
                              card_number: self.crypto.encrypt(plainTxt: ccnum, encryptionKey: key),
                              holder_name: self.crypto.encrypt(plainTxt: holdername, encryptionKey: key),
                              valid_thru: self.crypto.encrypt(plainTxt: valid, encryptionKey: key),
                              security_code: self.crypto.encrypt(plainTxt: code, encryptionKey: key),
                              username: self.crypto.encrypt(plainTxt: username, encryptionKey: key),
                              password: self.crypto.encrypt(plainTxt: password, encryptionKey: key),
                              notes: self.crypto.encrypt(plainTxt: notes, encryptionKey: key))
            let user = Auth.auth().currentUser!
            let dbRef = Firestore.firestore()
            if (name != credit_card?.name ?? name) {
                dbRef.collection("users").document(user.uid).collection("credit_cards").document(name).setData(new_card.dictionary, merge: true)
                dbRef.collection("users").document(user.uid).collection("credit_cards").document(credit_card!.name).delete()
            } else {
                dbRef.collection("users").document(user.uid).collection("credit_cards").document(name).setData(new_card.dictionary, merge: true)
            }
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
            errmsg = "Review submitted. The fields will update upon revisit."
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
