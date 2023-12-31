//
//  EmailServer.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation

enum EmailServer {
    case icloud
    case gmail
    case custom(config: CustomEmailServerConfiguration)
    
    var port: UInt32 {
        switch self {
        case .icloud:
            return 993
        case .gmail:
            return 993
        case .custom(config: let config):
            return config.port
        }
    }
    
    var imapHostname: String {
        switch self {
        case .icloud:
            return "imap.mail.me.com"
        case .gmail:
            return "imap.gmail.com"
        case .custom(config: let config):
            return config.imapHostname
        }
    }
    
    var displayName: String {
        switch self {
        case .icloud:
            return "iCloud"
        case .gmail:
            return "Gmail"
        case .custom(config: let config):
            return config.displayName
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
            
            
            //Folder: Optional("INBOX")
            //Folder: Optional("[Gmail]")
            //Folder: Optional("[Gmail]/All Mail")
            //Folder: Optional("[Gmail]/Drafts")
            //Folder: Optional("[Gmail]/Important")
            //Folder: Optional("[Gmail]/Sent Mail")
            //Folder: Optional("[Gmail]/Spam")
            //Folder: Optional("[Gmail]/Starred")
            //Folder: Optional("[Gmail]/Trash")

        case .gmail:
            switch folder {
            case .inbox:
                return "INBOX"
            case .drafts:
                return "[Gmail]/Drafts"
            case .sent:
                return "[Gmail]/Sent Mail"
            case .archive:
                return "[Gmail]/All Mail"
            case .junk:
                return "[Gmail]/Spam"
            case .deleted:
                return "[Gmail]/Trash"
            case .custom(let name):
                return name // For custom folders
            }
        case .custom(config: _):
            switch folder {
            case .inbox:
                return "INBOX"
            case .drafts:
                return ""
            case .sent:
                return ""
            case .archive:
                return ""
            case .junk:
                return ""
            case .deleted:
                return ""
            case .custom(let name):
                return name // For custom folders
            }
        }
    }
    
    struct CustomEmailServerConfiguration {
        var imapHostname: String
        var port: UInt32
        var displayName: String
    }
}

