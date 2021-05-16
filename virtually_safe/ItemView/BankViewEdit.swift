//
//  BankViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct BankViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name = ""
    @State var bankname = ""
    @State var acctype = ""
    @State var routing = ""
    @State var accnum = ""
    @State var pin = ""
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
                    TextField("name", text: $name)
                    Divider()
                    Text("Bank Name").foregroundColor(.gray).font(.headline)
                    TextField("bank name", text: $bankname)
                    Divider()
                    Text("Account Type").foregroundColor(.gray).font(.headline)
                    //TextField("Checking/Savings", text: $acctype)
                    TextField("Checking/Savings", text: $acctype)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    
                    Text("Routing Number").foregroundColor(.gray).font(.headline)
                    TextField("routing #", text: $routing)
                    Divider()
                    Text("Account Number").foregroundColor(.gray).font(.headline)
                    TextField("account #", text: $accnum).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("PIN Number").foregroundColor(.gray).font(.headline)
                    TextField("PIN #", text: $pin).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField("notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Bank Account", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {uploadBank()}, label: {
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
        if name == "" || bankname == "" ||
            acctype == "" || accnum == "" ||
            routing == "" || pin == ""  {
            showAlert = true
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
            let bank = Bank(id: .init(), name: name, bank_name: bankname, type: acctype, routing_number: routing, account_number: accnum, pin: pin, notes: notes)
            let user = Auth.auth().currentUser!
            let dbRef = Firestore.firestore()
            dbRef.collection("users").document(user.uid).collection("banks").document(name).setData(bank.dictionary, merge: true)
            name = ""
            bankname = ""
            acctype = ""
            accnum = ""
            routing = ""
            pin = ""
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

struct BankViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        BankViewEdit()
    }
}
