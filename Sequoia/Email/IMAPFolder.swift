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
}
