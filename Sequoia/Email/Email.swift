//
//  Email.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation
import MailCore

class Email {
    var id: UInt32
    var mailbox: Mailbox
    var message: MCOIMAPMessage
    
    var body: String = "Loading..."
    
    init(mailbox: Mailbox, message: MCOIMAPMessage) {
        self.id = message.uid
        self.mailbox = mailbox
        self.message = message
        
        self.mailbox.postalService.fetchEmailContent(of: self)
    }
    
}
