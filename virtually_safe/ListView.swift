//
//  ContentView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/10/21.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: WebsiteView()){
                Text("Website View")
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                NavigationLink(destination: CCView()){
                Text("Credit Card View")
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
