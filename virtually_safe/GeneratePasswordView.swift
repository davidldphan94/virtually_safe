//
//  GeneratePasswordView.swift
//  virtually_safe
//
//  Created by David Phan on 5/11/21.
//

import SwiftUI

struct GeneratePasswordView: View {
    @State var pw_display = "Generate Your Password"
    @State var uppercase = false
    @State var lowercase = false
    @State var numbers = false
    @State var special_characters = false
    
    var body: some View {
        NavigationView {
            VStack() {
            HStack {
                Button(action: {}) {
                    Text("Clear")
                }.padding()
                Button(action: {}) {
                    Text("Copy")
                }.padding()
                Button(action: {}) {
                    Text("History")
                }.padding()
            }
            HStack {
                Text(pw_display).italic().padding()
            }.border(Color.black)
            HStack {
                Text("Uppercase")
                
            }
            HStack {
                Text("Lowercase")
            }
            HStack {
                Text("Numbers")
            }
            HStack {
                Text("Special Characters")
            }
            Spacer()
            
            }.navigationTitle("Generate Password")
        }
    }
}

struct GeneratePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GeneratePasswordView()
        }
    }
}
