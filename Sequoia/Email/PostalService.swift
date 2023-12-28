//
//  PostalService.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation
import MailCore

class PostalService: ObservableObject {
    
    var server: EmailServer
    var username: String
    var password: String
    var session: MCOIMAPSession
    var mailManager: MailManager = MailManager.shared
    
    
    
    init(server: EmailServer, username: String, password: String) {
        self.server = server
        self.username = username
        self.password = password
        
        session = MCOIMAPSession()
        session.hostname = server.hostname
        session.port     = server.port
        session.username = username
        session.password = password
        session.connectionType = .TLS
    }
    
    func fetchEmailContent(of message: MCOIMAPMessage, folder: String = "INBOX", completion: @escaping (String?, Error?) -> Void) {
            let operation = session.fetchMessageOperation(withFolder: folder, uid: message.uid)
            operation?.start { error, data in
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let messageParser = MCOMessageParser(data: data) {
                    let htmlBody = messageParser.htmlBodyRendering()
                    let plainTextBody = messageParser.plainTextBodyRendering()
                    
                    // You can choose to return either HTML or plain text
                    completion(htmlBody ?? plainTextBody, nil)
                } else {
                    completion(nil, NSError(domain: "PostalServiceError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse message content."]))
                }
            }
        }
    
    func fetch(_ folder: EmailFolder) -> [MCOIMAPMessage]? {
        let uids = MCOIndexSet(range: MCORange(location: 1, length: UInt64.max))
        var returnVal: [MCOIMAPMessage]? = nil
        
        if let fetchOperation = session.fetchMessagesOperation(withFolder: folder.name, requestKind: .headers, uids: uids) {
            fetchOperation.start { error, fetchedMessages, vanishedMessages in
                // We've finished downloading the messages!
                
                // Let's check if there was an error
                if let error = error {
                    print("Error downloading message headers: \(error.localizedDescription)")
                }
                
                // And, let's print out the messages:
                print("The post man delivereth: \(fetchedMessages.debugDescription)")
                if let messages = fetchedMessages {
                    returnVal = messages
                }
                self.mailManager.aggregateInboxes()
            }
        }
        
        return returnVal
    }
}
