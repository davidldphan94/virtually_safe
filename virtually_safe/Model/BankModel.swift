//
//  BankModel.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Bank: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name : String
    var bank_name : String
    var type : String
    var routing_number : String
    var account_number : String
    var pin : String
    var notes : String
    
    var dictionary: [String : Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bank_name
        case type
        case routing_number
        case account_number
        case pin
        case notes
    }
}

class BankViewModel: ObservableObject {
    @Published var bank_info = [Bank]()
    
    private var db = Firestore.firestore()
    private var crypto = Encryption()
    
    func fetchData() {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid)
            .collection("banks").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            self.bank_info = documents.map { queryDocumentSnapshot -> Bank in
                let data = queryDocumentSnapshot.data()
                let name = self.crypto.decrypt(encryptedMessage: data["name"] as? String ?? "", encryptionKey: key)
                let bank = self.crypto.decrypt(encryptedMessage: data["bank_name"] as? String ?? "", encryptionKey: key)
                let type = self.crypto.decrypt(encryptedMessage: data["type"] as? String ?? "", encryptionKey: key)
                let routing_number = self.crypto.decrypt(encryptedMessage: data["routing_number"] as? String ?? "", encryptionKey: key)
                let account_number = self.crypto.decrypt(encryptedMessage:data["account_number"] as? String ?? "", encryptionKey: key)
                let pin = self.crypto.decrypt(encryptedMessage:data["pin"] as? String ?? "", encryptionKey: key)
                let notes = self.crypto.decrypt(encryptedMessage:data["notes"] as? String ?? "", encryptionKey: key)
                return Bank(id: .init(), name: name, bank_name: bank, type: type, routing_number: routing_number, account_number: account_number, pin: pin, notes: notes)
            }
        }
    }
}
