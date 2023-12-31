//
//  EmailView.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/26/23.
//

import MailCore
import SwiftUI

struct EmailView: View {
    var emailEntity: Email

    var body: some View {
        VStack {
            EmailBodyView(emailEntity: emailEntity)
        }
    }
}

struct EmailBodyView: View {
    var emailEntity: Email

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
