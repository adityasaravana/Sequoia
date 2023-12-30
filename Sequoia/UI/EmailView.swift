//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import MailCore
import SwiftUI

struct EmailView: View {
    var emailId: UInt32

    @FetchRequest var fetchedEmail: FetchedResults<EmailEntity>

    init(emailId: UInt32) {
        self.emailId = emailId
        self._fetchedEmail = FetchRequest<EmailEntity>(
            entity: EmailEntity.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "uid == %ld", emailId)
        )
    }

    var body: some View {
        VStack {
            if let emailEntity = fetchedEmail.first {
                EmailBodyView(emailEntity: emailEntity)
            }
        }
    }
}

struct EmailBodyView: View {
    var emailEntity: EmailEntity

    private func loadEmailBody(from filePath: String) -> String? {
        do {
            return try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            print("Error loading email body: \(error)")
            return nil
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let bodyFilePath = emailEntity.bodyFileReference,
                   let bodyContent = loadEmailBody(from: bodyFilePath)
                {
                    HTMLStringView(htmlContent: bodyContent)
                }

                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
