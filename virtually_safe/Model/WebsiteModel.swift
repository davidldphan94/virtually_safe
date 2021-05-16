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
    }
}

class WebsiteViewModel: ObservableObject {
    @Published var websites = [Website]()
    
    private var db = Firestore.firestore()
    
    func fetchData(movieTitle : String) {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid).collection("").document(movieTitle)
          .collection("reviews").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.websites = documents.map { queryDocumentSnapshot -> Website in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let url = data["url"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let notes = data["notes"] as? String ?? ""
                return Website(id: .init(), name: name, url: url, username: username, password: password, notes: notes)
            }
        }
    }
}
