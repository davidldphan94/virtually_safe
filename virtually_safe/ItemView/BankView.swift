//
//  BankView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct BankView: View {
    @State var bank : Bank
    @State var favorite = false
    @State var seepin = false
    
    let user = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
    let board = UIPasteboard.general
    
    var body: some View {
        
        VStack{
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Name").foregroundColor(.gray).font(.headline)
                            Text(bank.name)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (bank.name != ""){
                                board.string = bank.name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Bank Name").foregroundColor(.gray).font(.headline)
                            Text(bank.bank_name)
                        }
                        Spacer()
                        Button(action: {
                            if (bank.bank_name != ""){
                                board.string = bank.bank_name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Account Type").foregroundColor(.gray).font(.headline)
                            Text(bank.type)
                        }
                        Spacer()
                        Button(action: {
                            if (bank.type != ""){
                                board.string = bank.type
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Routing Number").foregroundColor(.gray).font(.headline)
                            Text(bank.routing_number)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (bank.routing_number != ""){
                                board.string = bank.routing_number
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Account Number").foregroundColor(.gray).font(.headline)
                            Text(bank.account_number)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (bank.account_number != ""){
                                board.string = bank.account_number
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                .onAppear{
                    if bank.fav == true {
                        favorite = true
                    }
                }
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("PIN Number").foregroundColor(.gray).font(.headline)
                            if seepin == false {
                                Text(hide(hid: bank.pin))
                            } else {
                                Text(bank.pin)
                            }
                        }
                        Spacer()
                        Button(action: { togglePin() }, label: {
                            if seepin == false{
                                Image(systemName: "eye").foregroundColor(.blue)
                                    .frame(width: 35, height: 30, alignment: .center)
                            } else {
                                Image(systemName: "eye.fill").foregroundColor(.blue)
                            }
                        })
                        Button(action: {
                            if (bank.pin != ""){
                                board.string = bank.pin
                            }}) {
                            Text("Copy")
                        }
                    }
                    if bank.notes != "" {
                        Divider()
                        Text("Notes").foregroundColor(.gray).font(.headline)
                        Text(bank.notes)
                    }
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            Spacer()
            NavigationLink(destination: BankViewEdit(bank: bank)){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50)
            
        }.navigationBarTitle("Bank Account", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {}){
            HStack{
            }
        })
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: { toggleFav()}, label: {
                    if favorite == false {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }).padding(.trailing, 20)
                .onAppear{
                    if favorite == false {
                        db.collection("users").document(user.uid).collection("banks").document(bank.name).updateData(["fav": false])
                    } else {
                        db.collection("users").document(user.uid).collection("banks").document(bank.name).updateData(["fav": true])
                    }
                }
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
    
    func togglePin(){
        if seepin == false {
            seepin = true
        } else {
            seepin = false
        }
    }
    
    func hide(hid: String) -> String{
        var x = ""
        for _ in hid {
            x = x+"*"
        }
        return x
    }
}

//struct BankView_Previews: PreviewProvider {
//    static var previews: some View {
//        BankView()
//    }
//}
