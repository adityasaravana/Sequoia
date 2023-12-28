//
//  RefreshButton.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import SwiftUI

struct RefreshButton: View {
    @EnvironmentObject var mailManager: MailManager
    var body: some View {
        Button {
            mailManager.fetchNewMail()
        } label: {
            Image(systemName: "tray.and.arrow.down")
        }
    }
}

#Preview {
    RefreshButton().environmentObject(MailManager.shared)
}
