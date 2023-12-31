//
//  MailManager.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation
import MailCore
import CoreData

class MailManager: ObservableObject {
    @Published var allInboxes: [Email] = []
    @Published var allDrafts: [Email] = []
    @Published var allSent: [Email] = []
    
    static let shared = MailManager()
    
    var dataController: DataController
    var persistenceController: PersistentController
    
    init() {
        persistenceController = PersistentController.shared
        
        let accounts = [
            Account(.icloud, username: Constants.testingUser, password: Constants.testingPwd),
            Account(.gmail, username: Constants.testingGmailUser, password: Constants.testingGmailPwd)
        ]
        
        accounts.map { account in
            // let accountEntity = AccountEntity(context: self.persistenceController.context)
        }

        dataController = DataController(context: persistenceController.context)
    }
    
    @Published var accounts: [Account] = [
        
    ]
    
    func fetchNewMail(_ folder: IMAPFolder) {
        for account in accounts {
            account.fetchFolder(folder)
        }
    }
    
    func aggregateInboxes() {
        allInboxes = accounts.flatMap { $0.inbox }
    }
    
    func aggregateSent() {
        allSent = accounts.flatMap { $0.sent }
    }
    
    func aggregateDrafts() {
        allDrafts = accounts.flatMap { $0.drafts }
    }
}
