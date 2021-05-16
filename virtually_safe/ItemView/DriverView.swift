//
//  DriverView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI

struct DriverView: View {
    @State var favorite = false
    @State var viewvault = false
    @State var viewgenpw = false
    @State var viewsettings = false
    @State var name = "Driver's License"
    @State var licenseclass = "D"
    @State var id = "123456789"
    @State var drivername = "Kevin Kha"
    @State var addrSt = "1st St"
    @State var addrSt2 = "Apt 1"
    @State var addrCity = "Syracuse"
    @State var addrState = "NY"
    @State var addrZip = "13244"
    @State var addrCountry = "US"
    @State var sex = "M"
    @State var height = "heh"
    @State var eyes = "Br"
    @State var dob = "MM/DD/YYYY"
    @State var expire = "MM/DD/YYYY"
    @State var issued = "MM/DD/YYYY"
    @State var doc = "ABC1234567"
    @State var notes = ""
    
    let board = UIPasteboard.general
    
    var body: some View {
        
        VStack{
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Name").foregroundColor(.gray).font(.headline)
                            Text(name)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (name != ""){
                                board.string = name
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("License Class").foregroundColor(.gray).font(.headline)
                            Text(licenseclass)
                        }
                        Spacer()
                        Button(action: {
                            if (licenseclass != ""){
                                board.string = licenseclass
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Driver's ID").foregroundColor(.gray).font(.headline)
                            Text(id)
                        }
                        Spacer()
                        Button(action: {
                            if (id != ""){
                                board.string = id
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Driver's Name").foregroundColor(.gray).font(.headline)
                            Text(drivername)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (drivername != ""){
                                board.string = drivername
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Address Street").foregroundColor(.gray).font(.headline)
                            Text(addrSt)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (addrSt != ""){
                                board.string = addrSt
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    if addrSt2 != "" {
                        HStack{
                            VStack(alignment: .leading){
                                Text("Address Street 2 (Optional)").foregroundColor(.gray).font(.headline)
                                Text(addrSt2)
                            }
                            
                            Spacer()
                            Button(action: {
                                if (addrSt2 != ""){
                                    board.string = addrSt2
                                }}) {
                                Text("Copy")
                            }
                        }
                        Divider()
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("City").foregroundColor(.gray).font(.headline)
                            Text(addrCity)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (addrCity != ""){
                                board.string = addrCity
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text(" State").foregroundColor(.gray).font(.headline)
                            Text(addrState)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (addrState != ""){
                                board.string = addrState
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Zip Code").foregroundColor(.gray).font(.headline)
                            Text(addrZip)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (addrZip != ""){
                                board.string = addrZip
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Country").foregroundColor(.gray).font(.headline)
                            Text(addrCountry)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (addrCountry != ""){
                                board.string = addrCountry
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
                            Text(sex)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (sex != ""){
                                board.string = sex
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Height").foregroundColor(.gray).font(.headline)
                            Text(height)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (height != ""){
                                board.string = height
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Eye Color").foregroundColor(.gray).font(.headline)
                            Text(eyes)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (eyes != ""){
                                board.string = eyes
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Date of Birth").foregroundColor(.gray).font(.headline)
                            Text(dob)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (dob != ""){
                                board.string = dob
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Expiration Date").foregroundColor(.gray).font(.headline)
                            Text(expire)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (expire != ""){
                                board.string = expire
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
                            Text(issued)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (issued != ""){
                                board.string = issued
                            }}) {
                            Text("Copy")
                        }
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            Text("Document #").foregroundColor(.gray).font(.headline)
                            Text(doc)
                        }
                        
                        Spacer()
                        Button(action: {
                            if (doc != ""){
                                board.string = doc
                            }}) {
                            Text("Copy")
                        }
                    }
                    if notes != "" {
                        Divider()
                        Text("Notes").foregroundColor(.gray).font(.headline)
                        Text(notes)
                    }
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            Spacer()
            NavigationLink(destination: DriverViewEdit()){
            Text("Edit")
            }.frame(width: 100, height: 40, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .padding(.bottom, 50)
            
        }.navigationBarTitle("Driver's License", displayMode: .inline)
        //.navigationBarBackButtonHidden(true)
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
            ToolbarItemGroup(placement: .bottomBar){
                Spacer()
                NavigationLink(destination: ListView(), isActive: $viewvault){ EmptyView() }
                Button(action: {viewvault = true}){
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
    }
    
    func toggleFav(){
        if favorite == false {
            favorite = true
        } else {
            favorite = false
        }
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView()
    }
}
