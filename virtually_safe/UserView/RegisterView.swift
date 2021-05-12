//
//  RegisterView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/12/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    @State private var passwordAlert = false
    @State private var emptyAlert = false
    @State private var shortpwAlert = false
    @State private var reenterpwAlert = false

    @State var finish = false
    
    
    var alert: Alert {
        Alert(title: Text("Password does not match!"),
              message: Text("Please make sure the passwords match."))
    }
    var alert2: Alert {
        Alert(title: Text("Fields Empty"),
              message: Text("Please make sure something is written in the Email, Password, or Re-enter Password fields."))
    }
    var alert3: Alert {
        Alert(title: Text("Short Password"),
              message: Text("Please enter atleast 6 characters for the password."))
    }
    var alert4: Alert {
        Alert(title: Text("Re-enter Password"),
              message: Text("Please re-enter the password."))
    }
    
    var body: some View {
        Group {
            if (finish == true) {
                CreateProfileView()//(email: self.email)
                
            } else {
                VStack{
                    Spacer()
                    Text("Create Account")
                        .font(.title)
                        .bold()
                    Spacer()
                    TextField("Email", text: $email)
                        .font(.system(size: 20))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 20))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    SecureField("Re-enter Password", text: $passwordCheck)
                        .font(.system(size: 20))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    ZStack {
                        Button (action: { signUp() }){
                        Text("Sign up")
                        }.alert(isPresented: $emptyAlert,
                                content: { self.alert2 })
                        /*
                        .alert(isPresented: $passwordAlert,
                                 content: { self.alert })
                        .alert(isPresented: $shortpwAlert,
                                 content: { self.alert3 })
                        .alert(isPresented: $reenterpwAlert,
                                 content: { self.alert4 })
                        */
                        .frame(width:100, height: 30, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                    }
                    
                    //Spacer()
                    HStack {
                        Text("Already have an account?")
                        NavigationLink(destination: LoginView(), label: {
                            Text("Log in")
                                .bold()
                                .foregroundColor(.blue)
                        })
                    }
                    .padding(.top, 50)
                    .navigationBarHidden(true)
                    Spacer()
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func signUp() {
        if ((email == "") || (password == "") || (passwordCheck == "")){
            emptyAlert = true
        }
        else if (password.count < 6){
            shortpwAlert = true
        }
        else if (passwordCheck == ""){
            reenterpwAlert = true
        }
        else if (password != passwordCheck) {
            passwordAlert = true
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password)
            Auth.auth().signIn(withEmail: email, password: password)
            finish = true
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
