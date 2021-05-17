//
//  DriverViewEdit.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/15/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

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
                    TextField("MM/DD/YYYY", text: $expire).edgesIgnoringSafeArea(.all).fixedSize(horizontal: false, vertical: true)
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
            let new_license = DriverLicense(id: .init(), name: name, licenseclass: licenseclass, num: id, driver_name: drivername, addrSt: addrSt, addrSt2: addrSt2 , addrCity: addrCity, addrState: addrState, addrZip: addrZip, addrCountry : addrCountry, sex: sex, height: height, eyes: eyes, dob: dob, expire: expire, issued: issued, doc: doc, notes: notes)
            let user = Auth.auth().currentUser!
            let dbRef = Firestore.firestore()
            if (name != license?.name ?? name) {
                dbRef.collection("users").document(user.uid).collection("licenses").document(name).setData(new_license.dictionary, merge: true)
                dbRef.collection("users").document(user.uid).collection("licenses").document(license!.name).delete()
            } else {
                dbRef.collection("users").document(user.uid).collection("licenses").document(new_license.name).setData(new_license.dictionary, merge: true)
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
