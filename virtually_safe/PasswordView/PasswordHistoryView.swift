//
//  PasswordHistoryView.swift
//  virtually_safe
//
//  Created by David Phan on 5/12/21.
//

import SwiftUI

struct PasswordHistoryView: View {
    @ObservedObject var history : PasswordHistory
    
    
    let board = UIPasteboard.general
    
    var body: some View {
        VStack {
        List{
            ForEach((0..<history.passwords.count), id: \.self) {
                i in
                 HStack {
                    VStack {
                     ZStack {
                        Text(history.passwords[i])
                            .font(.headline)
                     Spacer()
                     }
                        Text(history.dates[i]) .font(.body)
                            .fontWeight(.ultraLight)
                    }
                    Spacer()
                    
                    Button(action: {
                        board.string = history.passwords[i]
                        }) {
                        Text("Copy")
                            .foregroundColor(Color.blue)
                    }
                 }
                }.onDelete(perform: deleteRow)
            }
        }.navigationBarTitle("History", displayMode: .inline).toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    history.passwords = [String]()
                    history.dates = [String]()
                }, label: {Text("Clear")
                }).padding(.trailing, 20)
            }
        }
    }
    func deleteRow(at offsets: IndexSet) {
        history.passwords.remove(atOffsets: offsets)
        history.dates.remove(atOffsets: offsets)
    }
}

//struct PasswordHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordHistoryView(
//            passwords: ["hello", "goodbye"],
//            dates: ["hello", "goodbye"])
//    }
//}
