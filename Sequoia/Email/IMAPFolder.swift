//
//  IMAPFolder.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import Foundation

enum IMAPFolder: Equatable {
    case inbox
    case drafts
    case archive
    case sent
    case junk
    case deleted
    case custom(name: String)
    
    var displayName: String {
        switch self {
        case .inbox:
            return "Inbox"
        case .drafts:
            return "Drafts"
        case .archive:
            return "Archive"
        case .sent:
            return "Sent"
        case .junk:
            return "Junk"
        case .deleted:
            return "Trash"
        case .custom(let name):
            return name
        }
    }
}
