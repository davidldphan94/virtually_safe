//
//  PasswordHistoryView.swift
//  virtually_safe
//
//  Created by David Phan on 5/12/21.
//

import SwiftUI

struct PasswordHistoryView: View {
    @ObservedObject var history : PasswordHistory
    @State var viewvault = false
    @State var viewsettings = false
    
    let board = UIPasteboard.general
    
    var body: some View {
        VStack {
        List{
            ForEach((0..<history.passwords.count), id: \.self) {
                i in
                 HStack {
                    VStack(alignment: .leading) {
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
        }.navigationBarTitle("History", displayMode: .inline)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action: {
                        history.passwords = [String]()
                        history.dates = [String]()
                    }, label: {Text("Clear")
                    }).padding(.trailing, 20)
                }
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    NavigationLink(destination: WebsiteView(), isActive: $viewvault){ EmptyView() }
                    Button(action: {viewvault = true}){
                        Image(systemName: "key.fill").resizable().frame(width: 42, height: 50)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {}){
                        Image(systemName: "lock.rotation")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView(), isActive: $viewsettings){ EmptyView() }
                    Button(action: {viewsettings = true}){
                        Image(systemName: "gearshape.fill").resizable().frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    }
                    Spacer()
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
