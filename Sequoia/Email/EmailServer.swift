//
//  EmailServer.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation

enum EmailServer {
    case icloud
    
    var port: UInt32 {
        switch self {
        case .icloud:
            return 993
        }
    }
    
    var imapHostname: String {
        switch self {
        case .icloud:
            return "imap.mail.me.com"
        }
    }
    
    var smtpHostname: String {
        switch self {
        case .icloud:
            "smtp.mail.me.com"
        }
    }
    
    func folderName(for folder: IMAPFolder) -> String {
        switch self {
        case .icloud:
            switch folder {
            case .inbox:
                return "INBOX"
            case .drafts:
                return "Drafts"
            case .sent:
                return "Sent Messages"
            case .archive:
                return "Archive"
            case .junk:
                return "Junk"
            case .deleted:
                return "Deleted Messages"
            case .custom(let name):
                return name // For custom folders
            }
        }
    }
}
