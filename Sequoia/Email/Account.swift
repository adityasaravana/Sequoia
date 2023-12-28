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
    }
    
    func fetchFolder(_ folder: String = "INBOX") {
        let uids = MCOIndexSet(range: MCORange(location: 1, length: UInt64.max))
        
        if let fetchOperation = imap.fetchMessagesOperation(withFolder: folder, requestKind: .headers, uids: uids) {
            fetchOperation.start { error, fetchedMessages, vanishedMessages in
                // We've finished downloading the messages!
                
                // Let's check if there was an error
                if let error = error {
                    print("Error downloading message headers: \(error.localizedDescription)")
                }
                
                // And, let's print out the messages:
                print("The post man delivereth: \(fetchedMessages.debugDescription)")
                if let messages = fetchedMessages {
                    
                    for message in messages {
                        let email = Email.init(account: self, message: message)
                        self.inbox.append(email)
                    }
                    
                    MailManager.shared.aggregateInboxes()
                }
            }
        }
    }
}
