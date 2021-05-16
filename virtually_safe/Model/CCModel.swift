//
//  CCModel.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct CC: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name : String
    var bank : String
    var card_name : String
    var card_number : String
    var holder_name : String
    var valid_thru : String
    var security_code : String
    var username : String
    var password : String
    var notes : String
    
    var dictionary: [String : Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bank
        case card_name
        case card_number
        case holder_name
        case valid_thru
        case security_code
        case username
        case password
        case notes
    }
}

class CCViewModel: ObservableObject {
    @Published var credit_cards = [CC]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid)
            .collection("websites").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.credit_cards = documents.map { queryDocumentSnapshot -> CC in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let bank = data["bank"] as? String ?? ""
                let card_name = data["card_name"] as? String ?? ""
                let card_number = data["card_number"] as? String ?? ""
                let holder_name = data["holder_name"] as? String ?? ""
                let valid_thru = data["valid_thru"] as? String ?? ""
                let security_code = data["security_code"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let notes = data["notes"] as? String ?? ""
                return CC(id: .init(), name: name, bank: bank, card_name: card_name, card_number: card_number, holder_name: holder_name, valid_thru: valid_thru, security_code: security_code, username: username, password: password, notes: notes)
            }
        }
    }
}
