//
//  SequoiaApp.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI

@main
struct SequoiaApp: App {
    @State var triageContent: [Email] = []
    var body: some Scene {
        WindowGroup {
            MailView(triageContent: $triageContent)
                .environmentObject(MailManager.shared)
                .onAppear {
                    MailManager.shared.accounts.append(Account(.icloud, username: Constants.testingUser, password: Constants.testingPwd))
                    MailManager.shared.accounts.append(Account(.gmail, username: Constants.testingGmailUser, password: Constants.testingGmailPwd))
                }
        }
        Window("Triage", id: "triage") {
            TriageView(emails: $triageContent)
        }
    }
}
