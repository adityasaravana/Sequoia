//
//  InboxView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: MessageView()) {
                    VStack(alignment: .leading) {
                        Text("Jordan Singer").font(.headline)
                        Text("Hello, World!").font(.body)
                    }
                    .padding(.vertical, 8)
                }
                
                NavigationLink(destination: MessageView()) {
                    VStack(alignment: .leading) {
                        Text("Craig Federighi").font(.headline)
                        Text("lil apps + ").font(.body)
                    }
                    .padding(.vertical, 8)
                }
                
                NavigationLink(destination: MessageView()) {
                    VStack(alignment: .leading) {
                        Text("I build my ideas").font(.headline)
                        Text("I build my ideas #4 - 06/23/20").font(.body)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(InsetListStyle())
            
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
    InboxView()
}
