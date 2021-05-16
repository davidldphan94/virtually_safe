//
//  PasswordHistory.swift
//  virtually_safe
//
//  Created by David Phan on 5/2/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI


 class PasswordHistoryModel: ObservableObject {
     @Published var passwords = [String : String]() //PasswordHistory?
     
     private var db = Firestore.firestore()
     
     func fetchData() {
         let user = Auth.auth().currentUser!
         db.collection("users").document(user.uid).collection("generate_pwd")
            .document("pw_history").getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                for (key, value) in data! {
                    self.passwords[key] = (value as AnyObject? as? String) ?? ""
                }
            }
        }
     }
 }

 
