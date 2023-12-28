//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI
import WebKit
import MailCore
import WebViewKit

struct HTMLStringView: NSViewRepresentable {
    let htmlContent: String

    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct EmailView: View {
    @EnvironmentObject var postalService: PostalService
    @State var messageBody: String = "Loading body..."
    
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
