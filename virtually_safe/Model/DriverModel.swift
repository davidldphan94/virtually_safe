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
    var fav : Bool
    
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
        case fav
    }
}

class DriverViewModel: ObservableObject {
    @Published var licenses = [DriverLicense]()
    
    private var crypto = Encryption()
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
                let name = self.crypto.decrypt(encryptedMessage: data["name"] as? String ?? "", encryptionKey: key)
                let licenseclass = self.crypto.decrypt(encryptedMessage: data["licenseclass"] as? String ?? "", encryptionKey: key)
                let num = self.crypto.decrypt(encryptedMessage: data["num"] as? String ?? "", encryptionKey: key)
                let driver_name = self.crypto.decrypt(encryptedMessage: data["driver_name"] as? String ?? "", encryptionKey: key)
                let addrSt = self.crypto.decrypt(encryptedMessage: data["addrSt"] as? String ?? "", encryptionKey: key)
                let addrSt2 = self.crypto.decrypt(encryptedMessage: data["addrSt2"] as? String ?? "", encryptionKey: key)
                let addrCity = self.crypto.decrypt(encryptedMessage: data["addrCity"] as? String ?? "", encryptionKey: key)
                let addrState = self.crypto.decrypt(encryptedMessage: data["addrState"] as? String ?? "", encryptionKey: key)
                let addrZip = self.crypto.decrypt(encryptedMessage: data["addrZip"] as? String ?? "", encryptionKey: key)
                let addrCountry = self.crypto.decrypt(encryptedMessage: data["addrCountry"] as? String ?? "", encryptionKey: key)
                let sex = self.crypto.decrypt(encryptedMessage: data["sex"] as? String ?? "", encryptionKey: key)
                let height = self.crypto.decrypt(encryptedMessage: data["height"] as? String ?? "", encryptionKey: key)
                let eyes = self.crypto.decrypt(encryptedMessage: data["eyes"] as? String ?? "", encryptionKey: key)
                let dob = self.crypto.decrypt(encryptedMessage: data["dob"] as? String ?? "", encryptionKey: key)
                let expire = self.crypto.decrypt(encryptedMessage: data["expire"] as? String ?? "", encryptionKey: key)
                let issued = self.crypto.decrypt(encryptedMessage: data["issued"] as? String ?? "", encryptionKey: key)
                let doc = self.crypto.decrypt(encryptedMessage: data["doc"] as? String ?? "", encryptionKey: key)
                let notes = self.crypto.decrypt(encryptedMessage: data["notes"] as? String ?? "", encryptionKey: key)
                let fav = data["fav"] as? Bool ?? false
                return DriverLicense(id: .init(), name: name, licenseclass: licenseclass, num: num, driver_name: driver_name, addrSt: addrSt, addrSt2: addrSt2 , addrCity: addrCity, addrState: addrState, addrZip: addrZip, addrCountry : addrCountry, sex: sex, height: height, eyes: eyes, dob: dob, expire: expire, issued: issued, doc: doc, notes: notes, fav: fav)
            }
        }
    }
}

