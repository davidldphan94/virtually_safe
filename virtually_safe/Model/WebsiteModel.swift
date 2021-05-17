//
//  WebsiteModel.swift
//  MovieListApp
//
//  Created by David Phan on 5/14/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Website: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name : String
    var url : String
    var username : String
    var password : String
    var notes : String
    var fav : Bool
    
    var dictionary: [String : Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case username
        case password
        case notes
        case fav
    }
}

class WebsiteViewModel: ObservableObject {
    @Published var websites = [Website]()
    
    private var crypto = Encryption()
    private var db = Firestore.firestore()
    
    func fetchData() {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid)
            .collection("websites").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            self.websites = documents.map { queryDocumentSnapshot -> Website in
                let data = queryDocumentSnapshot.data()
                let name = self.crypto.decrypt(encryptedMessage: data["name"] as? String ?? "", encryptionKey: key)
                let url = self.crypto.decrypt(encryptedMessage: data["url"] as? String ?? "", encryptionKey: key)
                let username = self.crypto.decrypt(encryptedMessage: data["username"] as? String ?? "", encryptionKey: key)
                let password = self.crypto.decrypt(encryptedMessage: data["password"] as? String ?? "", encryptionKey: key)
                let notes = self.crypto.decrypt(encryptedMessage: data["notes"] as? String ?? "", encryptionKey: key)
                let fav = data["fav"] as? Bool ?? false
                return Website(id: .init(), name: name, url: url, username: username, password: password, notes: notes, fav: fav)
            }
        }
    }
}
