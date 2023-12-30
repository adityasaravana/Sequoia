//
//  TriageView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/29/23.
//

import CardStack
import Defaults
import SwiftUI

struct TriageView: View {
    @Default(.showTriageKeybindGuide) var showTriageKeybindGuide
    @Binding var emails: [Email]
    @State var message = "You haven't hit a key yet"

    private let keyMessages: [CGKeyCode: String] = [
        .kVK_ANSI_A: "A",
        .kVK_ANSI_S: "S",
        .kVK_ANSI_D: "D",
        .kVK_ANSI_U: "U"
    ]

    var body: some View {
        ZStack {
            Color.cardBackground
            VStack {
                Text(message)
                    .font(.largeTitle)
                CardView(email: emails.first ?? .init(account: .init(.icloud, username: "", password: ""), message: .init()))

                if showTriageKeybindGuide {
                    Image(.triageKeybindGuide)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button("Hide this cheatsheet") {
                        withAnimation {
                            showTriageKeybindGuide = false
                        }
                    }
                } else {
                    Button("How do I do this?") {
                        withAnimation {
                            showTriageKeybindGuide = true
                        }
                    }
                    Text("You can get rid of this button in Settings.")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .frame(width: 600, height: 600)
        }.onAppear {
            NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                if let keyMessage = keyMessages[CGKeyCode(Int(event.keyCode))] {
                    self.message = "You've hit the \(keyMessage) key"
                }
                return event
            }
        }
    }
}

struct CardView: View {
    var emailEntity: EmailEntity
    var body: some View {
        VStack {
            HStack {
                Text(email.message.header.unsafelyUnwrapped.subject ?? "No Subject")
                    .bold()
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text(email.message.header?.from?.displayName ?? "Unknown")
                    .font(.title3)
                    .foregroundColor(.accentColor)
                Spacer()
            }
            .padding(.bottom, 40)

            EmailBodyView(emailEntity: EmailEntity).cornerRadius(12).padding()

            Spacer()
        }
        .padding(20)
        .multilineTextAlignment(.leading)
        .background(.ultraThinMaterial)
        .frame(width: 450, height: 250)
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    TriageView(emails: .constant(MailManager.shared.allInboxes))
        .onAppear { Defaults[.showTriageKeybindGuide] = true }
}

#Preview {
    TriageView(emails: .constant(MailManager.shared.allInboxes))
        .onAppear { Defaults[.showTriageKeybindGuide] = false }
}

#Preview {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [.white, .red, .black]), startPoint: .leading, endPoint: .trailing)
        CardView(email: .init(account: .init(.icloud, username: "", password: ""), message: .init()))
    }
}
