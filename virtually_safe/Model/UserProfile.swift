//
//  UserProfile.swift
//  MovieListApp
//
//  Created by David Phan on 4/30/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore

struct UserProfile: Encodable, Identifiable {
    var id: String = UUID().uuidString
    let birthday: String
    let email: String
    let first_name: String
    let last_name: String
    let location: String
    let profile_pic_url: String
    let username: String
    
    var dictionary: [String : Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case birthday
        case email
        case first_name
        case last_name
        case location
        case profile_pic_url
        case username
    }
    
}

class UserProfileViewModel :ObservableObject {
    var didChange = PassthroughSubject<UserProfileViewModel, Never>()
    @Published var profile = [String: String]()
    
    private var db = Firestore.firestore()
    
    func fetchData(userID: String) {
        let user = Auth.auth().currentUser!
        db.collection("users").document(user.uid).collection("settings")
            .document("user_info").getDocument {(document, error) in
            if error != nil {
                print("No documents")
                return
            }
               
                if let document = document, document.exists {
                    let data = document.data()
                    for (key, value) in data! {
                        self.profile[key] = (value as AnyObject? as? String) ?? "N/A"
                    }
                }
        }
    }
}
