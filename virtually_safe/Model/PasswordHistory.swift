//
//  Movie.swift
//  MovieListApp
//
//  Created by David Phan on 4/2/21.
//

import Foundation
import SwiftUI

class PasswordHistory : ObservableObject {
    @Published var passwords = [String]()
    @Published var dates = [String]()
}

/*
 struct PasswordHistory: Identifiable, Codable, Hashable {
     var id: String = UUID().uuidString
     var passwords : [String]
     var dates : [String]
     
     var dictionary: [String : Any] {
         let data = (try? JSONEncoder().encode(self)) ?? Data()
         return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
     }
     
     enum CodingKeys: String, CodingKey {
         case id
         case passwords
         case dates
     }
 }

 class PasswordHistoryModel: ObservableObject {
     @Published var passwords = [PasswordHistory]()
     
     private var db = Firestore.firestore()
     
     func fetchData(movieTitle : String) {
         let user = Auth.auth().currentUser!
         db.collection("users").document(user.uid).collection("pw_generation")
                .document("pw_history").addSnapshotListener { (querySnapshot, error) in
             guard let documents = querySnapshot?.documents else {
                 print("No documents")
                 return
             }

             self.passwords = documents.map { queryDocumentSnapshot -> Website in
                 let data = queryDocumentSnapshot.data()
                 let pws = data["passwords"] as? String ?? ""
                 let dates = data["dates"] as? String ?? ""
                 return Website(id: .init(), passwords: pws, dates : dates)
             }
         }
     }
 }

 */
