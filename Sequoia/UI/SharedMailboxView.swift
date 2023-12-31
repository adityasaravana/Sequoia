//
//  MailboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI

struct SharedMailboxView: View {
    @EnvironmentObject var mailManager: MailManager
    
    // TODO: Add filters for triage content
    @FetchRequest(entity: Email.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Email.sentDate, ascending: true)])
    var triageContent: FetchedResults<Email>
    
    // TODO: Add appropriate predictes, example:
    // predicate: NSPredicate(format: "c == %@", "value"))

    @FetchRequest(entity: Email.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Email.sentDate, ascending: true)])
    var mailbox: FetchedResults<Email>

    
    @Environment(\.openWindow) var openWindow
    
    var sharedFolder: SharedFolder
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mailbox) { email in
                    NavigationLink(destination: EmailView(emailEntity: email)) {
                        VStack(alignment: .leading) {
                            Text(email.sender ?? "Unknown").font(.headline)
                            Text(email.subject ?? "No Subject").font(.body)
                        }
                        .padding(.vertical, 8)
                    }.drawingGroup()
                }
            }
            .listStyle(InsetListStyle())
            .onAppear {
                /*
                 // TODO: Assign mailbox filter on appear?
                switch sharedFolder {
                case .allInboxes:
                    self.mailbox = mailManager.allInboxes
                case .allDrafts:
                    self.mailbox = mailManager.allDrafts
                case .allSent:
                    self.mailbox = mailManager.allSent
                }
                 */
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
                    //
                    // TODO: This should update filters?
                    // triageContent = mailbox
                    //
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

/*
 #Preview {
 // TODO:
 // SharedMailboxView(triageContent: .constant(MailManager.shared.allInboxes), sharedFolder: .allInboxes)
 //    .environmentObject(MailManager.shared)
 }
 */
