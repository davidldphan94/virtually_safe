//
//  ContentView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/10/21.
//

import SwiftUI

struct ListView: View {
    @State var viewgenpw = false
    @State var viewsettings = false
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: WebsiteView()){
                Text("Website View")
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding()
                NavigationLink(destination: CCView()){
                Text("Credit Card View")
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding()
                NavigationLink(destination: GeneratePasswordView()){
                Text("Generate Password View")
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding()
                Spacer()
            }.navigationBarTitle("Vault", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    Button(action: {}){
                        Image(systemName: "key.fill").resizable().frame(width: 42, height: 50)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    NavigationLink(destination: GeneratePasswordView(), isActive: $viewgenpw){ EmptyView() }
                    Button(action: {viewgenpw = true}){
                        Image(systemName: "lock.rotation")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView(), isActive: $viewsettings){ EmptyView() }
                    Button(action: {viewsettings = true}){
                        Image(systemName: "gearshape.fill").resizable().frame(width: 50, height: 50)
                            .foregroundColor(.gray)
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
