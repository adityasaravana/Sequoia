//
//  Account.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation
import MailCore

class Account: ObservableObject {
    var server: EmailServer
    var username: String
    var password: String
    var imap: MCOIMAPSession
    
    @Published var inbox: [Email] = []
    @Published var drafts: [Email] = []
    @Published var sent: [Email] = []
    @Published var archive: [Email] = []
    @Published var junk: [Email] = []
    @Published var trash: [Email] = []
    @Published var customFolders: [String : [Email]] = [:]
    
    init(_ server: EmailServer, username: String, password: String) {
        self.server = server
        self.username = username
        self.password = password
        
        self.imap = MCOIMAPSession()
        self.imap.hostname = server.imapHostname
        self.imap.port     = server.port
        self.imap.username = username
        self.imap.password = password
        self.imap.connectionType = .TLS
        
#if DEBUG
        listIMAPFolders() { folders, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let folders = folders {
                for folder in folders {
                    print("Folder: \(folder.path)")
                }
            } else {
                print("No folders were found.")
            }
        }
#endif
    }
    
    func fetchAllFolders() {
        fetchFolder(.inbox)
        fetchFolder(.archive)
        fetchFolder(.drafts)
        fetchFolder(.deleted)
        fetchFolder(.sent)
        fetchFolder(.junk)
        
        for element in customFolders {
            fetchFolder(.custom(name: element.key))
        }
    }
    
    func reset(_ folder: IMAPFolder) {
        switch folder {
        case .inbox:
            inbox.removeAll()
        case .drafts:
            archive.removeAll()
        case .archive:
            drafts.removeAll()
        case .sent:
            trash.removeAll()
        case .junk:
            sent.removeAll()
        case .deleted:
            junk.removeAll()
        case .custom(_):
            for element in customFolders {
                customFolders[element.key] = []
            }
        }
    }
    
    func fetchFolder(_ folder: IMAPFolder) {
        let uids = MCOIndexSet(range: MCORange(location: 1, length: UInt64.max))
        
        if let fetchOperation = imap.fetchMessagesOperation(withFolder: server.folderName(for: folder), requestKind: .headers, uids: uids) {
            fetchOperation.start { error, fetchedMessages, vanishedMessages in
                // We've finished downloading the messages!
                
                // Let's check if there was an error
                if let error = error {
                    print("Error downloading message headers: \(error.localizedDescription)")
                }
                
                // And, let's print out the messages:
                print("The post man delivereth: \(fetchedMessages.debugDescription)")
                if let messages = fetchedMessages {
                    self.reset(folder)
                    for message in messages {
                        let email = Email.init(account: self, message: message)
                        
                        switch folder {
                        case .inbox:
                            self.inbox.append(email)
                        case .drafts:
                            self.drafts.append(email)
                        case .archive:
                            self.archive.append(email)
                        case .sent:
                            self.sent.append(email)
                        case .junk:
                            self.junk.append(email)
                        case .deleted:
                            self.trash.append(email)
                        case .custom(let name):
                            if self.customFolders[name] == nil {
                                self.customFolders[name] = []
                            }
                            self.customFolders[name]!.append(email)
                        }
                        
                    }
                    
                    MailManager.shared.aggregateInboxes()
                }
            }
        }
    }
}


extension Account {
    fileprivate func listIMAPFolders(completion: @escaping ([MCOIMAPFolder]?, Error?) -> Void) {
        let fetchOperation = imap.fetchAllFoldersOperation()
        fetchOperation?.start { (error, folders) in
            if let error = error {
                completion(nil, error)
                return
            }
            completion(folders, nil)
        }
    }
}
