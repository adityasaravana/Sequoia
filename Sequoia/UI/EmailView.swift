//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI
import MailCore

struct EmailView: View {
    var email: Email
    
    var body: some View {
        VStack {
            EmailBodyView(email: email)
        }
    }
}

struct EmailBodyView: View {
    var email: Email
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HTMLStringView(htmlContent: email.body)
                
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
