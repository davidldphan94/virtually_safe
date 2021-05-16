//
//  UserProfile.swift
//  MovieListApp
//
//  Created by David Phan on 4/30/21.
//

import Foundation
import Combine
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
    @Published var profile: UserProfile? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    private var db = Firestore.firestore()
    
    func fetchData(userID: String) {
        db.collection("users").getDocuments {(snap, error) in
            if error != nil {
                print("No documents")
                return
            }
            for i in snap!.documents {
                if i.documentID == userID {
                    let data = i.data()
                    let birthday = data["birthday"] as? String ?? "N/A"
                    let email = data["email"] as? String ?? "N/A"
                    let first_name = data["first_name"] as? String ?? "N/A"
                    let last_name = data["last_name"] as? String ?? "N/A"
                    let location = data["location"] as? String ?? "N/A"
                    let profile_pic_url = data["profile_pic_url"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    self.profile = UserProfile(id: .init(), birthday: birthday, email: email, first_name: first_name, last_name: last_name, location: location, profile_pic_url: profile_pic_url,
                        username: username)
                    return
                }
            }
        }
    }
}
