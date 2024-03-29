//
//  Email.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation
import MailCore

class EmailContainer {
    var id: UInt32
    var account: AccountContainer
    var message: MCOIMAPMessage
    
    var body: String = "Loading..."
    
    init(account: AccountContainer, message: MCOIMAPMessage) {
        self.id = message.uid
        self.account = account
        self.message = message
        
        self.fetchContent()
    }
    
    func fetchContent(folder: String = "INBOX") {
        let operation = self.account.imap.fetchMessageOperation(withFolder: folder, uid: self.id)
        operation?.start { error, data in
            if let error = error {
                print(error)
            } else if let data = data, let messageParser = MCOMessageParser(data: data) {
                let htmlBody = messageParser.htmlBodyRendering()
                _ = messageParser.plainTextBodyRendering()
                
                // You can choose to return either HTML or plain text
                self.body = htmlBody ?? "nil"
            } else {
                self.body = "Failed to parse message content."
            }
        }
    }
}
