//
//  WebsiteView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI

struct WebsiteView: View {
    //@State var name = "hello"
    var body: some View {
        //NavigationView{
        VStack{
            HStack(alignment: .center){
                Spacer()
                Text("Password")
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                Spacer()
                
                NavigationLink(destination: WebsiteViewEdit()){
                Text("Edit")
                }
                .padding(.trailing, 20)
                
            }.padding(.bottom, 30)
            
            ScrollView{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    
                    Text("Website Name").foregroundColor(.gray).font(.headline)
                    Text("name")
                    Divider()
                    Text("URL").foregroundColor(.gray).font(.headline)
                    Text("url")
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    Text("user")
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Divider()
                    Text("Password").foregroundColor(.gray).font(.headline)
                    Text("pass")
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    Text("haha")
                    
                }.padding(.leading, 20).padding(.trailing, 20)
            }
            
            Spacer()
            Divider()
            HStack{
                Image(systemName: "key.fill").resizable().frame(width: 20, height: 30)
                    .foregroundColor(.black)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                Divider()
                Image(systemName: "lock.rotation").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                Divider()
                Image(systemName: "person.crop.circle").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
            }.frame(width: 350, height: 40, alignment: .center)
        }
    }
    //}
}

struct WebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteView()
    }
}
