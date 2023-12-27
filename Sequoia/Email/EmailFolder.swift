//
//  EmailFolders.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import Foundation

enum EmailFolder {
    case inbox
    
    var name: String {
        switch self {
        case .inbox:
            return "INBOX"
        }
    }
    
    
}
