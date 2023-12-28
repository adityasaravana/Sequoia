//
//  NewEmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/27/23.
//

import SwiftUI

struct NewEmailView: View {
    @State var to = ""
    @State var cc = ""
    @State var subject = ""
    @State var content = ""
    @State var from = ""
    var body: some View {
        VStack {
            Field(text: $to, label: "To")
            Field(text: $cc, label: "Cc")
            Field(text: $subject, label: "Subject")
            Field(text: $from, label: "From")
            TextEditor(text: $content)
                .scrollContentBackground(.hidden)
        }
        .frame(width: 600, height: 500)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            
            ToolbarItem(placement: .navigation) {
                Button {
                    
                } label: {
                    Image(systemName: "list.dash.header.rectangle")
                }
            }
        }
    }
}

fileprivate struct Field: View {
    @Binding var text: String
    var label: String
    var body: some View {
        VStack {
            HStack {
                Text(label + ":")
                    .bold()
                    .foregroundStyle(.gray)
                
                TextField("", text: $text)
                    .textFieldStyle(.plain)
            }
            Divider()
        }
        .padding(.top, 8)
        .padding(.horizontal)
    }
}

#Preview {
    NewEmailView()
}

#Preview {
    Field(text: .constant("fff"), label: "From")
}
