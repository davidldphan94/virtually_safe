//
//  GeneratePasswordView.swift
//  virtually_safe
//
//  Created by David Phan on 5/11/21.
//

import SwiftUI

struct GeneratePasswordView: View {
    @ObservedObject var password_history = PasswordHistory()
    @State var viewPasswords = false
    @State private var password_length : Float = 0
    @State var pw_display = "Generate Your Password"
    @State var uppercase = false
    @State var lowercase = false
    @State var numbers = false
    @State var special_characters = false
    
    let board = UIPasteboard.general
    
    var body: some View {
        //NavigationView {
            VStack() {
            HStack {
                Button(action: {
                    generatePassword()
                    if pw_display != "Please select character types" &&
                        pw_display != "Invalid password length"{
                        let currentDateTime = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeStyle = .medium
                        dateFormatter.dateStyle = .long
                        let date = dateFormatter.string(from: currentDateTime)
                        password_history.passwords.insert(pw_display, at: 0)
                        password_history.dates.insert(date, at: 0)
                    }
                    
                }) {
                    Text("Generate!")
                }.padding(.leading, 50)
                Spacer()
                Button(action: {
                    if (pw_display != "Generate Your Password" ||
                        pw_display != "Please select character types" ||
                        pw_display != "Invalid password length"){
                        board.string = pw_display
                    }
                }) {
                    Text("Save")
                }
                Spacer()
                NavigationLink(destination:
                                PasswordHistoryView(history: password_history), isActive: $viewPasswords) { EmptyView() }
                Button(action: {viewPasswords = true}){
                    Text("History")
                }.padding(.trailing, 50)

            }.padding()
            HStack {
                Text(pw_display).italic().padding()
            }.border(Color.black)
            HStack {
                Text("Length ")
                Slider(value: $password_length, in: 0...32, step: 1)
                Text("\(Int(password_length))")
            }.padding()
            VStack {
                Toggle("Uppercase", isOn: $uppercase)
                Toggle("Lowercase", isOn: $lowercase)
                Toggle("Numbers", isOn: $numbers)
                Toggle("Special Characters", isOn: $special_characters)
            }.padding()
            Spacer()
            Divider()
            HStack{
                NavigationLink(destination: WebsiteView()){
                    Image(systemName: "key.fill").resizable().frame(width: 20, height: 30)
                        .foregroundColor(.gray)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }
                Divider()
                Button(action: {}, label: {
                    Image(systemName: "lock.rotation").resizable().frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                })
                    
                
                Divider()
                Image(systemName: "person.crop.circle").resizable().frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
            }.frame(width: 350, height: 40, alignment: .center)
            }.navigationBarTitle("Generate Password", displayMode: .inline)
            .navigationBarBackButtonHidden(false)
        //}
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
        if (password_length == 0) {
            pw_display = "Invalid password length"
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
