//
//  DriverViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import RNCryptor

struct DriverViewEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var license : DriverLicense?
    
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
    
    @State var showAlert = false
    @State var errTitle = ""
    @State var errmsg = ""
    
    let crypto = Encryption()
    
    var body: some View {
        VStack{
            
            ScrollView{
                Divider().padding(.top, 50)
                VStack(alignment: .leading){
                    Text("Name").foregroundColor(.gray).font(.headline)
                    TextField(license?.name ?? "name", text: $name)
                    Divider()
                    Text("License Class").foregroundColor(.gray).font(.headline)
                    TextField(license?.licenseclass ?? "D (most common)", text: $licenseclass)
                    Divider()
                    Text("Driver's ID").foregroundColor(.gray).font(.headline)
                    //TextField("Checking/Savings", text: $acctype)
                    TextField(license?.num ?? "ID #", text: $id)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                VStack(alignment: .leading){
                    
                    Text("Driver's Name").foregroundColor(.gray).font(.headline)
                    TextField(license?.driver_name ?? "Name on card", text: $drivername)
                    Divider()
                    Text("Address Street").foregroundColor(.gray).font(.headline)
                    TextField(license?.addrSt ?? "Street name", text: $addrSt).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Adress Street 2 (Optional)").foregroundColor(.gray).font(.headline)
                    TextField(license?.addrSt2 ?? "#, APT, STE, etc.", text: $addrSt2).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Divider()
                    Text("City").foregroundColor(.gray).font(.headline)
                    TextField(license?.addrCity ?? "City name", text: $addrCity).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("State").foregroundColor(.gray).font(.headline)
                    TextField(license?.addrState ?? "State name", text: $addrState).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Zip Code").foregroundColor(.gray).font(.headline)
                    TextField(license?.addrZip ?? "Zip code #", text: $addrZip).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Text("Country").foregroundColor(.gray).font(.headline)
                    TextField(license?.addrZip ?? "Country name", text: $addrCountry).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Sex").foregroundColor(.gray).font(.headline)
                    TextField(license?.sex ?? "Sex", text: $sex).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Height").foregroundColor(.gray).font(.headline)
                    TextField(license?.height ?? "Height in 0'0", text: $height).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Text("Eyes").foregroundColor(.gray).font(.headline)
                    TextField(license?.eyes ?? "Eye color", text: $eyes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Date of Birth").foregroundColor(.gray).font(.headline)
                    TextField(license?.dob ?? "MM/DD/YYYY", text: $dob).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Expiration Date").foregroundColor(.gray).font(.headline)
                    TextField(license?.expire ?? "MM/DD/YYYY", text: $expire).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                }.padding(.leading, 20).padding(.trailing, 20)
                
                VStack(alignment: .leading){
                    Text("Issued Date").foregroundColor(.gray).font(.headline)
                    TextField(license?.issued ?? "MM/DD/YYYY", text: $issued).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Document #").foregroundColor(.gray).font(.headline)
                    TextField(license?.doc ?? "Usually on back below barcode", text: $doc).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Notes").foregroundColor(.gray).font(.headline)
                    TextField(license?.notes ?? "notes", text: $notes).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 20).padding(.trailing, 20)
                Divider()
            }
            
            Spacer()
        }.navigationBarTitle("Driver's License", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    submitLicense()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .padding(.trailing, 20)
                }).padding(.trailing, 20)
            }
        }
        .alert(isPresented: $showAlert) {self.alert}
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
                Text("Cancel")
            }
        })
    }
    
    func submitLicense() {
        if (license != nil) {
            name = name != "" ? name : license?.name ?? ""
            licenseclass = licenseclass != "" ? licenseclass : license?.licenseclass ?? ""
            id = id != "" ? id : license?.num ?? ""
            drivername = drivername != "" ? drivername : license?.driver_name ?? ""
            addrSt = addrSt != "" ? addrSt : license?.addrSt ?? ""
            addrSt2 = addrSt2 != "" ? addrSt2 : license?.addrSt2 ?? ""
            addrCity = addrCity != "" ? addrCity : license?.addrCity ?? ""
            addrState = addrState != "" ? addrState : license?.addrState ?? ""
            addrZip = addrZip != "" ? addrZip : license?.addrZip ?? ""
            addrCountry = addrCountry != "" ? addrCountry : license?.addrCountry ?? ""
            sex = sex != "" ? sex : license?.sex ?? ""
            height = height != "" ? height : license?.height ?? ""
            eyes = eyes != "" ? eyes : license?.eyes ?? ""
            dob = dob != "" ? dob : license?.dob ?? ""
            expire = expire != "" ? expire : license?.expire ?? ""
            issued = issued != "" ? issued : license?.issued ?? ""
            doc = doc != "" ? doc : license?.doc ?? ""
            notes = notes != "" ? notes : license?.notes ?? ""
        }
        if (name == "" || licenseclass == "" ||
            id == "" || drivername == "" ||
            addrSt == "" || addrCity == "" ||
            addrState == "" || addrZip == "" ||
            addrCountry == "" || sex == "" ||
            height == "" || eyes == "" || dob == "" ||
            expire == "" || issued == "" || doc == "") {
            errTitle = "Submission failed"
            errmsg = "Not enough information provided"
        } else {
            let new_license = DriverLicense(id: .init(), name:  self.crypto.encrypt(plainTxt: name, encryptionKey: key),
                licenseclass:  self.crypto.encrypt(plainTxt: licenseclass, encryptionKey: key),
                num:  self.crypto.encrypt(plainTxt: id, encryptionKey: key),
                driver_name:  self.crypto.encrypt(plainTxt: drivername, encryptionKey: key),
                addrSt:  self.crypto.encrypt(plainTxt: addrSt, encryptionKey: key),
                addrSt2:  self.crypto.encrypt(plainTxt: addrSt2, encryptionKey: key),
                addrCity:  self.crypto.encrypt(plainTxt: addrCity, encryptionKey: key),
                addrState:  self.crypto.encrypt(plainTxt: addrState, encryptionKey: key),
                addrZip:  self.crypto.encrypt(plainTxt: addrZip, encryptionKey: key),
                addrCountry:  self.crypto.encrypt(plainTxt: addrCountry, encryptionKey: key),
                sex:  self.crypto.encrypt(plainTxt: sex, encryptionKey: key),
                height:  self.crypto.encrypt(plainTxt: height, encryptionKey: key),
                eyes:  self.crypto.encrypt(plainTxt: eyes, encryptionKey: key),
                dob:  self.crypto.encrypt(plainTxt: dob, encryptionKey: key),
                expire:  self.crypto.encrypt(plainTxt: expire, encryptionKey: key),
                issued:  self.crypto.encrypt(plainTxt: issued, encryptionKey: key),
                doc:  self.crypto.encrypt(plainTxt: doc, encryptionKey: key),
                notes:  self.crypto.encrypt(plainTxt: notes, encryptionKey: key))
            let user = Auth.auth().currentUser!
            let dbRef = Firestore.firestore()
            if (name != license?.name ?? name) {
                dbRef.collection("users").document(user.uid).collection("licenses").document(name).setData(new_license.dictionary, merge: true)
                dbRef.collection("users").document(user.uid).collection("licenses").document(license!.name).delete()
            } else {
                dbRef.collection("users").document(user.uid).collection("licenses").document(name).setData(new_license.dictionary, merge: true)
            }
            name = ""
            licenseclass = ""
            id = ""
            drivername = ""
            addrSt = ""
            addrSt2 = ""
            addrCity = ""
            addrState = ""
            addrZip = ""
            addrCountry = ""
            sex = ""
            height = ""
            eyes = ""
            dob = ""
            expire = ""
            issued = ""
            doc = ""
            notes = ""
            errTitle = "Success"
            errmsg = "Review submitted. Values will be updated upon revisit."
        }
        showAlert = true
    }
    var alert : Alert {
        Alert(title: Text(errTitle),
              message: Text(errmsg))
    }
}

struct DriverViewEdit_Previews: PreviewProvider {
    static var previews: some View {
        DriverViewEdit()
    }
}
