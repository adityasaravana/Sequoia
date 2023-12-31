//
//  AccountMailboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI
import CoreData

struct AccountMailboxView: View {
    @ObservedObject var account: Account
    
    @FetchRequest(entity: EmailEntity.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \EmailEntity.sentDate, ascending: true)])
    var emails: FetchedResults<EmailEntity>
    
    
    var folder: IMAPFolder
    
    func updateEmails() {
        /*
         
         TODO: Here we need to call MailManager to call DataController to refresh
        switch folder {
        case .inbox:
            emails = account.inbox
        case .drafts:
            emails = account.drafts
        case .archive:
            emails = account.archive
        case .sent:
            emails = account.sent
        case .junk:
            emails = account.junk
        case .deleted:
            emails = account.trash
        case .custom(let name):
            emails = []
        }*/
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emails) { email in
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
            .refreshable {
                account.fetchFolder(folder)
                updateEmails()
            }
            .task {
                print("fetching folder \(folder.displayName)")
                account.fetchFolder(folder)
                updateEmails()
            }
            
            Text("Select an email")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Inbox")
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
                Button {
                    account.fetchFolder(folder)
                    updateEmails()
                } label: {
                    Image(systemName: "tray.and.arrow.down")
                }
            }
        }
    }
}

#Preview {
    AccountMailboxView(account: MailManager.shared.accounts.first!, folder: .inbox)
}
