//
//  InboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject var mailManager: MailManager
    var body: some View {
        NavigationView {
            List {
                ForEach(mailManager.accounts.first!.inbox) { email in
                    NavigationLink(destination: EmailView(email: email).environmentObject(mailManager)) {
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
                mailManager.fetchNewMail(.inbox)
            }
            .task {
                mailManager.fetchNewMail(.inbox)
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
                RefreshButton(.inbox).environmentObject(mailManager)
            }
        }
    }
}

#Preview {
    InboxView().environmentObject(MailManager.shared)
}
