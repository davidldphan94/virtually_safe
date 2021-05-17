//
//  SearchBar.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/17/21.
//

import SwiftUI

struct SearchBar: View {
    //@Binding var text: String
    @Binding var searchText:String
    @Binding var searching:Bool
    
    var body: some View {
         HStack{
             HStack{
                 TextField("Search...", text: $searchText).padding(.leading, 24)
             }.padding().background(Color(.systemGray5)).cornerRadius(8).padding(.leading, 5)
             .autocapitalization(.none)
             .onTapGesture(perform: {
                 searching = true
             })
             .overlay(
                 HStack{
                     Image(systemName: "magnifyingglass")
                     Spacer()
                     
                     if searching{
                         Button(action: {searchText = "" }, label: {
                             Image(systemName: "xmark.circle.fill").padding(.vertical)
                         })
                     }
                 }.padding(.horizontal,20).foregroundColor(.gray)
             ).transition(.move(edge: .trailing)).animation(.spring())
             
             if searching{
                 Button(action: {
                     searching = false
                     searchText = ""
                     UIApplication.shared.sendAction(#selector(UIResponder .resignFirstResponder), to: nil, from: nil, for: nil)
                 }, label: {
                     Text("Cancel").padding(.trailing).padding(.leading, 0)
                 }).transition(.move(edge: .trailing)).animation(.spring())
             }
         }
 
    }
}
/*
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
*/
