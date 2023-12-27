//
//  EmailServer.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation

enum EmailServer {
    case gmail
    case icloud
    
    var port: UInt32 {
        switch self {
        case .gmail:
            return 993
        case .icloud:
            return 993
        }
    }
    
    var hostname: String {
        switch self {
        case .gmail:
            return "imap.gmail.com"
        case .icloud:
            return "imap.mail.me.com"
        }
    }
    
    
}