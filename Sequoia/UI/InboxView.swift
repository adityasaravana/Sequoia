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
                ForEach(mailManager.allInboxes) { email in
                    NavigationLink(destination: EmailView(message: email).environmentObject(mailManager)) {
                        VStack(alignment: .leading) {
                            Text(email.header.unsafelyUnwrapped.from.displayName ?? "Unknown").font(.headline)
                            Text(email.header.unsafelyUnwrapped.subject ?? "No Subject").font(.body)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(InsetListStyle())
            .refreshable {
                mailManager.fetch()
            }
            .task {
                mailManager.fetch()
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
        }
    }
}

#Preview {
    InboxView().environmentObject(MailManager.shared)
}
