//
//  MailboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI

struct MailboxView: View {
    @EnvironmentObject var mailManager: MailManager
    @Binding var mailbox: [Email]
    var name: String
    var folder: IMAPFolder
    var body: some View {
        NavigationView {
            List {
                ForEach(mailbox) { email in
                    NavigationLink(destination: EmailView(email: email)) {
                        VStack(alignment: .leading) {
                            Text(email.message.header.unsafelyUnwrapped.from.displayName ?? "Unknown").font(.headline)
                            Text(email.message.header.unsafelyUnwrapped.subject ?? "No Subject").font(.body)
                        }
                        .padding(.vertical, 8)
                    }.drawingGroup()
                }
            }
            .listStyle(InsetListStyle())
            .refreshable {
                mailManager.fetchNewMail(folder)
            }
            .task {
                mailManager.fetchNewMail(folder)
            }
            
            Text("Select an email")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle(name)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Button(action: {}) {
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Button(action: {}) {
                    Image(systemName: "trash")
                }
            }
            
            ToolbarItem(placement: .principal) {
                RefreshButton(folder).environmentObject(mailManager)
            }
        }
    }
}

#Preview {
    MailboxView(mailbox: .constant(MailManager.shared.accounts.first!.inbox), name: "Inbox", folder: .inbox)
        .environmentObject(MailManager.shared)
}
