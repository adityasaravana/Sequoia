//
//  MailManager.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation
import MailCore

class MailManager: ObservableObject {
    @Published var allInboxes: [MCOIMAPMessage] = []
    
    static let shared = MailManager()
    
    @Published var mailboxes: [Mailbox] = [
        Mailbox(.icloud, username: Constants.testingUser, password: Constants.testingPwd)
    ]
    
    func fetch() {
        Task {
            for mailbox in self.mailboxes {
                mailbox.refresh()
            }
        }
    }
    
    func aggregateInboxes() {
        allInboxes = mailboxes.flatMap { $0.inbox }
    }
}
