//
//  GeneratePasswordView.swift
//  virtually_safe
//
//  Created by David Phan on 5/11/21.
//

import SwiftUI

struct GeneratePasswordView: View {
    @State var passwords = [String]()
    @State var viewPasswords = false
    @State var password_length : Float = 0
    @State var pw_display = "Generate Your Password"
    @State var uppercase = false
    @State var lowercase = false
    @State var numbers = false
    @State var special_characters = false
    
    var body: some View {
        NavigationView {
            VStack() {
            HStack {
                Button(action: {generatePassword()}) {
                    Text("Generate!")
                }.padding()
                Button(action: {
                    if pw_display != "Generate Your Password" {
                        passwords.append(pw_display)
                    }
                }) {
                    Text("Save")
                }.padding()
                NavigationLink(destination:
                        PasswordHistoryView(history: passwords), isActive: $viewPasswords) { EmptyView() }
                Button(action: {viewPasswords = true}){
                    Text("History")
                }.padding()

            }.padding()
            HStack {
                Text(pw_display).italic().padding()
            }.border(Color.black)
            HStack {
                Slider(value: $password_length, in: 0...20, step: 1)
            }.padding()
            VStack {
                Toggle("Uppercase", isOn: $uppercase)
                Toggle("Lowercase", isOn: $lowercase)
                Toggle("Numbers", isOn: $numbers)
                Toggle("Special Characters", isOn: $special_characters)
            }.padding()
            Spacer()
            }.navigationTitle("Generate Password")
        }
    }
    
    func generatePassword() {
        var character_select = [String]()
        if uppercase {
            character_select.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        }
        if lowercase {
            character_select.append("abcdefghijklmnopqrstuvwxyz")
        }
        if numbers {
            character_select.append("0123456789")
        }
        if special_characters {
            character_select.append("~`!@#$%^&*()_+-={}[]|;:<>,./?")
        }
        if (character_select.count == 0) {
            pw_display = "Please select character types"
            return
        }
        var n : Float = 0
        pw_display = ""
        while n < password_length {
            let i = Int.random(in: 0..<character_select.count)
            let char_set = character_select[i]
            let j = char_set.index(char_set.startIndex,
                                offsetBy: Int.random(in:0..<char_set.count))
            let c = char_set[j]
            pw_display.append(c)
            n += 1
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
