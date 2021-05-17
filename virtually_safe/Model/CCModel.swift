//
//  CCModel.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import RNCryptor

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
    
    private var crypto = Encryption()
    private var db = Firestore.firestore()
    
    func fetchData() {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid)
            .collection("credit_cards").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.credit_cards = documents.map { queryDocumentSnapshot -> CC in
                let data = queryDocumentSnapshot.data()
                let name = self.crypto.decrypt(encryptedMessage: data["name"] as? String ?? "", encryptionKey: key)
                let bank = self.crypto.decrypt(encryptedMessage: data["bank"] as? String ?? "", encryptionKey: key)
                let card_name = self.crypto.decrypt(encryptedMessage: data["card_name"] as? String ?? "", encryptionKey: key)
                let card_number = self.crypto.decrypt(encryptedMessage: data["card_number"] as? String ?? "", encryptionKey: key)
                let holder_name = self.crypto.decrypt(encryptedMessage: data["holder_name"] as? String ?? "", encryptionKey: key)
                let valid_thru = self.crypto.decrypt(encryptedMessage: data["valid_thru"] as? String ?? "", encryptionKey: key)
                let security_code = self.crypto.decrypt(encryptedMessage: data["security_code"] as? String ?? "", encryptionKey: key)
                let username = self.crypto.decrypt(encryptedMessage: data["username"] as? String ?? "", encryptionKey: key)
                let password = self.crypto.decrypt(encryptedMessage: data["password"] as? String ?? "", encryptionKey: key)
                let notes = self.crypto.decrypt(encryptedMessage: data["notes"] as? String ?? "", encryptionKey: key)
                return CC(id: .init(), name: name, bank: bank, card_name: card_name, card_number: card_number, holder_name: holder_name, valid_thru: valid_thru, security_code: security_code, username: username, password: password, notes: notes)
            }
        }
    }
}

