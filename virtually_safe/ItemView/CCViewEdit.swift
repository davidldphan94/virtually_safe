//
//  CCViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/13/21.
//

import SwiftUI

struct CCViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var favorite = false
    @State var viewgenpw = false
    @State var viewsettings = false
    @State var bank = "Chase"
    @State var cardname = "Freedom Flex"
    @State var ccnum = "cc number"
    @State var holdername = "Kevin Kha"
    @State var valid = "05/25"
    @State var code = "001"
    @State var username = "username"
    @State var password = "password"
    @State var notes = "haha"
    
    var body: some View {
        VStack{
            
            ScrollView{
                VStack(alignment: .leading){
                    Text("Bank").foregroundColor(.gray).font(.headline)
                    TextField(bank, text: $bank)
                    Divider()
                    Text("Card Name").foregroundColor(.gray).font(.headline)
                    TextField(cardname, text: $cardname)
                    Divider()
                    Text("Credit Card Number").foregroundColor(.gray).font(.headline)
                    TextField(ccnum, text: $ccnum)
                    Divider()
                    Text("Holder's Name").foregroundColor(.gray).font(.headline)
                }.padding(.leading, 20).padding(.trailing, 20).padding(.top, 20)
                VStack(alignment: .leading){
                    TextField(holdername, text: $holdername)
                    Divider()
                    Text("Valid Thru").foregroundColor(.gray).font(.headline)
                    TextField(valid, text: $valid)
                    Divider()
                    Text("Security Code").foregroundColor(.gray).font(.headline)
                    TextField(code, text: $code)
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    TextField(username, text: $username)
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    TextField(password, text: $password)
                    Divider()
                    
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField("notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
            }
            
            Spacer()
            Divider()
        }.navigationBarTitle("Credit Card", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: { }, label: {
                    Text("Save")
                        .padding(.trailing, 20)
                }).padding(.trailing, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Text("Cancel")
            }
        })
    }
}

struct CCViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        CCViewEdit()
    }
}
