//
//  SequoiaApp.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI

@main
struct SequoiaApp: App {
    // IMPORTANT: Ensure Persistent controller is loaded and initialized here
    let persistenceController = PersistentController.shared

    var body: some Scene {
        Group {
            WindowGroup {
                MailView()
                    .environmentObject(MailManager.shared)
            }
            Window("Triage", id: "triage") {
                TriageView()
            }
        }
        .environment(\.managedObjectContext, PersistentController.shared.context)
    }
}
