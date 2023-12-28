//
//  Extensions.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import Foundation
import MailCore

public func printDivider() {
    print("-----------------------------------------------------------")
}

extension MCOIMAPMessage: Identifiable {}
extension Email: Identifiable {}
extension Email: Equatable {
    static func == (lhs: Email, rhs: Email) -> Bool {
        lhs === rhs
    }
}
