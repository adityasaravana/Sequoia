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
    var accounts: [AccountContainer]
    
    
    init() {
        persistenceController = PersistentController.shared
        
        accounts = [
            AccountContainer(.icloud, username: Constants.testingUser, password: Constants.testingPwd),
            AccountContainer(.gmail, username: Constants.testingGmailUser, password: Constants.testingGmailPwd)
        ]
        
        accounts.map { account in
            // let accountEntity = AccountEntity(context: self.persistenceController.context)
        }

        dataController = DataController(context: persistenceController.context)
        self.startFetchingEmails()
    }
    
    fileprivate func listIMAPFolders(for account: AccountContainer, 
                                     completion: @escaping ([MCOIMAPFolder]?, Error?) -> Void) {
        let fetchOperation = account.imap.fetchAllFoldersOperation()
        fetchOperation?.start { (error, folders) in
            if let error = error {
                completion(nil, error)
                return
            }
            completion(folders, nil)
        }
    }
    
    func startFetchingEmails() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            print("Fetching new emails ...")
            guard let welf = self else {
                print("BUG: MailManager got deallocated")
                return
            }
            
            welf.fetchAllNewMail()
        }
    }
    
    func fetchAllNewMail() {
        print("Fetching new emails ...")
     
        
        for account in accounts {
            print("Processing account \(account)")
            listIMAPFolders(for: account) { folders, error in
                if let error = error {
                    print("Unable to list folders for \(account) \(error)")
                    return
                }
                
                if let folders = folders {
                    for folder in folders {
                        print("Processing folder \(String(describing: folder.path))")
                        self.dataController.fetchNewEmailsForAccount(account: account,
                                                                     with: folder.path)
                    }
                }
            }
            
        }
    }
    
    

    /*
    func aggregateInboxes() {
        allInboxes = accounts.flatMap { $0.inbox }
    }
    
    func aggregateSent() {
        allSent = accounts.flatMap { $0.sent }
    }
    
    func aggregateDrafts() {
        allDrafts = accounts.flatMap { $0.drafts }
    }
     */
}
