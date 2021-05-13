//
//  WebsiteView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI

struct WebsiteView: View {
<<<<<<< HEAD
    //@State var name = "hello"
=======
    
>>>>>>> ef4b5e35f537c3de531f0f00ecff6b0ce5213aee
    var body: some View {
        
        VStack{
            HStack(alignment: .center){
                Spacer()
                Text("Password")
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                Spacer()
                /*
<<<<<<< HEAD
                NavigationLink(destination: CreateProfileView(editProf: editProf)){
=======
                NavigationLink(destination: WebsiteViewEdit()){
>>>>>>> ef4b5e35f537c3de531f0f00ecff6b0ce5213aee
                Text("Edit")
                }
                .padding(.trailing, 20)
                */
                Text("Edit")
                    .padding(.trailing, 20)
            }.padding(.bottom, 30)
            
            ScrollView{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    
                    Text("Website Name").foregroundColor(.gray).font(.headline)
<<<<<<< HEAD
                    //TextField("lol", text: $name)
=======
>>>>>>> ef4b5e35f537c3de531f0f00ecff6b0ce5213aee
                    Text("name")
                    Divider()
                    Text("URL").foregroundColor(.gray).font(.headline)
                    Text("url")
                    Divider()
                    Text("Username").foregroundColor(.gray).font(.headline)
                    Text("user")
                    
<<<<<<< HEAD
                    //Text("lol")
                    
=======
>>>>>>> ef4b5e35f537c3de531f0f00ecff6b0ce5213aee
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
<<<<<<< HEAD
            }.frame(width: 350, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
=======
            }.frame(width: 350, height: 40, alignment: .center)
>>>>>>> ef4b5e35f537c3de531f0f00ecff6b0ce5213aee
        }
    }
}

struct WebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteView()
    }
}
