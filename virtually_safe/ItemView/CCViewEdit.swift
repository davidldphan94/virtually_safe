//
//  CCViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/13/21.
//

import SwiftUI

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
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    Text("Name").foregroundColor(.gray).font(.headline)
                    TextField("My card name", text: $bank)
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
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    TextField("password", text: $password)
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
