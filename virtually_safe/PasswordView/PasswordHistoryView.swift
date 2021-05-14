//
//  PasswordHistoryView.swift
//  virtually_safe
//
//  Created by David Phan on 5/12/21.
//

import SwiftUI

struct PasswordHistoryView: View {
    @State var history : [String]
    var body: some View {
        VStack {
        List{
            ForEach(history, id: \.self) {
                password in
                Text(password)
                }.onDelete(perform: deleteRow)
            }
        }.navigationBarTitle("History", displayMode: .inline).toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {history = [String]()}, label: {Text("Clear")
                }).padding(.trailing, 20)
            }
        }
    }
    func deleteRow(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
    }
}

struct PasswordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordHistoryView(history: ["hello"])
    }
}
