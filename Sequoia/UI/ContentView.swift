//
//  ContentView.swift
//  Mail
//
//  Created by Jordan Singer on 6/27/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mailManager: MailManager
    @State var selection: Set<Int> = [0]
    
    var body: some View {
        NavigationView {
            List(selection: self.$selection) {
                NavigationLink(destination: SharedMailboxView(sharedFolder: .allInboxes).environmentObject(mailManager)) {
                    Label("All Inboxes", systemImage: "tray.2")
                }
                .tag(0)
                NavigationLink(destination: SharedMailboxView(sharedFolder: .allDrafts).environmentObject(mailManager)) {
                    Label("All Drafts", systemImage: "doc.on.doc")
                }
                NavigationLink(destination: SharedMailboxView(sharedFolder: .allSent).environmentObject(mailManager)) {
                    Label("All Sent", systemImage: "paperplane")
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            
            Text("Select an email")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView().environmentObject(MailManager())
}
