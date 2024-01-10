//
//  Account.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation
import MailCore

struct CustomFolder: Identifiable {
    let id = UUID()
    
    var name: String
    var folder: [EmailContainer]
}

class AccountContainer: ObservableObject, Identifiable {
    var displayName: String
    var server: EmailServer
    var username: String
    var password: String
    var imap: MCOIMAPSession
    
    @Published var customFolders: [CustomFolder] = []
    
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
        
        self.displayName = server.displayName
    }
}


extension AccountContainer {

}
