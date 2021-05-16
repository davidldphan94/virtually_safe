//
//  PasswordHistoryView.swift
//  virtually_safe
//
//  Created by David Phan on 5/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct PasswordHistoryView: View {
    @ObservedObject var history : PasswordHistoryModel//PasswordHistory
    @State var viewvault = false
    @State var viewsettings = false
    
    let board = UIPasteboard.general
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser!
    
    var body: some View {
        VStack {
            List{
                ForEach(Array(history.passwords.keys).sorted(by: >), id: \.self) {
                    date in
                     HStack {
                        VStack(alignment: .leading) {
                         ZStack {
                            Text(history.passwords[date]!)
                                .font(.headline)
                         Spacer()
                         }
                            Text(date) .font(.body)
                                .fontWeight(.ultraLight)
                        }
                        Spacer()
                        
                        Button(action: {
                            board.string = history.passwords[date]
                            }) {
                            Text("Copy")
                                .foregroundColor(Color.blue)
                        }
                     }
                    }.onDelete(perform: deleteRow)
                }
            }.navigationBarTitle("History", displayMode: .inline)
                .toolbar{
                    //DO NOT REMOVE! THIS KEEPS THE BACK BUTTON PRESENT AFTER HITTING THE CLEAR BUTTON
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {}
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {
                            history.passwords = [String : String]()
                            db.collection("users").document(user.uid)
                                .collection("generate_pwd")
                                .document("pw_history").delete()
                        }, label: {Text("Clear")
                        }).padding(.trailing, 20)
                    }
            }
    }
    func deleteRow(at offsets: IndexSet) {
        let key = Array(history.passwords.keys).sorted(by: >)[offsets.first!]
        history.passwords.removeValue(forKey: key)
        db.collection("users").document(user.uid)
            .collection("generate_pwd")
            .document("pw_history").updateData([key : FieldValue.delete()])
        
    }
}

//struct PasswordHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordHistoryView(
//            passwords: ["hello", "goodbye"],
//            dates: ["hello", "goodbye"])
//    }
//}
