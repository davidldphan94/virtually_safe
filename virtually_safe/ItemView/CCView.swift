//
//  CCView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/13/21.
//

import SwiftUI

struct CCView: View {
    @State var favorite = false
    @State var seecode = false
    @State var seepw = false
    @State var bank = "Chase"
    @State var cardname = "Freedom Flex"
    @State var ccnum = "cc number"
    @State var holdername = "Kevin Kha"
    @State var valid = "05/21"
    @State var code = "001"
    @State var username = "username"
    @State var password = "password"
    @State var notes = "haha"
    
    let board = UIPasteboard.general
    
    var body: some View {
        
        VStack{
            VStack {
                HStack{
                    Text(bank).foregroundColor(.white)
                    Text(cardname).foregroundColor(.white)
                    Spacer()
                }.padding(.top, 10).padding(.leading, 10)
                Spacer()
                HStack{
                    Text(ccnum).padding(.leading, 10).foregroundColor(.white)
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Valid Thru: ").foregroundColor(.white)
                    Text(valid).padding(.trailing, 10).foregroundColor(.white)
                    Text("Code: ").foregroundColor(.white)
                    Text(code).foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 10).padding(.trailing, 10)
                Spacer()
                HStack{
                    Text(holdername).foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 10).padding(.bottom, 10)
            }.frame(width: 300, height: 175, alignment: .center).border(Color.blue)
                .background(Color.blue)
                .cornerRadius(15)
            .padding(.bottom, 15).padding(.top, 20)
                //.background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Bank").foregroundColor(.gray).font(.headline)
                            Text(bank)
                        }
                        Spacer()
                        Button(action: {
                            if (bank != ""){
                                board.string = bank
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Card Name").foregroundColor(.gray).font(.headline)
                            Text(cardname)
                        }
                        Spacer()
                        Button(action: {
                            if (cardname != ""){
                                board.string = cardname
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Credit Card Number").foregroundColor(.gray).font(.headline)
                            Text(ccnum)
                        }
                        Spacer()
                        Button(action: {
                            if ((ccnum) != ""){
                                board.string = (ccnum)
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
                            Text(holdername)
                        }
                        Spacer()
                        Button(action: {
                            if ((holdername) != ""){
                                board.string = (holdername)
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Valid Thru").foregroundColor(.gray).font(.headline)
                            Text(valid)
                        }
                        Spacer()
                        Button(action: {
                            if ((valid) != ""){
                                board.string = (valid)
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
                                Text(code)
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
                            if ((code) != ""){
                                board.string = (code)
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Login Username").foregroundColor(.gray).font(.headline)
                            Text(username)
                        }
                        Spacer()
                        Button(action: {
                            if ((username) != ""){
                                board.string = (username)
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Login Password").foregroundColor(.gray).font(.headline)
                            if seepw == false {
                                Text(hide(hid: password))
                            } else {
                                Text(password)
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
                            if ((password) != ""){
                                board.string = (password)
                            }}) {
                            Text("Copy")
                        }
                    }
                    //Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    Text(notes)
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
            NavigationLink(destination: CCViewEdit()){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50).padding(.top, 15)
            //Spacer()
            Divider()
            HStack{
                NavigationLink(destination: WebsiteView()){
                    Image(systemName: "key.fill").resizable().frame(width: 20, height: 30)
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
                Divider()
                NavigationLink(destination: GeneratePasswordView()){
                    Image(systemName: "lock.rotation").resizable().frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
                Divider()
                Image(systemName: "person.crop.circle").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
            }.frame(width: 350, height: 40, alignment: .center)
        }.navigationBarTitle("Credit Card", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: { toggleFav()}, label: {
                    if favorite == false {
                        Image(systemName: "star")
                    } else {
                        Image(systemName: "star.fill")
                    }
                }).padding(.trailing, 20)
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
            print(code.count)
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

struct CCView_Previews: PreviewProvider {
    static var previews: some View {
        CCView()
    }
}
