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
    
    static let shared: MailManager = {
        let instance = MailManager()
        // setup code
        return instance
    }()
    
    @Published var mailboxes: [Mailbox] = []
    
    init() {
        setupMailboxes()
    }
    
    private func setupMailboxes() {
        let mailbox = Mailbox(.icloud, username: Constants.testingUser, password: Constants.testingPwd, manager: self)
        mailboxes.append(mailbox)
    }
    
    func fetch() {
        Task {
            for mailbox in self.mailboxes {
                mailbox.refresh()
            }
        }
    }
    
    func aggregateInboxes() {
        allInboxes = mailboxes.flatMap { $0.inbox }
        printDivider()
        print(mailboxes.flatMap { $0.inbox })
        printDivider()
        print(allInboxes)
    }
}
