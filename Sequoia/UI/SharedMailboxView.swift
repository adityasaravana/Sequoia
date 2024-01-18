//
//  MailboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import SwiftUI

struct SharedMailboxView: View {
    @EnvironmentObject var mailManager: MailManager
    
    // TODO: Add appropriate predictes, example:
    // predicate: NSPredicate(format: "c == %@", "value"))
    
    @FetchRequest(
        entity: Email.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Email.sentDate, ascending: true)
        ]
    )
    
    var mailbox: FetchedResults<Email>
    
    var sharedFolder: SharedFolder
    var showTriage: Bool = true
    
    var body: some View {
        NavigationView {
            MailboxView(mailbox: mailbox, onAppear: {
                
            }, asyncOnAppear: {
                mailManager.fetchAllNewMail()
            }, onRefresh: {
                mailManager.fetchAllNewMail()
            })
        }
        .navigationTitle(sharedFolder.displayName)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                NewEmailButtonView()
            }
            
            if showTriage {
                ToolbarItem(placement: .navigation) {
                    TriageButtonView(isEmpty: mailbox.isEmpty)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Button {
                    
                } label: {
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Button {
                    
                } label: {
                    Image(systemName: "trash")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Button {
                    mailManager.fetchAllNewMail()
                } label: {
                    Image(systemName: "tray.and.arrow.down")
                }
            }
        }
    }
}


#Preview {
    SharedMailboxView(sharedFolder: .allInboxes)
        .environmentObject(MailManager.shared)
}

