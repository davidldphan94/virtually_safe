//
//  CCView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/13/21.
//

import SwiftUI
import Firebase

struct CCView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var credit_card : CC
    @State var favorite = false
    @State var seecode = false
    @State var seepw = false
    
    let user = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
    let board = UIPasteboard.general
    
    
    var body: some View {
        VStack{
            VStack {
                HStack{
                    Text(credit_card.bank).foregroundColor(.white)
                    if credit_card.card_name != "" {
                        Text(credit_card.card_name).foregroundColor(.white)
                    }
                    Spacer()
                }.padding(.top, 10).padding(.leading, 10)
                Spacer()
                HStack{
                    Text(credit_card.card_number).padding(.leading, 10).foregroundColor(.white)
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Valid Thru: ").foregroundColor(.white)
                    Text(credit_card.valid_thru).padding(.trailing, 10).foregroundColor(.white)
                    Text("Code: ").foregroundColor(.white)
                    if seecode == false {
                        Text("***").foregroundColor(.white)
                    } else {
                        Text(credit_card.security_code).foregroundColor(.white)
                    }
                    Spacer()
                }.padding(.leading, 10).padding(.trailing, 10)
                Spacer()
                HStack{
                    Text(credit_card.holder_name).foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 10).padding(.bottom, 10)
            }.frame(width: 300, height: 175, alignment: .center).border(Color.blue)
                .background(Color.blue)
                .cornerRadius(15)
            .padding(.top, 20)
            .onAppear{
                if credit_card.fav == true {
                    favorite = true
                }
            }
                
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Name").foregroundColor(.gray).font(.headline)
                            Text(credit_card.name)
                        }
                        Spacer()
                        Button(action: {
                                if (credit_card.name != ""){
                                    board.string = credit_card.name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Bank").foregroundColor(.gray).font(.headline)
                            Text(credit_card.bank)
                        }
                        Spacer()
                        Button(action: {
                                if (credit_card.bank != ""){
                                    board.string = credit_card.bank
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    if credit_card.card_name != "" {
                        HStack{
                            VStack(alignment: .leading){
                                Text("Card Name").foregroundColor(.gray).font(.headline)
                                Text(credit_card.card_name)
                            }
                            Spacer()
                            Button(action: {
                                    if (credit_card.card_name != ""){
                                        board.string = credit_card.card_name
                                }}) {
                                Text("Copy")
                            }
                        }
                        Divider()
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("Credit Card Number").foregroundColor(.gray).font(.headline)
                            Text(credit_card.card_number)
                        }
                        Spacer()
                        Button(action: {
                                if (credit_card.card_number != ""){
                                    board.string = (credit_card.card_number)
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Holder's Name").foregroundColor(.gray).font(.headline)
                            Text(credit_card.holder_name)
                        }
                        Spacer()
                        Button(action: {
                                if ((credit_card.holder_name) != ""){
                                    board.string = (credit_card.holder_name)
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Valid Thru").foregroundColor(.gray).font(.headline)
                            Text(credit_card.valid_thru)
                        }
                        Spacer()
                        Button(action: {
                                if (credit_card.valid_thru != ""){
                                    board.string = (credit_card.valid_thru)
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Security Code").foregroundColor(.gray).font(.headline)
                            if seecode == false {
                                Text("***")
                            } else {
                                Text(credit_card.security_code)
                            }
                        }
                        Spacer()
                        Button(action: { toggleCode() }, label: {
                            if seecode == false{
                                Image(systemName: "eye").foregroundColor(.blue)
                                    .frame(width: 35, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            } else {
                                Image(systemName: "eye.fill").foregroundColor(.blue)
                            }
                        })
                        Button(action: {
                                if ((credit_card.security_code) != ""){
                                board.string = credit_card.security_code
                            }}) {
                            Text("Copy")
                        }
                    }
                    if credit_card.username != "" {
                        Divider()
                        HStack{
                            VStack(alignment: .leading){
                                Text("Login Username").foregroundColor(.gray).font(.headline)
                                Text(credit_card.username)
                            }
                            Spacer()
                            Button(action: {
                                    if ((credit_card.username) != ""){
                                        board.string = (credit_card.username)
                                }}) {
                                Text("Copy")
                            }
                        }
                    }
                    if credit_card.password != "" {
                        Divider()
                        HStack{
                            VStack(alignment: .leading){
                                Text("Login Password").foregroundColor(.gray).font(.headline)
                                if seepw == false {
                                    Text(hide(hid: credit_card.password))
                                } else {
                                    Text(credit_card.password)
                                }
                            }
                            Spacer()
                            Button(action: { togglePw() }, label: {
                                if seepw == false{
                                    Image(systemName: "eye").foregroundColor(.blue)
                                        .frame(width: 35, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                } else {
                                    Image(systemName: "eye.fill").foregroundColor(.blue)
                                }
                            })
                            Button(action: {
                                    if ((credit_card.password) != ""){
                                        board.string = (credit_card.password)
                                }}) {
                                Text("Copy")
                            }
                        }
                    }
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    if credit_card.notes != "" {
                        Divider()
                        Text("Notes").foregroundColor(.gray).font(.headline)
                        Text(credit_card.notes)
                    }
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
            NavigationLink(destination: CCViewEdit(credit_card: credit_card)){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50).padding(.top, 15)
            //Spacer()
            Divider()
        }.navigationBarTitle("Credit Card", displayMode: .inline)
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
                        db.collection("users").document(user.uid).collection("credit_cards").document(credit_card.name).updateData(["fav": false])
                    } else {
                        db.collection("users").document(user.uid).collection("credit_cards").document(credit_card.name).updateData(["fav": true])
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
    
    func toggleCode(){
        if seecode == false {
            seecode = true
        } else {
            seecode = false
        }
    }
    
    func togglePw(){
        if seepw == false {
            seepw = true
        } else {
            seepw = false
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

//struct CCView_Previews: PreviewProvider {
//    static var previews: some View {
//        CCView()
//    }
//}
