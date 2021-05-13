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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PasswordHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordHistoryView(history:["hello"])
    }
}
