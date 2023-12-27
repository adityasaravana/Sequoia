//
//  ContentView.swift
//  Mail
//
//  Created by Jordan Singer on 6/27/20.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Set<Int> = [0]
    var body: some View {
        NavigationView {
            
            List(selection: self.$selection) {
                NavigationLink(destination: InboxView()) {
                    Label("Inbox", systemImage: "tray")
                }
                .tag(0)
                Label("Sent", systemImage: "paperplane")
                Label("Trash", systemImage: "trash")
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            
            Text("Select an email")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
