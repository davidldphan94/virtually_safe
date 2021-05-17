//
//  DriverModel.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct DriverLicense: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name : String
    var licenseclass : String
    var num : String
    var driver_name : String
    var addrSt : String
    var addrSt2 : String
    var addrCity : String
    var addrState : String
    var addrZip : String
    var addrCountry : String
    var sex : String
    var height : String
    var eyes : String
    var dob : String
    var expire : String
    var issued : String
    var doc : String
    var notes : String
    
    var dictionary: [String : Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case licenseclass
        case num
        case driver_name
        case addrSt
        case addrSt2
        case addrCity
        case addrState
        case addrZip
        case addrCountry
        case sex
        case height
        case eyes
        case dob
        case expire
        case issued
        case doc
        case notes
    }
}

class DriverViewModel: ObservableObject {
    @Published var licenses = [DriverLicense]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid)
            .collection("licenses").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.licenses = documents.map { queryDocumentSnapshot -> DriverLicense in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let licenseclass = data["licenseclass"] as? String ?? ""
                let num = data["num"] as? String ?? ""
                let driver_name = data["driver_name"] as? String ?? ""
                let addrSt = data["addrSt"] as? String ?? ""
                let addrSt2 = data["addrSt2"] as? String ?? ""
                let addrCity = data["addrCity"] as? String ?? ""
                let addrState = data["addrState"] as? String ?? ""
                let addrZip = data["addrZip"] as? String ?? ""
                let addrCountry = data["addrCountry"] as? String ?? ""
                let sex = data["sex"] as? String ?? ""
                let height = data["height"] as? String ?? ""
                let eyes = data["eyes"] as? String ?? ""
                let dob = data["dob"] as? String ?? ""
                let expire = data["expire"] as? String ?? ""
                let issued = data["issued"] as? String ?? ""
                let doc = data["doc"] as? String ?? ""
                let notes = data["notes"] as? String ?? ""
                return DriverLicense(id: .init(), name: name, licenseclass: licenseclass, num: num, driver_name: driver_name, addrSt: addrSt, addrSt2: addrSt2 , addrCity: addrCity, addrState: addrState, addrZip: addrZip, addrCountry : addrCountry, sex: sex, height: height, eyes: eyes, dob: dob, expire: expire, issued: issued, doc: doc, notes: notes)
            }
        }
    }
}

