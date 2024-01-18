//
//  TriageButtonView.swift
//  Sequoia
//
//  Created by NMS15065-8-adisara on 1/10/24.
//

import SwiftUI

struct TriageButtonView: View {
    @Environment(\.openWindow) var openWindow
    
    var isEmpty: Bool
    var body: some View {
        Button {
            //
            // TODO: This should update filters?
            // triageContent = mailbox
            //
            openWindow(id: "triage")
        } label: {
            Image(systemName: "rectangle.stack")
        }.disabled(isEmpty)
    }
}

#Preview {
    TriageButtonView(isEmpty: false)
}
