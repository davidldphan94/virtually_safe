//
//  WebsiteView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI

struct WebsiteView: View {
    @State var favorite = false
    @State var name = "name"
    @State var url = "url"
    @State var username = "username"
    @State var password = "password"
    @State var notes = "haha"
    
    var body: some View {
        
        VStack{
            
            ScrollView{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    
                    Text("Website Name").foregroundColor(.gray).font(.headline)
                    Text(name)
                    Divider()
                    Text("URL").foregroundColor(.gray).font(.headline)
                    Text(url)
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    Text(username)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    Text(password)
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    Text(notes)
                    
                }.padding(.leading, 20).padding(.trailing, 20)
            }
            
            Spacer()
            NavigationLink(destination: WebsiteViewEdit()){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50)
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
        }.navigationBarTitle("Password", displayMode: .inline)
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
}

struct WebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteView()
    }
}
