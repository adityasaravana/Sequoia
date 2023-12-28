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
    
    var postalService: PostalService!
    
    @Published var inbox: [Email] = [] {
        didSet {
            // update
        }
    }
    
    func refresh() {
        postalService.fetch(.inbox)
    }
    
    init(_ server: EmailServer, username: String, password: String) {
            self.server = server
            self.username = username
            self.password = password

            completeInitialization()
        }

        private func completeInitialization() {
            self.postalService = PostalService(self, server: self.server, username: self.username, password: self.password)
            refresh()
        }
}
