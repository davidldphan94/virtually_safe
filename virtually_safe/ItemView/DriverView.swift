//
//  DriverView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct DriverView: View {
    @State var license: DriverLicense
    @State var favorite = false
    
    let user = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
    let board = UIPasteboard.general
    
    var body: some View {
        
        VStack{
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Name").foregroundColor(.gray).font(.headline)
                            Text(license.name)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.name != ""){
                                board.string = license.name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("License Class").foregroundColor(.gray).font(.headline)
                            Text(license.licenseclass)
                        }
                        Spacer()
                        Button(action: {
                            if (license.licenseclass != ""){
                                board.string = license.licenseclass
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Driver's ID").foregroundColor(.gray).font(.headline)
                            Text(license.num)
                        }
                        Spacer()
                        Button(action: {
                            if (license.num != ""){
                                board.string = license.num
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Driver's Name").foregroundColor(.gray).font(.headline)
                            Text(license.driver_name)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.driver_name != ""){
                                board.string = license.driver_name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Address Street").foregroundColor(.gray).font(.headline)
                            Text(license.addrSt)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.addrSt != ""){
                                board.string = license.addrSt
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                .onAppear{
                    if license.fav == true {
                        favorite = true
                    }
                }
                
                VStack(alignment: .leading){
                    if license.addrSt2 != "" {
                        HStack{
                            VStack(alignment: .leading){
                                Text("Address Street 2 (Optional)").foregroundColor(.gray).font(.headline)
                                Text(license.addrSt2)
                            }
                            
                            Spacer()
                            Button(action: {
                                if (license.addrSt2 != ""){
                                    board.string = license.addrSt2
                                }}) {
                                Text("Copy")
                            }
                        }
                        Divider()
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("City").foregroundColor(.gray).font(.headline)
                            Text(license.addrCity)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.addrCity != ""){
                                board.string = license.addrCity
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text(" State").foregroundColor(.gray).font(.headline)
                            Text(license.addrState)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.addrState != ""){
                                board.string = license.addrState
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Zip Code").foregroundColor(.gray).font(.headline)
                            Text(license.addrZip)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.addrZip != ""){
                                board.string = license.addrZip
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Country").foregroundColor(.gray).font(.headline)
                            Text(license.addrCountry)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.addrCountry != ""){
                                board.string = license.addrCountry
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Sex").foregroundColor(.gray).font(.headline)
                            Text(license.sex)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.sex != ""){
                                board.string = license.sex
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Height").foregroundColor(.gray).font(.headline)
                            Text(license.height)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.height != ""){
                                board.string = license.height
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Eye Color").foregroundColor(.gray).font(.headline)
                            Text(license.eyes)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.eyes != ""){
                                board.string = license.eyes
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Date of Birth").foregroundColor(.gray).font(.headline)
                            Text(license.dob)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.dob != ""){
                                board.string = license.dob
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Expiration Date").foregroundColor(.gray).font(.headline)
                            Text(license.expire)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.expire != ""){
                                board.string = license.expire
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Issued Date").foregroundColor(.gray).font(.headline)
                            Text(license.issued)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.issued != ""){
                                board.string = license.issued
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Document #").foregroundColor(.gray).font(.headline)
                            Text(license.doc)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (license.doc != ""){
                                board.string = license.doc
                            }}) {
                            Text("Copy")
                        }
                    }
                    if license.notes != "" {
                        Divider()
                        Text("Notes").foregroundColor(.gray).font(.headline)
                        Text(license.notes)
                    }
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            Spacer()
            NavigationLink(destination: DriverViewEdit(license: license)){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50)
            
        }.navigationBarTitle("Driver's License", displayMode: .inline)
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
                        db.collection("users").document(user.uid).collection("licenses").document(license.name).updateData(["fav": false])
                    } else {
                        db.collection("users").document(user.uid).collection("licenses").document(license.name).updateData(["fav": true])
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
}

//struct DriverView_Previews: PreviewProvider {
//    static var previews: some View {
//        DriverView()
//    }
//}
