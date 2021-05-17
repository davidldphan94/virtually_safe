//
//  AboutView.swift
//  virtually_safe
//
//  Created by Kevin Kha on 5/16/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Text("About Virtually Safe").font(.title).bold()
            
            Text("This app is digital safe where users are able to keep their stored passwords in a safe place. Their information will be stored based on their log in details, so they can access it while on different devices.").padding()
            Spacer()
        }
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
