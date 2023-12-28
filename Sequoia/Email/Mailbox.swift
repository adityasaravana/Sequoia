//
//  Account.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation
import MailCore

class Mailbox: ObservableObject {
    var server: EmailServer
    
    var username: String
    var password: String
    
    var postalService: PostalService
    var manager: MailManager
    
    @Published var inbox: [MCOIMAPMessage] = [] {
        didSet {
            // update inbox
        }
    }
    
    func refresh() {
            inbox = postalService.fetch(.inbox) ?? []
            printDivider()
            print(inbox)
        manager.aggregateInboxes()
        
    }
    
    init(_ server: EmailServer, username: String, password: String, manager: MailManager) {
        self.manager = manager
        self.server = server
        self.username = username
        self.password = password
        
        self.postalService = PostalService(server: self.server, username: self.username, password: self.password)
        
        refresh()
    }
}
