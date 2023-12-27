//
//  InboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject var postalService: PostalService
    var body: some View {
        NavigationView {
            List {
                ForEach(postalService.inbox) { email in
                    NavigationLink(destination: EmailView(message: email).environmentObject(postalService)) {
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
                Task {
                    postalService.fetch(.icloud, username: Constants.testingUser, password: Constants.testingPwd)
                }
            }
            .task {
                postalService.fetch(.icloud, username: Constants.testingUser, password: Constants.testingPwd)
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
    InboxView().environmentObject(PostalService.shared)
}
