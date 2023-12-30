//
//  MailboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI

struct SharedMailboxView: View {
    @EnvironmentObject var mailManager: MailManager
    @Binding var triageContent: [Email]
    @State var mailbox: [Email] = []
    @Environment(\.openWindow) var openWindow
    
    var sharedFolder: SharedFolder
    
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
            .onAppear {
                switch sharedFolder {
                case .allInboxes:
                    self.mailbox = mailManager.allInboxes
                case .allDrafts:
                    self.mailbox = mailManager.allDrafts
                case .allSent:
                    self.mailbox = mailManager.allSent
                }
            }
            .refreshable {
                mailManager.fetchNewMail(sharedFolder.correspondingIMAPFolder)
            }
            .task {
                mailManager.fetchNewMail(sharedFolder.correspondingIMAPFolder)
            }
            
            Text("Select an email")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle(sharedFolder.displayName)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                }
            }
            
            ToolbarItem(placement: .navigation) {
                Button {
                    triageContent = mailbox
                    openWindow(id: "triage")
                } label: {
                    Image(systemName: "rectangle.stack")
                }.disabled(mailbox.isEmpty)
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
                Button {
                    mailManager.fetchNewMail(sharedFolder.correspondingIMAPFolder)
                } label: {
                    Image(systemName: "tray.and.arrow.down")
                }
            }
        }
    }
}

#Preview {
    SharedMailboxView(triageContent: .constant(MailManager.shared.allInboxes), sharedFolder: .allInboxes)
        .environmentObject(MailManager.shared)
}
