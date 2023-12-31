//
//  ContentView.swift
//  Mail
//
//  Created by Jordan Singer on 6/27/20.
//

import SwiftUI

struct MailView: View {
    @EnvironmentObject var mailManager: MailManager
    @State var selection: Set<Int> = [0]
    
    // TODO: Add appropriate filters for triage content
    @FetchRequest(entity: EmailEntity.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \EmailEntity.sentDate, ascending: true)])
    var triageContent: FetchedResults<EmailEntity>
    
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
                
                ForEach(mailManager.accounts) { account in
                    Section(account.displayName) {
                        NavigationLink(destination: AccountMailboxView(account: account, folder: .inbox)) {
                            Label("Inbox", systemImage: "tray")
                        }
                        NavigationLink(destination: AccountMailboxView(account: account, folder: .drafts)) {
                            Label("Drafts", systemImage: "doc")
                        }
                        NavigationLink(destination: AccountMailboxView(account: account, folder: .sent)) {
                            Label("Sent", systemImage: "paperplane")
                        }
                        NavigationLink(destination: AccountMailboxView(account: account, folder: .junk)) {
                            Label("Junk", systemImage: "xmark.bin")
                        }
                        NavigationLink(destination: AccountMailboxView(account: account, folder: .deleted)) {
                            Label("Trash", systemImage: "trash")
                        }
                        NavigationLink(destination: AccountMailboxView(account: account, folder: .archive)) {
                            Label("Archive", systemImage: "archivebox")
                        }
                        
                        ForEach(account.customFolders) { value in
                            NavigationLink(destination: AccountMailboxView(account: account, folder: .custom(name: value.name))) {
                                Label(value.name, systemImage: "folder")
                            }
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            
            Text("Select an email")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
