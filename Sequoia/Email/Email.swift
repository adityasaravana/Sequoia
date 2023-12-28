//
//  Email.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation
import MailCore

struct Email {
    var id: UInt32
    var mailbox: Mailbox
    var message: MCOIMAPMessage
    
    init(mailbox: Mailbox, message: MCOIMAPMessage) {
        self.id = message.uid
        self.mailbox = mailbox
        self.message = message
    }
}
