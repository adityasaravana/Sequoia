//
//  SequoiaApp.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI

@main
struct SequoiaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MailManager.shared)
                .onAppear {
                    MailManager.shared.accounts.append(Account(.icloud, username: Constants.testingUser, password: Constants.testingPwd))
                }
        }
    }
}
