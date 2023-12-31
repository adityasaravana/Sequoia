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
    @Published var allInboxes: [EmailContainer] = []
    @Published var allDrafts: [EmailContainer] = []
    @Published var allSent: [EmailContainer] = []
    
    static let shared = MailManager()
    
    var dataController: DataController
    var persistenceController: PersistentController
    
    init() {
        persistenceController = PersistentController.shared
        
        let accounts = [
            AccountContainer(.icloud, username: Constants.testingUser, password: Constants.testingPwd),
            AccountContainer(.gmail, username: Constants.testingGmailUser, password: Constants.testingGmailPwd)
        ]
        
        accounts.map { account in
            // let accountEntity = AccountEntity(context: self.persistenceController.context)
        }

        dataController = DataController(context: persistenceController.context)
        self.startFetchingEmails()
    }
    
    func startFetchingEmails() {
        Timer.scheduledTimer(withTimeInterval: 60 * 5, repeats: true) { [weak self] _ in
            print("Fetching new emails ...")
            for account in self!.accounts {
                self?.dataController.fetchNewEmailsForAccount(account: account,
                                                              with: IMAPFolder.inbox.displayName)
                
            }
        }
    }
    
    @Published var accounts: [AccountContainer] = [
        
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
