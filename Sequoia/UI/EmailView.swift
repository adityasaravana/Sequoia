//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI
import MailCore
import WebKit

//class HTMLStringViewCoordinator : NSObject, WKNavigationDelegate {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        guard let url = navigationAction.request.url else {
//            decisionHandler(.allow)
//            return
//        }
//        decisionHandler(.cancel)
//        DispatchQueue.main.async { //Needs to run on the main thread to prevent UI issues
//            NSWorkspace.shared.open(url)
//        }
//    }
//}

struct HTMLStringView: NSViewRepresentable {
    let htmlContent: String
    
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
//        nsView.navigationDelegate = context.coordinator
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
//    func makeCoordinator() -> HTMLStringViewCoordinator {
//        HTMLStringViewCoordinator()
//    }
}

struct EmailView: View {
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
