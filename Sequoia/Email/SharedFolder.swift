//
//  SharedFolder.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import Foundation

enum SharedFolder {
    case allInboxes
    case allDrafts
    case allSent
    
    var displayName: String {
        switch self {
        case .allInboxes:
            return "All Inboxes"
        case .allDrafts:
            return "All Drafts"
        case .allSent:
            return "All Sent"
        }
    }
    
    var correspondingIMAPFolder: IMAPFolder {
        switch self {
        case .allInboxes:
            return .inbox
        case .allDrafts:
            return .drafts
        case .allSent:
            return .sent
        }
    }
}
