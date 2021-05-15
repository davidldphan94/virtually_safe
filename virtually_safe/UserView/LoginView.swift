//
//  LoginView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/11/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

class userInfo: ObservableObject{
    @Published var email: String = ""
}

struct LoginView: View {
    @ObservedObject var info = userInfo()
    //@ObservedObject var email: userInfo
    @State var email = ""
    @State var password = ""
    @State var loginSucc = false
    @State private var loginAlert = false
    //@ObservedObject var email = ""
    
    var alert: Alert {
        Alert(title: Text("Incorrect Credentials"),
              message: Text("The username or password is incorrect."))
    }
    
    var body: some View {
        NavigationView{
            Group {
                
                if (loginSucc == true) {
                    ListView()
                } else {
                    VStack {
                        
                        Text("Virtually Safe")
                            .font(.title)
                            .bold()
                        Spacer()
                        TextField("Email", text: $email)
                            .font(.system(size: 20))
                            .padding(10)
                            //.background(Color.white)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                            //.cornerRadius(5)
                            //.padding()
                        SecureField("Password", text: $password)
                            .font(.system(size: 20))
                            .padding(10)
                            //.background(Color.white)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                            //.cornerRadius(5)
                            //.padding()
                        HStack {
                            
                            Button (action: { login() }){
                            Text("Sign in")
                            }.alert(isPresented: $loginAlert,
                                    content: { self.alert })
                            .frame(width:100, height: 30, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            
                        }
                        //Spacer()
                        
                        HStack {
                            Text("Don't have an account?")
                            NavigationLink(destination: RegisterView(), label: {
                                Text("Register")
                                    .bold()
                                    .foregroundColor(.blue)
                            })
                        }
                        .padding(.top, 50)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .phoneOnlyStackNavigationView().navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func login(){
        //Auth.auth
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                loginAlert = true
            } else {
                print("Success")
                loginSucc = true
            }
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
