//
//  MailManager.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation
import MailCore

class MailManager: ObservableObject {
    @Published var allInboxes: [Email] = []
    
    static let shared = MailManager()
    
    init() {
        
    }
    
    @Published var mailboxes: [Mailbox] = [
        
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
