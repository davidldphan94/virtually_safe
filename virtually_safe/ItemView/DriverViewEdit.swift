//
//  DriverViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI

struct DriverViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var name = ""
    @State var licenseclass = ""
    @State var id = ""
    @State var drivername = ""
    @State var addrSt = ""
    @State var addrSt2 = ""
    @State var addrCity = ""
    @State var addrState = ""
    @State var addrZip = ""
    @State var addrCountry = ""
    @State var sex = ""
    @State var height = ""
    @State var eyes = ""
    @State var dob = ""
    @State var expire = ""
    @State var issued = ""
    @State var doc = ""
    @State var notes = ""
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    Text("Name").foregroundColor(.gray).font(.headline)
                    TextField("name", text: $name)
                    Divider()
                    Text("License Class").foregroundColor(.gray).font(.headline)
                    TextField("D (most common)", text: $licenseclass)
                    Divider()
                    Text("Driver's ID").foregroundColor(.gray).font(.headline)
                    //TextField("Checking/Savings", text: $acctype)
                    TextField("ID #", text: $id)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    
                    Text("Driver's Name").foregroundColor(.gray).font(.headline)
                    TextField("Name on card", text: $drivername)
                    Divider()
                    Text("Address Street").foregroundColor(.gray).font(.headline)
                    TextField("Street name", text: $addrSt).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Adress Street 2 (Optional)").foregroundColor(.gray).font(.headline)
                    TextField("#, APT, STE, etc.", text: $addrSt2).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Divider()
                    Text("City").foregroundColor(.gray).font(.headline)
                    TextField("City name", text: $addrCity).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("State").foregroundColor(.gray).font(.headline)
                    TextField("State name", text: $addrState).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Zip Code").foregroundColor(.gray).font(.headline)
                    TextField("Zip code #", text: $addrZip).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Text("Country").foregroundColor(.gray).font(.headline)
                    TextField("Country name", text: $addrCountry).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Sex").foregroundColor(.gray).font(.headline)
                    TextField("Sex", text: $sex).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Height").foregroundColor(.gray).font(.headline)
                    TextField("Height in 0'0", text: $height).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Text("Eyes").foregroundColor(.gray).font(.headline)
                    TextField("Eye color", text: $eyes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Date of Birth").foregroundColor(.gray).font(.headline)
                    TextField("MM/DD/YYYY", text: $dob).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Expiration Date").foregroundColor(.gray).font(.headline)
                    TextField("MM/DD/YYYY", text: $dob).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Text("Issued Date").foregroundColor(.gray).font(.headline)
                    TextField("MM/DD/YYYY", text: $issued).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Document #").foregroundColor(.gray).font(.headline)
                    TextField("Usually on back below barcode", text: $doc).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField("notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Driver's License", displayMode: .inline)
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

struct DriverViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        DriverViewEdit()
    }
}
