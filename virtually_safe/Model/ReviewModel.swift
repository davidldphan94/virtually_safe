//
//  ReviewModel.swift
//  MovieListApp
//
//  Created by David Phan on 4/30/21.
//

import Foundation
import FirebaseFirestore

struct Review: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var movie_title: String
    var name: String
    var title: String
    var review_text: String
    
    var dictionary: [String : Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] ?? [:]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case movie_title
        case name
        case title
        case review_text
    }
}

class ReviewsViewModel: ObservableObject {
    @Published var reviews = [Review]()
    
    private var db = Firestore.firestore()
    
    func fetchData(movieTitle : String) {
        db.collection("users").document("").collection("").document(movieTitle)
          .collection("reviews").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.reviews = documents.map { queryDocumentSnapshot -> Review in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let movie_title = data["movie_title"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let review_text = data["review_text"] as? String ?? ""
                return Review(id: .init(), movie_title: movie_title, name: name, title: title, review_text: review_text)
            }
        }
    }
}
