//
//  WebsiteList.swift
//  virtually_safe
//
//  Created by David Phan on 5/16/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct WebsiteList: View {
    @ObservedObject var model = WebsiteViewModel()
    @State var addWebsite = true
    var body: some View {
        NavigationView {
            List {
                ForEach(model.websites, id: \.self) {
                    website in NavigationLink (destination: WebsiteView(website: website)) {
                    Text(website.name)
                }
                }.onDelete(perform: deleteRow)
            }.onAppear { model.fetchData()}
        }.navigationTitle("Saved Websites")
        
        
            
        
    }
    func deleteRow(at offsets: IndexSet) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser!
        let website_name = model.websites[offsets.first!].name
        db.collection("users").document(user.uid)
            .collection("websites").document(website_name).delete()
        model.websites.remove(atOffsets: offsets)
    }
}

struct WebsiteList_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteList()
    }
}
