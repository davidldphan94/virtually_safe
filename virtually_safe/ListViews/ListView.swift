//
//  ContentView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/10/21.
//

import SwiftUI

struct ListView: View {
    @State var viewadditem = false
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    
    var body: some View {
        NavigationView{
            VStack {
                VStack(alignment: .leading){
                    Divider()
                    NavigationLink(destination: WebsiteList()){
                    Text("Passwords")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 20).padding(.trailing, 20)
                }
                
                VStack(alignment: .leading){
                    Divider()
                    NavigationLink(destination: CCList()){
                    Text("Credit Card")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 20).padding(.trailing, 20)
                }
                
                
                VStack(alignment: .leading){
                    Divider()
                    NavigationLink(destination: BankList()){
                    Text("Bank")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 20).padding(.trailing, 20)
                }
                
                
                VStack(alignment: .leading){
                    Divider()
                    NavigationLink(destination: DriverList()){
                    Text("Driver's License")
                    }
                    .foregroundColor(.blue)
                    .padding(.leading, 20).padding(.trailing, 20)
                }
                Divider()
                
                Spacer()
            }.navigationBarTitle("Vault", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(destination: AddItemView(), isActive: $viewadditem){ EmptyView() }
                    Button(action: {viewadditem = true}){
                        Image(systemName: "plus")
                            .foregroundColor(.gray)
                    }
                }
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    HStack{
                        NavigationLink(destination: ListView(), isActive: $viewvault){ EmptyView() }
                        Button(action: {}){
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
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
