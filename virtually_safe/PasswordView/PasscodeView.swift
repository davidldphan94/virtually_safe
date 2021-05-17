//
//  PasscodeView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/16/21.
//

import SwiftUI

struct PasscodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var passcode = "1234"
    @State var input = ""
    @State var showAlert = false
    
    var alert : Alert {
        Alert(title: Text("Incorrect Passcode"),
              message: Text("Please re-enter the passcode"))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .lastTextBaseline){
                Text("This item is locked with a passcode. Enter it to view this saved item").frame(width: 300, height: 150, alignment: .center )
            }
            
            //Divider()
            TextField("Passcode", text: $input)
                .frame(width: 300, height: 50, alignment: .center   )
                .edgesIgnoringSafeArea(.all).padding(.leading, 20)
                .padding(.trailing, 20)
                .background(Color.gray).foregroundColor(.black)
            HStack{}.padding(.bottom, 30)
            Button(action: {
                if input == passcode {
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    showAlert = true
                }
            }, label: {
                Text("Access")
            }).alert(isPresented: $showAlert) {self.alert}
            .frame(width: 100, height: 50)
            .background(Color.green).foregroundColor(.black)
            .border(Color.black)
            Spacer()
        }
    }
}

struct PasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeView()
    }
}
