//
//  PasswordHistoryView.swift
//  virtually_safe
//
//  Created by David Phan on 5/12/21.
//

import SwiftUI

struct PasswordHistoryView: View {
    @State var history : [String]
    var body: some View {
        VStack {
            Text("Password History")
                .font(.title)
                .fontWeight(.bold)
        List{
            ForEach(history, id: \.self) {
                password in
                Text(password)
                }
            }
        }
    }
}

struct PasswordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordHistoryView(history: ["hello"])
    }
}
