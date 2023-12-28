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
    @Published var allDrafts: [Email] = []
    @Published var allSent: [Email] = []
    
    static let shared = MailManager()
    
    init() {
        
    }
    
    @Published var accounts: [Account] = [
        
    ]
    
    func fetchNewMail() {
        for account in accounts {
            account.fetchNewMail()
        }
    }
    
    func aggregateInboxes() {
        allInboxes = accounts.flatMap { $0.inbox }
    }
}
