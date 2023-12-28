//
//  RefreshButton.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import SwiftUI

struct RefreshButton: View {
    @EnvironmentObject var mailManager: MailManager
    var folder: IMAPFolder
    
    init(_ folder: IMAPFolder) {
        self.folder = folder
    }
    
    var body: some View {
        Button {
            mailManager.fetchNewMail(folder)
        } label: {
            Image(systemName: "tray.and.arrow.down")
        }
    }
}
