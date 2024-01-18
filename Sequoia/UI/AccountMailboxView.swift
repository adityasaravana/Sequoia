//
//  AccountMailboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI
import CoreData

struct AccountMailboxView: View {
    @ObservedObject var account: AccountContainer
    private var fetchRequest: FetchRequest<Email>
    private var emails: FetchedResults<Email> { fetchRequest.wrappedValue }

    init(account: AccountContainer, folder: IMAPFolder) {
        self.account = account
        self.folder = folder
        self.fetchRequest = FetchRequest<Email>(
            entity: Email.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Email.sentDate, ascending: false)
            ],
            predicate: NSPredicate(format: "folderName == %@", account.server.folderName(for: folder))
        )
    }

    
    var folder: IMAPFolder
    
    var showTriage: Bool = true
    
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
            MailboxView(mailbox: emails, onAppear: {
                
            }, asyncOnAppear: {
                print("fetching folder \(folder.displayName)")
                // TODO: account.fetchFolder(folder)
                updateEmails()
            }, onRefresh: {
                
                // TODO: account.fetchFolder(folder)
                updateEmails()
            })
        }
        .navigationTitle("Inbox")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                NewEmailButtonView()
            }
            
            if showTriage {
                ToolbarItem(placement: .navigation) {
                    TriageButtonView(isEmpty: emails.isEmpty)
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
                    // TODO: account.fetchFolder(folder)
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
