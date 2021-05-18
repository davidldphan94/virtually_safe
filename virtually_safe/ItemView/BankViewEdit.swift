//
//  BankViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import RNCryptor

struct BankViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var bank : Bank?
    @State var name = ""
    @State var bankname = ""
    @State var acctype = ""
    @State var routing = ""
    @State var accnum = ""
    @State var pin = ""
    @State var notes = ""
    @State var fav = false
    
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
                    TextField(bank?.name ?? "name", text: $name)
                    Divider()
                    Text("Bank Name").foregroundColor(.gray).font(.headline)
                    TextField(bank?.bank_name ?? "bank name", text: $bankname)
                    Divider()
                    Text("Account Type").foregroundColor(.gray).font(.headline)
                    //TextField("Checking/Savings", text: $acctype)
                    TextField(bank?.type ?? "Checking/Savings", text: $acctype)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    
                    Text("Routing Number").foregroundColor(.gray).font(.headline)
                    TextField(bank?.routing_number ?? "routing #", text: $routing)
                    Divider()
                    Text("Account Number").foregroundColor(.gray).font(.headline)
                    TextField(bank?.account_number ?? "account #", text: $accnum).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("PIN Number").foregroundColor(.gray).font(.headline)
                    TextField(bank?.pin ?? "PIN #", text: $pin).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField(bank?.notes ?? "notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Bank Account", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    uploadBank()
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
    
    func uploadBank() {
        if bank != nil {
            name = name != "" ? name : bank!.name
            bankname = bankname != "" ? bankname : bank!.bank_name
            acctype = acctype != "" ? acctype : bank!.type
            routing = routing != "" ? routing : bank!.routing_number
            accnum = accnum != "" ? accnum : bank!.account_number
            pin = pin != "" ? accnum : bank!.pin
            notes = notes != "" ? notes : bank!.notes
        }
        if name == "" || bankname == "" ||
            acctype == "" || accnum == "" ||
            routing == "" || pin == ""  {
            showAlert = true
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
            let b = Bank(id: .init(), name:  self.crypto.encrypt(plainTxt: name, encryptionKey: key),
                         bank_name:  self.crypto.encrypt(plainTxt: bankname, encryptionKey: key),
                         type:  self.crypto.encrypt(plainTxt: acctype, encryptionKey: key),
                         routing_number:  self.crypto.encrypt(plainTxt: routing, encryptionKey: key),
                         account_number:  self.crypto.encrypt(plainTxt: accnum, encryptionKey: key),
                         pin:  self.crypto.encrypt(plainTxt: pin, encryptionKey: key),
                         notes:  self.crypto.encrypt(plainTxt: notes, encryptionKey: key),
                         fav: fav)
            let user = Auth.auth().currentUser!
            let dbRef = Firestore.firestore()
            if name != bank?.name ?? name {
                dbRef.collection("users").document(user.uid).collection("banks")
                    .document(name).setData(b.dictionary, merge: true)
                dbRef.collection("users").document(user.uid).collection("banks")
                    .document(bank!.name).delete()
            } else {
                dbRef.collection("users").document(user.uid).collection("banks")  .document(name).setData(b.dictionary, merge: true)
            }
            name = ""
            bankname = ""
            acctype = ""
            accnum = ""
            routing = ""
            pin = ""
            notes = ""
            fav = false
            errTitle = "Success"
            errmsg = "Review submitted. Values will be updates upon revisit."
            showAlert = true
        }
    }
    var alert : Alert {
        Alert(title: Text(errTitle),
              message: Text(errmsg))
    }
}

struct BankViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        BankViewEdit()
    }
}
