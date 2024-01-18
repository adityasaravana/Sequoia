//
//  MailboxView.swift
//  Sequoia
//
//  Created by NMS15065-8-adisara on 1/9/24.
//

import SwiftUI

struct MailboxView: View {
    var mailbox: FetchedResults<Email>
    
    
    let onAppear: (() -> ())?
    let asyncOnAppear: (() -> ())?
    let onRefresh: (() -> ())?
    
    public init(
        mailbox: FetchedResults<Email>,
        onAppear: (() -> ())? = nil,
        asyncOnAppear: (() -> ())? = nil,
        onRefresh: (() -> ())? = nil
    ) {
        self.mailbox = mailbox
        self.onAppear = onAppear
        self.asyncOnAppear = asyncOnAppear
        self.onRefresh = onRefresh
    }
    
    var body: some View {
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
            if let action = onAppear {
                action()
            }
        }
        .refreshable {
            if let action = onRefresh {
                action()
            }
        }
        .task {
            if let action = asyncOnAppear {
                action()
            }
        }
        
        Text("Select an email")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
