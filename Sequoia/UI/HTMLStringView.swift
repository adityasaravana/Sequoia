//
//  HTMLStringView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI
import WebKit

struct HTMLStringView: NSViewRepresentable {
    let htmlContent: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.setValue(false, forKey: "drawsBackground")
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        let styledHtml = addDefaultStyling(to: htmlContent)
        nsView.loadHTMLString(styledHtml, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Add default styling to HTML content
    private func addDefaultStyling(to html: String) -> String {
        let cssStyle = """
        <style>
        body {
            background-color: transparent; /* Remove white background */
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; /* Apple's default system font */
            color: #333333; /* Text color */
            padding: 10px; /* Padding around the content */
        }
        </style>

        """

        return cssStyle + html
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLStringView

        init(_ parent: HTMLStringView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, navigationAction.navigationType == .linkActivated {
                NSWorkspace.shared.open(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}
