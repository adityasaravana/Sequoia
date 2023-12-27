//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI
import MailCore

struct EmailView: View {
    
    
    var message: MCOIMAPMessage
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Message Content")
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmailView(message: .init())
}
