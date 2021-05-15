//
//  SettingsView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/14/21.
//

import SwiftUI

struct SettingsView: View {
    @State var username = "kkha"
    @State var viewvault = false
    @State var viewgenpw = false
    
    var body: some View {
        VStack{//(alignment: .leading){
            HStack{
                Text("Username: ")
                Text(username)
                //Spacer()
            }.padding()
            /*
            NavigationLink(destination: LoginView().navigationBarHidden(true), isActive: $loggedOut) { EmptyView() }
            */
            Button(action: { }) {
                Text("Sign Out")
            }.padding().frame(width: 100, height: 50, alignment: .center).foregroundColor(.red).border(Color.red)
            
            Divider().padding(.top, 30)
            Button(action: {}) {
                Text("About Virtually Safe")
            }
            Divider()
            Button(action: {}) {
                Text("Account Settings")
            }
            Divider()
            Button(action: {}) {
                Text("Security")
            }
            Divider()
            Spacer()
        }.navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar){
                Spacer()
                NavigationLink(destination: WebsiteView(), isActive: $viewvault){ EmptyView() }
                Button(action: {viewvault = true}){
                    Image(systemName: "key.fill").resizable().frame(width: 42, height: 50)
                        .foregroundColor(.gray)
                }
                Spacer()
                NavigationLink(destination: GeneratePasswordView(), isActive: $viewgenpw){ EmptyView() }
                Button(action: {viewgenpw = true}){
                    Image(systemName: "lock.rotation")
                        .foregroundColor(.black)
                }
                Spacer()
                
                Button(action: {}){
                    Image(systemName: "gearshape.fill").resizable().frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
