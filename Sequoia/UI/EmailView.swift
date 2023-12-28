//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI
import MailCore
import WebViewKit

struct EmailView: View {
    @EnvironmentObject var postalService: PostalService
    @State var messageBody: String = "Loading body..."
    
    var email: Email
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                WebView(htmlString: email.body)
                
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
