//
//  PostalService.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation
import MailCore

class PostalService: ObservableObject {
    @Published var inbox: [MCOIMAPMessage] = []
    
    static let shared = PostalService()
    
    init() {
        
    }
    
    func fetch(_ server: EmailServer, username: String, password: String, folder: String = "INBOX") {
        let session = MCOIMAPSession()
        
        session.hostname = server.hostname
        session.port     = server.port
        session.username = username
        session.password = password
        session.connectionType = .TLS
        
        let uids   = MCOIndexSet(range: MCORange(location: 1, length: UInt64.max))
        
        if let fetchOperation = session.fetchMessagesOperation(withFolder: folder, requestKind: .headers, uids: uids) {
            fetchOperation.start { error, fetchedMessages, vanishedMessages in
                // We've finished downloading the messages!
                
                // Let's check if there was an error
                if let error = error {
                    print("Error downloading message headers: \(error.localizedDescription)")
                }
                
                // And, let's print out the messages:
                print("The post man delivereth: \(fetchedMessages.debugDescription)")
                if let messages = fetchedMessages {
                    self.inbox = messages
                }
            }
        }
    }
}
